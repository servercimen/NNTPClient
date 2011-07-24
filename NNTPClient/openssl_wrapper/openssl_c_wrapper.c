#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>



#include <openssl/rand.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

// Simple structure to keep track of the handle, and
// of what needs to be freed later.
typedef struct {
    int socket;
    SSL *sslHandle;
    SSL_CTX *sslContext;
} connection;

int log_ssl(void)
{
    char buf[256];
    u_long err;
    
    while ((err = ERR_get_error()) != 0) {
        ERR_error_string_n(err, buf, sizeof(buf));
        printf("*** %s\n", buf);
    }
    
    return (0);
}
// Establish a regular tcp connection
int tcpConnect (const char * serverName, int port)
{
    int error, handle;
    struct hostent *host;
    struct sockaddr_in server;
    
    host = gethostbyname (serverName);
    handle = socket (AF_INET, SOCK_STREAM, 0);
    if (handle == -1)
    {
        perror ("Socket");
        handle = 0;
    }
    else
    {
        server.sin_family = AF_INET;
        server.sin_port = htons (port);
        server.sin_addr = *((struct in_addr *) host->h_addr);
        bzero (&(server.sin_zero), 8);
        
        error = connect (handle, (struct sockaddr *) &server,
                         sizeof (struct sockaddr));
        if (error == -1)
        {
            perror ("Connect");
            handle = 0;
        }
    }
    
    return handle;
}

// Establish a connection using an SSL layer
connection *sslConnect (const char* server, int port)
{
    connection *c;
    
    c = malloc (sizeof (connection));
    c->sslHandle = NULL;
    c->sslContext = NULL;
    
    c->socket = tcpConnect (server, port);
    if (c->socket)
    {
        // Register the error strings for libcrypto & libssl
        SSL_load_error_strings ();
        // Register the available ciphers and digests
        SSL_library_init ();
        
        // New context saying we are a client, and using SSL 2 or 3
        c->sslContext = SSL_CTX_new (SSLv2_client_method ());
        
        if (c->sslContext == NULL)
            ERR_print_errors_fp (stderr);
        
        // Create an SSL struct for the connection
        c->sslHandle = SSL_new (c->sslContext);
        if (c->sslHandle == NULL){
            ERR_print_errors_fp (stderr);
            log_ssl();
        }
        
        
        // Connect the SSL struct to our connection
        if (!SSL_set_fd (c->sslHandle, c->socket)){
            ERR_print_errors_fp (stderr);
            log_ssl();
        }
        
        // Initiate SSL handshake
        if (SSL_connect (c->sslHandle) != 1){
            ERR_print_errors_fp (stderr);
            log_ssl();
        }
    }
    else
    {
        perror ("Connect failed");
    }
    
    return c;
}

// Disconnect & free connection struct
void sslDisconnect (connection *c)
{
    if (c->socket)
        close (c->socket);
    if (c->sslHandle)
    {
        SSL_shutdown (c->sslHandle);
        SSL_free (c->sslHandle);
    }
    if (c->sslContext)
        SSL_CTX_free (c->sslContext);
    
    free (c);
}



// Read all available text from the connection
char *sslRead (connection *c)
{
//    pthread_mutex_lock( &mutex1 );

    const int readSize = 1024;
    char *rc = NULL;
    int received, count = 0;
    char buffer[1025];
    
    if (c)
    {
        while (1)
        {

            if (!rc)
                rc = malloc (readSize * sizeof (char) + 1);
            else
                rc = realloc (rc, (count + 1) *
                              readSize * sizeof (char) + 1);
            received = SSL_read (c->sslHandle, buffer, readSize);
            if(received >= 0){
                buffer[received] = '\0';
            }
            if (received > 0){
                strcat (rc, buffer);
                memset(buffer, '\0', sizeof(char) * 1025);
            }
            
            if(received < 0){
                free(rc);
                rc = NULL;
                log_ssl();
            }
            
            if (received < readSize)
                break;
            
            
            count++;
        }
    }
    
    return rc;
}

// Write text to the connection
void sslWrite (connection *c, const char *text)
{
    if (c)
        SSL_write (c->sslHandle, text, strlen (text));
}

int sslIsConnected(connection *c) {
    if (c->sslContext == NULL)
        return 0;
    
    if (c->sslHandle == NULL)
        return 0;
    
    return 1;
    
}



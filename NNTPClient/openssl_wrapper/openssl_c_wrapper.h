//
//  openssl_c_wrapper.h
//  NNTPClient
//
//  Created by Server Cimen on 7/23/11.
//  Copyright 2011 SpeedDate.com. All rights reserved.
//
#include <openssl/ssl.h>

typedef struct {
    int socket;
    SSL *sslHandle;
    SSL_CTX *sslContext;
} connection;


// Establish a connection using an SSL layer
connection *sslConnect (const char *, int);
// Disconnect & free connection struct
void sslDisconnect (connection *c);
// Read all available text from the connection
char *sslRead (connection *c);

// Write text to the connection
void sslWrite (connection *c, const char *text);
int sslIsConnected(connection *c);
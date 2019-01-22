//
//  WebServer.m
//  Suggested
//
//  Created by Kyrill Cousson on 13/12/13.
//

#import "WebServer.h"


@implementation WebServer

@synthesize delegate;

- (void)postFunction:(NSURL *) url withParameters:(NSDictionary *) parameters withLogin:(NSString*)login password:(NSString*)password {
    [self postFunction:url withParameters:parameters withLogin:login password:password callbackBlock:nil];
}

- (void)postFunction:(NSURL *) url withParameters:(NSDictionary *) parameters withLogin:(NSString*)login password:(NSString*)password callbackBlock:(void (^)(id responseObject, BOOL success))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (login && password) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:login password:password];
    }
    [manager POST:[url absoluteString] parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (self->delegate != nil)
            [self->delegate didReceiveServerJSONResponse:responseObject from:self];
        else
            NSLog(@"WebServer.postFunction.delegate == nil for request with response:%@", responseObject);
        if (callback != nil)
            callback(responseObject, true);
            
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@ - %@", [error localizedDescription], [error userInfo]);
        NSLog(@"err : %@", [[error userInfo] objectForKey:@"NSLocalizedRecoverySuggestion"]);
        if (self->delegate != nil)
            [self->delegate didReceiveServerJSONError:[error localizedDescription] from:self];
        else
            NSLog(@"WebServer.postFunction.delegate == nil for request with error response:%@", [error localizedDescription]);
        if (callback != nil)
            callback(error, true);
    }];
}

- (void)postFunction:(NSURL *) url withParameters:(NSDictionary *) parameters {
    [self postFunction:url withParameters:parameters withLogin:nil password:nil];
}

- (void)getFunction:(NSURL *) url withParameters:(NSMutableDictionary *) parameters {
    [self getFunction:url withParameters:parameters withLogin:nil password:nil];
}

- (void)getFunction:(NSURL *) url withParameters:(NSMutableDictionary *) parameters withLogin:(NSString*)login password:(NSString*)password {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (login && password){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:login password:password];
    }
    [manager GET:[url absoluteString] parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (self->delegate != nil)
            [self->delegate didReceiveServerJSONResponse:responseObject from:self];
        else
            NSLog(@"WebServer.getFunction.delegate == nil for request with response:%@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@ - %@", [error localizedDescription], [error userInfo]);
        NSLog(@"err : %@", [[error userInfo] objectForKey:@"NSLocalizedRecoverySuggestion"]);
        if (self->delegate != nil)
            [self->delegate didReceiveServerJSONError:[error localizedDescription] from:self];
        else
            NSLog(@"WebServer.getFunction.delegate == nil for request with error response:%@", [error localizedDescription]);
    }];
}

- (void)getFunction:(NSURL *) url withParameters:(NSMutableDictionary *) parameters withToken:(NSString*)token {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    [manager GET:[url absoluteString] parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (self->delegate != nil)
            [self->delegate didReceiveServerJSONResponse:responseObject from:self];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@ - %@", [error localizedDescription], [error userInfo]);
        NSLog(@"err : %@", [[error userInfo] objectForKey:@"NSLocalizedRecoverySuggestion"]);
        NSLog(@"operation.responseData:%@",operation.response);
        [self->delegate didReceiveServerJSONError:[error localizedDescription] from:self];
    }];
}

@end

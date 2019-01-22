//
//  WebServer.h
//  Suggested
//
//  Created by Kyrill Cousson on 13/12/13.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@protocol WebServerDelegate

- (void) didReceiveServerJSONResponse:(id) JSON from:(id) sender;
- (void) didReceiveServerJSONError:(NSString *) error_code from:(id) sender;

@end

@interface WebServer : NSObject {
    id<WebServerDelegate> delegate;
}

@property (nonatomic) id<WebServerDelegate> delegate;
@property (nonatomic) BOOL noError;

- (void) postFunction:(NSURL *)url withParameters:(NSDictionary *)parameters;
- (void) postFunction:(NSURL *)url withParameters:(NSDictionary *)parameters withLogin:(NSString*)login password:(NSString*)password;
- (void) postFunction:(NSURL *)url withParameters:(NSDictionary *)parameters withLogin:(NSString*)login password:(NSString*)password callbackBlock:(void (^)(id responseObject, BOOL success))callback;

- (void) getFunction:(NSURL *)url withParameters:(NSDictionary *)parameters;
- (void) getFunction:(NSURL *)url withParameters:(NSMutableDictionary *)parameters withLogin:(NSString*)login password:(NSString*)password;
- (void) getFunction:(NSURL *)url withParameters:(NSMutableDictionary *)parameters withToken:(NSString*)token;

@end

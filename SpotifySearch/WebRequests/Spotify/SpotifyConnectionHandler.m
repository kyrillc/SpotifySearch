//
//  SpotifyConnectionHandler.m
//  Suggested
//
//  Created by Kyrill Cousson on 14/04/2018.
//

#import "SpotifyConnectionHandler.h"

@implementation SpotifyConnectionHandler
static SpotifyConnectionHandler *spotifyConnectionHandler;

+ (SpotifyConnectionHandler *)sharedInstance {
    
    if (!spotifyConnectionHandler) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            spotifyConnectionHandler = [[SpotifyConnectionHandler alloc] init];
        });
    }
    return spotifyConnectionHandler;
}

- (id)init {
    self = [super init];
    return self;
}

- (void)setAccessToken:(NSString *)accessToken withExpirationDate:(NSDate*)expirationDate {
    self.accessToken = accessToken;
    self.tokenExpirationDate = expirationDate;
}

- (BOOL)accessTokenIsValid {
    
    //if ([self.tokenExpirationDate earlierDate:[NSDate date]] != self.tokenExpirationDate): Now is earlier than expirationDate -> not expired yet
    //else: Expiration date is earlier than now -> expired
    
    return (self.accessToken != nil && self.tokenExpirationDate != nil && [self.tokenExpirationDate earlierDate:[NSDate date]] != self.tokenExpirationDate);
}

@end

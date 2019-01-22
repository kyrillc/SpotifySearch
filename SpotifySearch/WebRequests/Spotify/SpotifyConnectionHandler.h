//
//  SpotifyConnectionHandler.h
//  Suggested
//
//  Created by Kyrill Cousson on 14/04/2018.
//

#import <Foundation/Foundation.h>


@interface SpotifyConnectionHandler : NSObject

@property (nonatomic, strong) NSString *accessToken;
@property (nonnull, strong) NSDate *tokenExpirationDate;

+ (SpotifyConnectionHandler *)sharedInstance;

- (void)setAccessToken:(NSString *)accessToken withExpirationDate:(NSDate*)expirationDate;
- (BOOL)accessTokenIsValid;

@end

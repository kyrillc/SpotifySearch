//
//  InternetInformationProtocol.h
//  Suggested
//
//  Created by Kyrill Cousson on 21/08/14.
//
//

#import <Foundation/Foundation.h>

#import "NSString+Common.h"
#import "SpotifySearch.h"
#import "MusicItem.h"

@protocol InternetInformationDelegate

@optional

/// @param key Key can be one of the following strings: "wikipedia", "deezer", "spotify", "iTunes".
- (void)updateLink:(NSURL*) url forKey:(NSString*)key;

- (void)handleError:(NSString*)errorMessage;

@end


@interface InternetInformationProtocol : NSObject <WebServerDelegate> {
    id<InternetInformationDelegate> delegate;
}

@property (nonatomic) id<InternetInformationDelegate> delegate;
@property (nonatomic, strong) MusicItem *musicItem;
@property (nonatomic, strong) SpotifySearch *spotifySearch;

- (id)initWithMusicItem:(MusicItem*)displayedItem;

- (void)loginToSpotifyService;
- (void)getInternetInformation;

@end

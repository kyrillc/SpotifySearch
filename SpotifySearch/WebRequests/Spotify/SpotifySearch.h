//
//  SpotifySearch.h
//  Suggested
//
//  Created by Kyrill Cousson on 21/01/14.
//
//

#import "MusicItem.h"
#import "WebServer.h"
#import "SpotifyConnectionHandler.h"
#import "Utilities.h"

@interface SpotifySearch : WebServer


@property (nonatomic, assign) MusicSearchMode searchMode;

@property (nonatomic, strong) NSDictionary *itemParametersToSearch;
@property (nonatomic, strong) NSString *baseURL; //Used to make the URL to open the Spotify app
@property (nonatomic, strong) NSString *requestURL;

/// Checks the validity of the Spotify Token.
/// Tries to get a new token if the current token is invalid.
- (void)checkConnection;

/// Checks the validity of the Spotify Token.
/// Tries to get a new token if the current token is invalid.
/// @param callback function to execute once the token has been checked as valid, or retrieved from API
- (void)checkConnectionWithCallback:(void(^)(BOOL success))callback;

- (void)searchSpotifyForItemParameters:(MusicItem*)displayedItem;

/// Returns a URL that can be opened in the Spotify app from the response of the Spotify API.
/// The URL is the URL of the first result of the Spotify search.
- (NSURL*)spotifyURLFromJSON:(NSDictionary*)JSON;

@end

//
//  InternetInformationProtocol.m
//  Suggested
//
//  Created by Kyrill Cousson on 21/08/14.
//
//

#import "InternetInformationProtocol.h"
#import "SpotifyConnectionHandler.h"

@implementation InternetInformationProtocol

@synthesize delegate, spotifySearch;

#pragma mark - Init

- (id)initWithMusicItem:(MusicItem*)musicItem {
    self = [super init];
    if (self) {
        self.musicItem = musicItem;
    }
    return self;
}

#pragma mark - Spotify service

- (void)loginToSpotifyService {
    if (!spotifySearch){
        spotifySearch = [[SpotifySearch alloc] init];
        spotifySearch.delegate = self;
        [spotifySearch performSelectorInBackground:@selector(checkConnection) withObject:nil];
    }
}

#pragma mark -

- (void)getInternetInformation {
    spotifySearch = [[SpotifySearch alloc] init];
    spotifySearch.delegate = self;
    [spotifySearch performSelectorInBackground:@selector(searchSpotifyForItemParameters:) withObject:self.musicItem];
}

#pragma mark - Responses

#pragma mark - JSON Server Responses

- (void)didReceiveServerJSONResponse:(id)JSON from:(id)sender {

    NSDictionary *responseDict = (NSDictionary*) JSON;

    if ([sender isKindOfClass:[SpotifySearch class]]) {
        [self didReceiveSpotifyResponse:responseDict];
    }
    else {
        NSLog(@"responseDict:%@", responseDict);
    }
}

- (void)didReceiveServerJSONError:(NSString *)errorCode from:(id)sender {
    NSLog(@"didReceiveServerJSONError:%@", errorCode);
    
    if ([sender isKindOfClass:[SpotifySearch class]]) {
        [self didReceiveSpotifyResponse:nil];
        [delegate handleError:[NSString stringWithFormat:@"Spotify error: %@", errorCode]];
    }
    else
        [delegate handleError:[NSString stringWithFormat:@"Error: %@", errorCode]];
}

#pragma mark - Responses Interpretations

- (void)didReceiveSpotifyResponse:(NSDictionary*)responseDict {
    NSLog(@"didReceiveSpotifyResponse");
    //NSLog(@"Spotify response : %@", responseDict);
    
    if ([spotifySearch.requestURL isEqualToString:@"https://accounts.spotify.com/api/token"]) {
        // Handle Token response
        
        NSString *access_token = [responseDict objectForKey:@"access_token"];
        int expires_in = [[responseDict objectForKey:@"expires_in"] intValue];
        NSDate *expirationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:expires_in];
        [[SpotifyConnectionHandler sharedInstance] setAccessToken:access_token withExpirationDate:expirationDate];
    }
    else {
        // Handle response of Spotify search
        
        NSURL *spotifyResultURL = [spotifySearch spotifyURLFromJSON:responseDict];
        spotifySearch = nil;
        
        if (spotifyResultURL)
            [delegate updateLink:spotifyResultURL forKey:@"spotifyURL"];
        else
            [delegate handleError:@"Spotify error: No URL"];
    }
}

@end

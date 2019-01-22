//
//  SpotifySearch.m
//  Suggested
//
//  Created by Kyrill Cousson on 21/01/14.
//
//


// API : https://developer.spotify.com/web-api/search-item/
// Example URL : https://api.spotify.com/v1/search?q=blur+song+2&type=track

#import "SpotifySearch.h"

@implementation SpotifySearch

@synthesize itemParametersToSearch;
@synthesize searchMode;
@synthesize baseURL, requestURL;

static NSString * const kSpotify_clientId = @"";
static NSString * const kSpotify_clientSecret = @"";

- (void)checkConnection {
    [self checkConnectionWithCallback:nil];
}

- (void)checkConnectionWithCallback:(void(^)(BOOL success))callback {
   
    if ([[SpotifyConnectionHandler sharedInstance] accessTokenIsValid] && callback != nil) {
        // checkConnectionWithCallback...accessToken is set already -> continue
        callback(true);
    } else {
        // checkConnectionWithCallback...accessToken is not set -> get it
        [self getSpotifyTokenWithCallback:callback];
    }
}

- (void)searchSpotifyForItemParameters:(MusicItem*)musicItem {
    
    [self checkConnectionWithCallback:^(BOOL success) {
        if (success) {
            
            self->requestURL = [NSString stringWithFormat:@"https://api.spotify.com/v1/search"];
            self->searchMode = MusicSearchModeNone;
            self->itemParametersToSearch = [musicItem toDictionary];
            
            NSString *searchTerms =  [Utilities searchTermsForItemParameters:self->itemParametersToSearch withWordsSeparator:@" " separateAllWords:YES sanitizeForQuery:NO];
            searchTerms = [self sanitizedStringForSpotifyFromString:searchTerms];
            
            self->searchMode = [Utilities musicSearchModeForItemParameters:self->itemParametersToSearch];
            [self searchSpotifyForTerms:searchTerms andSearchMode:self->searchMode];
        }
    }];
}

- (NSString*)sanitizedStringForSpotifyFromString:(NSString*)string {
    
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@" "];
    return string;
}

- (void)searchSpotifyForTerms:(NSString*)searchTerms andSearchMode:(MusicSearchMode)searchMode{
    
    NSString *key = @"";
    if (searchMode == MusicSearchModeSong)
        key = @"track";
    else if (searchMode == MusicSearchModeArtist)
        key = @"artist";
    else if (searchMode == MusicSearchModeAlbum)
        key = @"album";
    
    baseURL = [NSString stringWithFormat:@"spotify://%@/", key];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       searchTerms, @"q",
                                       key, @"type", nil];
    
    [super getFunction:[NSURL URLWithString:requestURL] withParameters:parameters withToken:[SpotifyConnectionHandler sharedInstance].accessToken];
}

- (void)getSpotifyTokenWithCallback:(void (^)(BOOL success))callback {
    
    requestURL = [NSString stringWithFormat:@"https://accounts.spotify.com/api/token"];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"client_credentials", @"grant_type", nil];
    [super postFunction:[NSURL URLWithString:requestURL] withParameters:parameters
              withLogin:kSpotify_clientId password:kSpotify_clientSecret callbackBlock:^(id responseObject, BOOL success) {
                  if (success && callback != nil)
                      callback(success);
    }];
}


#pragma mark - Response Handling

- (NSURL*)spotifyURLFromJSON:(NSDictionary*)JSON {

    NSString *dictKey = @"";
    NSString *pageUrlComponent = @"";
    
    if (self->searchMode == MusicSearchModeSong) {
        dictKey = @"tracks";
        pageUrlComponent = @"track";
    }
    else if (self->searchMode == MusicSearchModeArtist) {
        dictKey = @"artists";
        pageUrlComponent = @"artist";
    }
    else if (self->searchMode == MusicSearchModeAlbum) {
        dictKey = @"albums";
        pageUrlComponent = @"album";
    }
    
    NSDictionary *resultsDict = [JSON objectForKey:dictKey];
    
    if (resultsDict == nil)
        return nil;
    
    NSArray *dataArray = [resultsDict objectForKey:@"items"];
    
    if (dataArray && dataArray.count>0) {
        
        NSDictionary *firstResult = [dataArray objectAtIndex:0];
        NSString *hrefLink = [firstResult objectForKey:@"uri"];
        
        if (hrefLink == nil)
            return nil;
        
        NSString *pageId = [hrefLink stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"spotify:%@:", pageUrlComponent] withString:@""];
        return [NSURL URLWithString:[baseURL stringByAppendingString:pageId]];
    }
    
    return nil;
}


@end

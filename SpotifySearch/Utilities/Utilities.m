//
//  Utilities.m
//  Suggested
//
//  Created by Kyrill Cousson on 27/12/2013.
//
//

#import "Utilities.h"

@implementation Utilities

+ (MusicSearchMode)musicSearchModeForItemParameters:(NSDictionary*)itemParametersToSearch {
    
    NSString *itemName = [itemParametersToSearch objectForKey:@"name"];
    NSString *itemRegroupment = [itemParametersToSearch objectForKey:@"regroupment"];
    NSString *itemArtist = [itemParametersToSearch objectForKey:@"artist"];
    
    if ([itemName isNotNullOrEmpty])
        return MusicSearchModeSong;
    else if ([itemRegroupment isNotNullOrEmpty])
        return MusicSearchModeAlbum;
    else if ([itemArtist isNotNullOrEmpty])
        return MusicSearchModeArtist;
    else
        return MusicSearchModeNone;
}

+ (NSString*)searchTermsForItemParameters:(NSDictionary*)itemParametersToSearch withWordsSeparator:(NSString*)separator separateAllWords:(BOOL)separateAll sanitizeForQuery:(BOOL)sanitizeForQuery {
    
    NSMutableArray *searchTerms = [[NSMutableArray alloc] init];
    
    NSString *itemName = [itemParametersToSearch objectForKey:@"name"];
    NSString *itemArtist = [itemParametersToSearch objectForKey:@"artist"];
    NSString *itemRegroupment = [itemParametersToSearch objectForKey:@"regroupment"];
    
    if ([itemName isNotNullOrEmpty])
        [searchTerms addObject:itemName];
    
    if ([itemArtist isNotNullOrEmpty] && ![searchTerms containsObject:itemArtist])
        [searchTerms addObject:itemArtist];

    if ([itemRegroupment isNotNullOrEmpty] && ![searchTerms containsObject:itemRegroupment])
        [searchTerms addObject:itemRegroupment];
    
    
    NSString *searchTermsString = [searchTerms componentsJoinedByString:separator];
    if (separateAll)
        searchTermsString = [searchTermsString stringByReplacingOccurrencesOfString:@" " withString:separator];
    
    if (sanitizeForQuery)
        searchTermsString = [searchTermsString sanitizedStringForURLQuery];
    
    return searchTermsString;
}


@end

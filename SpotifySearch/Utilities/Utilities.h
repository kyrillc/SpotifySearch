//
//  Utilities.h
//  Suggested
//
//  Created by Kyrill Cousson on 27/12/2013.
//
//

#import <Foundation/Foundation.h>

#import "NSString+Common.h"

@interface Utilities : NSObject

typedef NS_ENUM(NSInteger, MusicSearchMode) {
    MusicSearchModeSong,
    MusicSearchModeArtist,
    MusicSearchModeAlbum,
    MusicSearchModeNone
};


/// Used to indicate what to search for depending on the given search parameters.
+ (MusicSearchMode)musicSearchModeForItemParameters:(NSDictionary*)itemParametersToSearch;

/// Transforms the search terms into a string usable in requests.
/// @param itemParametersToSearch A dictionary with the possible keys: "name", "artist", "regroupment".
/// @param separator A string used to separate the search terms in the resulting string.
/// @param separateAll A boolean indicating wether the separator should only be used to separate the search terms, or also to separate every words inside the search terms.
/// @param sanitizeForQuery Sanitize the resulting string to make it ready to be included in a query.
+ (NSString*)searchTermsForItemParameters:(NSDictionary*)itemParametersToSearch withWordsSeparator:(NSString*)separator separateAllWords:(BOOL)separateAll sanitizeForQuery:(BOOL)sanitizeForQuery;

@end

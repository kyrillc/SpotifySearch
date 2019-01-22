//
//  NSString+Common.h
//  Suggested
//
//  Created by Kyrill Cousson on 07/08/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (BOOL)isNotNullOrEmpty;
- (NSString *)stringByStrippingWhitespace;

/// Complements stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet by replacing '&' with '%26'.
- (NSString *)sanitizedStringForURLQuery;

@end

//
//  NSString+Common.m
//  Suggested
//
//  Created by Kyrill Cousson on 07/08/14.
//
//

#import "NSString+Common.h"

@implementation NSString (Common)


- (BOOL)isNotNullOrEmpty {
    if(self == NULL || [self isKindOfClass:[NSNull class]] || self == (id)[NSNull null] || [[self stringByStrippingWhitespace] isEqualToString:@""] || [[self stringByStrippingWhitespace] isEqualToString:@"(null)"]){
        return NO;
    }
    return YES;
}

- (NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)sanitizedStringForURLQuery {
    return [[self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
}

@end

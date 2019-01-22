//
//  MusicItem.m
//  Suggested
//
//  Created by Kyrill Cousson on 23/07/2018.
//

#import "MusicItem.h"

@implementation MusicItem

- (id)initWithName:(NSString*)name artistName:(NSString*)artistName andRegroupmentName:(NSString*)regroupmentName {
    self = [super init];
    if (self) {
        self.name = name;
        self.artist = artistName;
        self.regroupment = regroupmentName;
    }
    return self;
}

- (NSDictionary*)toDictionary {
    return [[NSDictionary alloc] initWithObjectsAndKeys:
                          self.name, @"name",
                          self.artist, @"artist",
                          self.regroupment, @"regroupment",
                          nil];
}

@end

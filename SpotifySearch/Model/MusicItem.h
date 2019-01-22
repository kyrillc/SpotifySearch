//
//  MusicItem.h
//  Suggested
//
//  Created by Kyrill Cousson on 23/07/2018.
//

#import <Foundation/Foundation.h>

@interface MusicItem : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * regroupment;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * genre;


- (id)initWithName:(NSString*)name artistName:(NSString*)artistName andRegroupmentName:(NSString*)regroupmentName;

- (NSDictionary*)toDictionary;

@end

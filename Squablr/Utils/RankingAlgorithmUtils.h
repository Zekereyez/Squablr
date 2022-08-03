//
//  RankingAlgorithmUtils.h
//  Squablr
//
//  Created by Zeke Reyes on 8/2/22.
//8

#import <Foundation/Foundation.h>
#import "Profile.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankingAlgorithmUtils : NSObject

+ (void) sortProfilesByCompatibility: (NSMutableArray *) profiles;

@end

NS_ASSUME_NONNULL_END

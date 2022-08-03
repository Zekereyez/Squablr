//
//  Utility.h
//  Squablr
//
//  Created by Zeke Reyes on 8/2/22.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseUtils : NSObject

+ (Profile *) getCurrentUserProfileInfo;
+ (void) saveLikeToParse:(Profile *) likedUserProfile;
+ (bool) likedUserProfileHasMatchedWithUser:(Profile *) likedUserProfile;

@end

NS_ASSUME_NONNULL_END

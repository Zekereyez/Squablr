//
//  Utility.m
//  Squablr
//
//  Created by Zeke Reyes on 8/2/22.
//

#import "ParseUtils.h"

@implementation ParseUtils

+ (Profile *) getCurrentUserProfileInfo {
    PFQuery *currentUserProfileQuery = [PFQuery queryWithClassName:@"Profile"];
    [currentUserProfileQuery whereKey:@"name" equalTo:[PFUser currentUser].username];
    // fetch data asynchronously
    Profile *profile = [currentUserProfileQuery getFirstObject];
    return profile;
}



@end

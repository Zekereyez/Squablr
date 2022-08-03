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

+ (void) saveLikeToParse:(Profile *) likedUserProfile {
    // Get user profile
    Profile *userProfile = [self getCurrentUserProfileInfo];
    // check if profile["likes"] doesnt have the user liked already
    if (! [userProfile[@"Likes"] containsObject:likedUserProfile.objectId] ) {
        // copy the array of likes since we cant write innit directly
        NSMutableArray *userLikedProfiles = [[NSMutableArray alloc] initWithArray:userProfile[@"Likes"] copyItems:YES];
        // add the profile object id into the copy of array
        [userLikedProfiles addObject:likedUserProfile.objectId];
        // load that array as the user profile liked array
        userProfile[@"Likes"] = userLikedProfiles;
        // Save changes to parse
        [userProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully saved like");
            }
        }];
    }
}



@end

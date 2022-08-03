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
    Profile *currentUserProfile = [self getCurrentUserProfileInfo];
    // check if profile["likes"] doesnt have the user liked already
    NSArray<NSString *>* currentUserLikes = currentUserProfile[@"Likes"];
    if (! [currentUserLikes containsObject:likedUserProfile.objectId] ) {
        // copy the array of likes since we cant write innit directly
        NSMutableArray *currentUserNewLikes = [[NSMutableArray alloc] initWithArray:currentUserLikes copyItems:YES];
        // add the profile object id into the copy of array
        [currentUserNewLikes addObject:likedUserProfile.objectId];
        // load that array as the user profile liked array
        currentUserProfile[@"Likes"] = currentUserNewLikes;
        // Save changes to parse
        [currentUserProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
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

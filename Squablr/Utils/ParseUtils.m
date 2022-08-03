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
        [currentUserProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
    }
}

+ (bool) likedUserProfileHasMatchedWithUser:(Profile *) likedUserProfile {
    // Get current user profile info
    Profile *currentUserProfile = [self getCurrentUserProfileInfo];
    // Get the array of users that the liked profile has previously liked
    NSArray<NSString *> *likedProfileArrayOfLikes = likedUserProfile[@"Likes"];
    // Check if the current user profile is in the array
    if ( [likedProfileArrayOfLikes containsObject:currentUserProfile.objectId] ) {
        // Since both users have matched we need to update both lists of matches
        // Copy over the array of both user's matches
        NSMutableArray *likedProfileMatches = [[NSMutableArray alloc] initWithArray:likedUserProfile[@"Matches"] copyItems:YES];
        NSMutableArray<NSString *> *currentUserProfileMatches = [[NSMutableArray alloc] initWithArray:currentUserProfile[@"Matches"] copyItems:YES];
        // Add each others object id into their respective array
        [likedProfileMatches addObject:currentUserProfile.objectId];
        [currentUserProfileMatches addObject:likedUserProfile.objectId];
        // Update the parse arrays
        likedUserProfile[@"Matches"] = likedProfileMatches;
        currentUserProfile[@"Matches"] = currentUserProfileMatches;
        // Save changes to parse
        [likedUserProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
        [currentUserProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
        
        return true; // what a chad
    }
    else {
        return false; // sorry bud maybe next time
    }
}



@end

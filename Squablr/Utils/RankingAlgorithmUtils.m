//
//  RankingAlgorithmUtils.m
//  Squablr
//
//  Created by Zeke Reyes on 8/2/22.
//

#import "RankingAlgorithmUtils.h"
#import "ParseUtils.h"

@implementation RankingAlgorithmUtils

+ (double) _weightCalculation:(NSNumber *) userOnFeedWeight withCurrentUserWeight: (NSNumber *) currentUserWeight;{
    NSInteger *weightDiff = (currentUserWeight.integerValue - userOnFeedWeight.integerValue);
//    NSNumber *difference = currentUserWeight. - currentUserOnFeedWeight;
    NSNumber *weight = [NSNumber numberWithInteger:weightDiff];
//    NSLog(@"%@", @"Weight: ");
//    NSLog(@"%i", weightDiff);
//    NSLog(@"%@", @"USER: ");
//    NSLog(@"%@", currentUserWeight);
    if (weight == 0) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        weight = @2;
    }
    double w = [weight doubleValue];
    double weightSquared = pow(w, 2);
    return (1 / weightSquared);
}

+ (double) _experienceCalculation:(NSNumber *) userOnFeedExp withCurrentUserExperience: (NSNumber *) currentUserExp {
    NSInteger *expDiff = (currentUserExp.integerValue - userOnFeedExp.integerValue);
//    NSNumber *difference = currentUserWeight. - currentUserOnFeedWeight;
    NSNumber *experienceToNumber = [NSNumber numberWithInteger:expDiff];
//    NSLog(@"%@", @"Exp difference: ");
//    NSLog(@"%i", expDiff);
//    NSLog(@"%@", @"USER exp: ");
//    NSLog(@"%@", currentUserExp);
    if (experienceToNumber == 0) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        experienceToNumber = @2;
    }
    double w = [experienceToNumber doubleValue];
    double weightSquared = pow(w, 2);
    return (1 / weightSquared);
}

+ (void) sortProfilesByCompatibility: (NSMutableArray *) profiles {
    // send the profiles to compute compatibility scores for profiles function
    // the function is going to return a dictionary that we need for sorting
    // we sort the profiles array with a comparator
    NSMutableDictionary *compatibilityScoresWithUsers = [self _computeCompatibilityScoresForProfiles:profiles];
    
}

+ (NSMutableDictionary<NSString *, NSNumber *> *) _computeCompatibilityScoresForProfiles:(NSMutableArray *) profiles {
    // Get the current user profile information
    Profile* currentUserProfile = [ParseUtils getCurrentUserProfileInfo];
    // Extract user information for util functions
    NSMutableDictionary<NSString *, NSNumber *> *compatibilityScoresWithUsers = [[NSMutableDictionary alloc] init];
    for (Profile *unscoredUser in profiles) {
        double score = [self _computeCompatibilityScoreForProfile:unscoredUser withCurrentUserProfile:currentUserProfile];
        // Put the score into the dictionary with the user
        [compatibilityScoresWithUsers setValue:[NSNumber numberWithDouble:score] forKey:unscoredUser.objectId];
    }
    // return the dictionary with user information
    return compatibilityScoresWithUsers;
}

+ (double) _computeCompatibilityScoreForProfile:(Profile *) userProfileFromFeed withCurrentUserProfile:(Profile *) currentUserProfile {
    double weightScore = [self _weightCalculation:userProfileFromFeed.weightClass withCurrentUserWeight:currentUserProfile.weightClass];
    double experienceScore = [self _experienceCalculation:userProfileFromFeed.experience withCurrentUserExperience:currentUserProfile.experience];
    return weightScore + experienceScore;
}


@end

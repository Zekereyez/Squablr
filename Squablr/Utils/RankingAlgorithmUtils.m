//
//  RankingAlgorithmUtils.m
//  Squablr
//
//  Created by Zeke Reyes on 8/2/22.
//

#import "RankingAlgorithmUtils.h"
#import "ParseUtils.h"

@implementation RankingAlgorithmUtils

static const double _WEIGHT_DIFFERENTIAL_EXPONENT = 2;
static const double _EXPERIENCE_DIFFERENTIAL_EXPONENT = 1.5;

static const double _WEIGHT_MULTIPLIER = 0.3;
static const double _EXPERIENCE_MULTIPLIER = 0.7;

+ (void) sortProfilesByCompatibility: (NSMutableArray *) profiles {
    // send the profiles to compute compatibility scores for profiles function
    // the function is going to return a dictionary that we need for sorting
    NSMutableDictionary *compatibilityScoresWithUsers = [self _computeCompatibilityScoresForProfiles:profiles];
    // We sort the profiles array with a comparator
    [profiles sortUsingComparator:^NSComparisonResult(Profile *p1, Profile *p2){
        double p1Score = [compatibilityScoresWithUsers[p1.objectId] doubleValue];
        double p2Score = [compatibilityScoresWithUsers[p2.objectId] doubleValue];
        if (p1Score > p2Score) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if (p1Score < p2Score) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
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
    return _WEIGHT_MULTIPLIER * weightScore + _EXPERIENCE_MULTIPLIER * experienceScore;
}

+ (double) _weightCalculation:(NSNumber *) userOnFeedWeight withCurrentUserWeight: (NSNumber *) currentUserWeight;{
//    NSNumber *difference = currentUserWeight. - currentUserOnFeedWeight;
    double weightDifferential = currentUserWeight.integerValue - userOnFeedWeight.integerValue;
    if (weightDifferential < 1) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        weightDifferential = 1;
    }
    double weightExponentiation = pow(weightDifferential, _WEIGHT_DIFFERENTIAL_EXPONENT);
    double inverseweightExponentiation = (1 / weightExponentiation);
    return inverseweightExponentiation;
}

+ (double) _experienceCalculation:(NSNumber *) userOnFeedExp withCurrentUserExperience: (NSNumber *) currentUserExp {
    double experienceDifferential = (currentUserExp.integerValue - userOnFeedExp.integerValue);
    if (experienceDifferential < 1) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        experienceDifferential = 1;
    }
    double experienceExponentiation = pow(experienceDifferential, _EXPERIENCE_DIFFERENTIAL_EXPONENT);
    double inversedExponentiation = (1 / experienceExponentiation);
    return inversedExponentiation;
}

@end

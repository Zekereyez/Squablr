//
//  Likes.m
//  Squablr
//
//  Created by Zeke Reyes on 8/3/22.
//

#import "Like.h"

@implementation Like

@dynamic objectIdOfLiker;
@dynamic objectIdOfLiked;

+ (nonnull NSString *) parseClassName {
    return @"Likes";
}

+ (void) saveLikeToParse:(NSString * _Nullable) userWhoLiked withUserWhoWasLiked: (NSString * _Nullable) likedUser withCompletion: (PFBooleanResultBlock _Nullable) completion {
    Like *newLike = [Like new];
    
    newLike.objectIdOfLiker = objectIdOfLiker;
    newLike.objectIdOfLiked = objectIdOfLiked;
    
    [newLike saveInBackgroundWithBlock:completion];
}

@end

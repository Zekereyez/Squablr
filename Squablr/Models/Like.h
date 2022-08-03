//
//  Likes.h
//  Squablr
//
//  Created by Zeke Reyes on 8/3/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Like : PFObject

@property (nonatomic, strong) NSString *objectIdOfLiker;
@property (nonatomic, strong) NSString *objectIdOfLiked;

//+ (void)

@end

NS_ASSUME_NONNULL_END

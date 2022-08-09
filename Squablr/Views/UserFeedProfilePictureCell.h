//
//  UserFeedProfilePictureCell.h
//  Squablr
//
//  Created by Zeke Reyes on 8/9/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserFeedProfilePictureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *matchedUserProfileImage;

@end

NS_ASSUME_NONNULL_END

//
//  MatchedProfileCell.h
//  Squablr
//
//  Created by Zeke Reyes on 8/8/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchedProfileCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *matchedUserProfileImage;

@end

NS_ASSUME_NONNULL_END

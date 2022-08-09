//
//  ProfilePictureCell.h
//  Squablr
//
//  Created by Zeke Reyes on 7/14/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfilePictureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;

@end

NS_ASSUME_NONNULL_END

//
//  CardView.h
//  Squablr
//
//  Created by Zeke Reyes on 7/21/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView
@property PFImageView *imageView;
@property UILabel *age;
@property UILabel *username;
@property UILabel *bio;
@end

NS_ASSUME_NONNULL_END

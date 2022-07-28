//
//  CardView.h
//  Squablr
//
//  Created by Zeke Reyes on 7/21/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Profile.h"
#import "Parse/PFImageView.h"
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CardViewDelegate

@end

@interface CardView : UIView
@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong)id<CardViewDelegate> delegate;
@property PFImageView *imageView;
@property UILabel *age;
@property UILabel *username;
@property UILabel *bio;

- (instancetype)initWithProfile:(CGRect)frame profile:(Profile *)profile;
@end

NS_ASSUME_NONNULL_END

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

@property (nonatomic, weak) NSMutableArray *userOnFeedProfilePhotos;
@property (nonatomic, weak)id<CardViewDelegate> delegate;
@property (nonatomic) NSUInteger profilePictureIndex;
@property (nonatomic, weak) Profile *profile;
@property UITapGestureRecognizer *tappedOnLeftHalf;
@property UITapGestureRecognizer *tappedOnRightHalf;
@property PFImageView *imageView;
@property UILabel *nameLabel;
@property UILabel *ageLabel;
@property UILabel *bioLabel;
@property UILabel *username;
@property UILabel *age;
@property UILabel *bio;
@property UIView *leftView;
@property UIView *rightView;


- (instancetype)initWithBounds:(CGRect)frame profile:(Profile *)profile;

@end

NS_ASSUME_NONNULL_END


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
@property PFImageView *imageView;
@property UILabel *username;
@property UILabel *age;
@property UILabel *bio;


- (instancetype)initWithBounds:(CGRect)frame profile:(Profile *)profile;

@end

NS_ASSUME_NONNULL_END


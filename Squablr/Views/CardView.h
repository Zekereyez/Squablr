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

@interface CardView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong)id<CardViewDelegate> delegate;
@property UICollectionView *collectionView;
@property PFImageView *imageView;
@property (nonatomic, strong) NSMutableArray *userOnFeedProfilePhotos;
@property UILabel *username;
@property UILabel *age;
@property UILabel *bio;

- (instancetype)initWithBounds:(CGRect)frame profile:(Profile *)profile;

@end

NS_ASSUME_NONNULL_END

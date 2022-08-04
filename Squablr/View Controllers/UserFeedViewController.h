//
//  UserFeedViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "Parse/Parse.h"
#import "Profile.h"
#import "math.h"
#import "ParseUtils.h"
#import "RankingAlgorithmUtils.h"
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserFeedViewController : UIViewController <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate, UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *blackBall;
@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end

NS_ASSUME_NONNULL_END

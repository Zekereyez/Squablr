//
//  UserFeedViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserFeedViewController : UIViewController <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) ZLSwipeableView *swipeableView;
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end

NS_ASSUME_NONNULL_END

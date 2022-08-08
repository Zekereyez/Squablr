//
//  MatchedProfileViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 8/8/22.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchedProfileViewController : UIViewController

@property (weak, nonatomic) Profile *profile;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAge;
@property (weak, nonatomic) IBOutlet UILabel *userWeight;
@property (weak, nonatomic) IBOutlet UILabel *userStance;
@property (weak, nonatomic) IBOutlet UILabel *userExperience;
@property (weak, nonatomic) IBOutlet UILabel *userBio;
@property (weak, nonatomic) IBOutlet UICollectionView *gridView;

@end

NS_ASSUME_NONNULL_END

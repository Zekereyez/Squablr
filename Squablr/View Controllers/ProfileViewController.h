//
//  ProfileViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
//#import "ParseUI/ParseUI.h"
#import "LoginViewController.h"
#import "Profile.h"
#import "UIKit+AFNetworking.h"
#import "ProfilePictureCell.h"
#import <GoogleSignIn/GoogleSignIn.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userAge;
@property (weak, nonatomic) IBOutlet UILabel *userWeight;
@property (weak, nonatomic) IBOutlet UILabel *userStance;
@property (weak, nonatomic) IBOutlet UILabel *userExperience;
@property (weak, nonatomic) IBOutlet UILabel *userBio;
@property (weak, nonatomic) IBOutlet UILabel *userProfileName;
//@property (weak, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (weak, nonatomic) IBOutlet UICollectionView *gridView;

@property (weak, nonatomic) Profile *profile;

@end

NS_ASSUME_NONNULL_END

//
//  ProfileViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *welcomeMessage;

@end

NS_ASSUME_NONNULL_END

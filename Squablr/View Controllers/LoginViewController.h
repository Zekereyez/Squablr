//
//  LoginViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/7/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UserFeedViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)didTapSignup:(id)sender;
- (IBAction)didTapLogin:(id)sender;

@end

NS_ASSUME_NONNULL_END

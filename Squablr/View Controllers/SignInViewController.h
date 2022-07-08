//
//  SignInViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/7/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : UIViewController
- (IBAction)didTapSignin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

NS_ASSUME_NONNULL_END

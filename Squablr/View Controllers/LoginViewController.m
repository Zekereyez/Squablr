//
//  LoginViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/7/22.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if([self fieldsAreInvalid]) {
        [self alert];
        return;
    }
    
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // Display view controller that needs to shown after successful login
            // Manual segue is better since we are able to use the pull refresh
            // rather than having to run the app again once logged in
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UserFeedViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"UserFeedViewController"];
            self.view.window.rootViewController = feedVC;
        }
    }];
}

-(BOOL)fieldsAreInvalid {
    return ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]);
}

// Alert method which handles the cases of incomplete user login/sign up credentials
- (void)alert {
    NSString *alertTitle = @"";
    NSString *alertMessage = @"";
    if ([self.usernameField.text isEqual:@""] && [self.passwordField.text isEqual:@""]) {
        alertTitle = [NSString stringWithFormat:@"%@", @"Username and Password Required"];
        alertMessage = [NSString stringWithFormat:@"%@", @"Please Enter Your Credentials"];
    }
    else if ([self.passwordField.text isEqual:@""]) {
        alertTitle = [NSString stringWithFormat:@"%@", @"Password Required"];
        alertMessage = [NSString stringWithFormat:@"%@", @"Please Enter Your Password"];
    }
    
    else if ([self.usernameField.text isEqual:@""]) {
        alertTitle = [NSString stringWithFormat:@"%@", @"Username Required"];
        alertMessage = [NSString stringWithFormat:@"%@", @"Please Enter Your Username"];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                               message:alertMessage
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
}

- (IBAction)didTapSignup:(id)sender {
    [self performSegueWithIdentifier:@"signupSegue" sender:nil];
}
@end

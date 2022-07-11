//
//  SignInViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/7/22.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (bool)fieldsAreInvalid {
    return ([self.emailField.text isEqualToString:@""] || [self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]);
}

- (void)alert {
    NSString *alertTitle = @"";
    NSString *alertMessage = @"";
    if ([self.emailField.text isEqual:@""] && [self.usernameField.text isEqual:@""] && [self.passwordField.text isEqual:@""]) {
        alertTitle = [NSString stringWithFormat:@"%@", @"All Fields Required"];
        alertMessage = [NSString stringWithFormat:@"%@", @"Please Enter Your Credentials"];
    }
    else if ([self.emailField.text isEqualToString:@""] || [self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        alertTitle = [NSString stringWithFormat:@"%@", @"Missing Information"];
        alertMessage = [NSString stringWithFormat:@"%@", @"Please Enter Your Credentials"];
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

// User registration function
- (void)registerUser {
    // Check that the fields are valid before any work
    if([self fieldsAreInvalid]) {
        [self alert];
        return;
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    // signs up the user asynchronously, will
    // enforce that the username isn't already taken
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"feedSegue" sender:nil];
        }
    }];
}
- (IBAction)didTapSignin:(id)sender {
    [self registerUser];
}
@end

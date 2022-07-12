//
//  LoginViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/7/22.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

static NSString * const kClientID =
    @"948108757446-cgeskunk0ls6f4ljhs871t1buuga4tlr.apps.googleusercontent.com";

@interface LoginViewController ()

@end

@implementation LoginViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *signInTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signIn:)];
    [self.signInButton addGestureRecognizer:signInTapped];
    _signInButton.style = kGIDSignInButtonStyleWide;
    _signInButton.colorScheme = kGIDSignInButtonColorSchemeDark;
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
            UserFeedViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"tabController"];
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
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
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

- (IBAction)signIn:(id)sender {
    GIDConfiguration *signInConfig;
    signInConfig = [[GIDConfiguration alloc] initWithClientID:kClientID];
    
    [GIDSignIn.sharedInstance signInWithConfiguration:signInConfig
                           presentingViewController:self
                                           callback:^(GIDGoogleUser * _Nullable user,
                                                      NSError * _Nullable error) {
        if (error) {
            return;
        }
        // Makes call to extract user info
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = user.profile.name;
        newUser.email = user.profile.email;
        newUser.password = @"password";
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                if ([error.localizedDescription isEqual:@"Account already exists for this username."]) {
                    NSString *username = user.profile.name;
                    NSString *password = @"password";
                    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
                        //
                        // Manually segue now that network call has succeeded
                        // If sign in succeeded, display the app's main content View.
                        [self successful];
                    }];
                }
            } else {
                // Manually segue now that network call has succeeded
                // If sign in succeeded, display the app's main content View.
                [self successful];
            }
        }];
    }];
}

- (void) successful {
    // If sign in succeeded, display the app's main content View.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserFeedViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"tabController"];
    self.view.window.rootViewController = feedVC;
}

@end

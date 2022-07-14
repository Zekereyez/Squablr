//
//  ProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "Profile.h"

@interface ProfileViewController ()
@property (nonatomic, strong) NSMutableArray *arrayOfUserInfo;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self queryUserProfileInfo];
}
- (IBAction)didTapEdit:(id)sender {
    [self performSegueWithIdentifier:@"editSegue" sender:nil];
}

- (IBAction)didTapLogout:(id)sender {
    [GIDSignIn.sharedInstance signOut];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (!error) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            self.view.window.rootViewController = loginViewController;
        }
    }];
}

-(void) queryUserProfileInfo {
    _userProfileName.text = [NSString stringWithFormat:@"%@", [PFUser currentUser].username];
    // Now to load the info we need to query from here based on the user name
    PFQuery *postQuery = [Profile query];
    [postQuery includeKey:@"age"];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.arrayOfUserInfo = [NSMutableArray arrayWithArray:userInfo];
//            [self.tableView reloadData];
            NSLog(@"%@", [self.arrayOfUserInfo[0] stance]);
            NSString *temp = [self.arrayOfUserInfo[0] stance];
//            NSLog(@"%@", [self arrayOfUserInfo[0]);
            // If the call is successful we need to load the info
            [self loadUserProfileInfo];
        }
        else {
            // Log error
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void) loadUserProfileInfo {
    // Here we want to access the array of user info and
    // properly assign the profile properties
    NSString *age = [self.arrayOfUserInfo[0] age];
    self.userAge.text = [NSString stringWithFormat:@"%@", age];
    NSString *weight = [self.arrayOfUserInfo[0] weightClass];
    self.userWeight.text = [NSString stringWithFormat:@"%@", weight];
    NSString *stance = [self.arrayOfUserInfo[0] stance];
    self.userStance.text = [NSString stringWithFormat:@"%@", stance];
    NSString *experience = [self.arrayOfUserInfo[0] experience];
    self.userExperience.text = [NSString stringWithFormat:@"%@", experience];
    NSString *bio = [self.arrayOfUserInfo[0] biography];
    self.userBio.text = [NSString stringWithFormat:@"%@", bio];
    
}

@end

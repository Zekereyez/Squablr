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
            NSLog(@"%@", [self.arrayOfUserInfo[0] age]);
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
//    int ua = [[self.arrayOfUserInfo][0] _userAge];
    self.userAge.text = self.arrayOfUserInfo[0];
//    self.userWeight.text = [[self.arrayOfUserInfo[0]] weight];
//    self.userStance.text = [[self.arrayOfUserInfo[0]] stance];
//    self.userExperience.text = [[self.arrayOfUserInfo[0]] experience];
//    self.userBio.text = [[self.arrayOfUserInfo[0]] biography];
    
}

@end

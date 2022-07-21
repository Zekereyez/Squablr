//
//  EditProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/13/22.
//

#import "EditProfileViewController.h"
#import "Profile.h"

@interface EditProfileViewController ()
@property (nonatomic, strong) NSMutableArray *userProfileInfo;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshUserFields];
}
- (IBAction)didTapDone:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSString *userAge = self.ageField.text;
    NSNumber *age = [NSNumber numberWithInteger:[userAge integerValue]];
    user[@"profile"][@"age"] = age;
    user[@"profile"][@"stance"] = self.stanceField.text;
    NSString *userWeight = self.weightField.text;
    NSNumber *weight = [NSNumber numberWithInteger:[userWeight integerValue]];
    user[@"profile"][@"weightClass"] = weight;
    NSString *userExperience = self.experienceField.text;
    NSNumber *experience = [NSNumber numberWithInteger:[userExperience integerValue]];
    user[@"profile"][@"experience"] = experience;
    user[@"profile"][@"biography"] = self.bioField.text;
    [user saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    self.view.window.rootViewController = profileVC;
}

- (void)refreshUserFields {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    [postQuery whereKey:@"name" equalTo:[PFUser currentUser].username];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.userProfileInfo = [NSMutableArray arrayWithArray:userInfo];
            // If the call is successful we need to load the info into the user profile
            [self loadUserProfileInfo];
        }
    }];
}

-(void) loadUserProfileInfo {
    // Extract the array element properties for the user and assign into profile fields
    if (self.userProfileInfo.count == 0) {return;}
    if (self.userProfileInfo.count == 1) {
        NSString *age = [self.userProfileInfo[0] age];
        self.ageField.text = [NSString stringWithFormat:@"%@", age];
        NSString *weight = [self.userProfileInfo[0] weightClass];
        self.weightField.text = [NSString stringWithFormat:@"%@", weight];
        NSString *stance = [self.userProfileInfo[0] stance];
        self.stanceField.text = [NSString stringWithFormat:@"%@", stance];
        NSString *experience = [self.userProfileInfo[0] experience];
        self.experienceField.text = [NSString stringWithFormat:@"%@", experience];
        NSString *bio = [self.userProfileInfo[0] biography];
        self.bioField.text = [NSString stringWithFormat:@"%@", bio];
    }
}

@end

//
//  EditProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/13/22.
//

#import "EditProfileViewController.h"
#import "Profile.h"

@interface EditProfileViewController ()
@property (nonatomic, strong) Profile *userProfileInfo;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshUserFields];
}
- (IBAction)didTapDone:(id)sender {
    PFUser *user = [PFUser currentUser];
    // This is the way to get the field texts to become an integer
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
    [self refreshUserFields];
    [self dismissViewControllerAnimated:YES completion:nil];
    // this code is essential as it allows the profile vc to update and show the user
    // that the information they have entered has been updated!
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profileNav"];
    self.view.window.rootViewController = profileVC;
}

- (void)refreshUserFields {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    [postQuery whereKey:@"name" equalTo:[PFUser currentUser].username];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.userProfileInfo = [userInfo objectAtIndex:0];
            // If the call is successful we need to load the info into the user profile
            [self loadUserProfileInfo];
        }
    }];
}

-(void) loadUserProfileInfo {
    // Extract the array element properties for the user and assign into profile fields
    if (self.userProfileInfo) {
        NSString *age = [self.userProfileInfo.age stringValue];
        self.ageField.text = [NSString stringWithFormat:@"%@", age];
        NSString *weight = [self.userProfileInfo.weightClass stringValue];
        self.weightField.text = [NSString stringWithFormat:@"%@", weight];
        NSString *stance = self.userProfileInfo.stance;
        self.stanceField.text = [NSString stringWithFormat:@"%@", stance];
        NSString *experience = [self.userProfileInfo.experience stringValue];
        self.experienceField.text = [NSString stringWithFormat:@"%@", experience];
        NSString *bio = self.userProfileInfo.biography;
        self.bioField.text = [NSString stringWithFormat:@"%@", bio];
    }
}

@end

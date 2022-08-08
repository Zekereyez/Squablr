//
//  MatchedProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 8/8/22.
//

#import "MatchedProfileViewController.h"

@interface MatchedProfileViewController ()

@end

@implementation MatchedProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPressedUserProfile];
}

- (void) loadPressedUserProfile {
    NSLog(@"%@", self.profile);
    self.userNameLabel.text = self.profile.name;
    self.userAge.text = self.profile.age.stringValue;
    self.userWeight.text =  [self.profile.weightClass stringValue];
    self.userStance.text = self.profile.stance;
    self.userExperience.text = self.profile.experience.stringValue;
    self.userBio.text = self.profile.biography;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

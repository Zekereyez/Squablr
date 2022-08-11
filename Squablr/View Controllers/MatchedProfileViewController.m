//
//  MatchedProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 8/8/22.
//

#import "MatchedProfileViewController.h"
#import "MatchedProfileCell.h"
#import "Parse/Parse.h"
#import "ParseUtils.h"

@interface MatchedProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *userProfilePhotos;

@end

@implementation MatchedProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.gridView.collectionViewLayout;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = (self.gridView.frame.size.width / 3 - 15);
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.userProfilePhotos = [[NSMutableArray alloc] init];
    
    [self loadPressedUserProfile];
}

- (void) loadPressedUserProfile {
    self.userNameLabel.text = self.profile.name;
    self.userAge.text = self.profile.age.stringValue;
    self.userWeight.text =  [self.profile.weightClass stringValue];
    self.userStance.text = self.profile.stance;
    self.userExperience.text = self.profile.experience.stringValue;
    self.userBio.text = self.profile.biography;
    
    [self queryMatchedUserImages:self.profile.name];
}
- (IBAction)didTapInstagram:(id)sender {
    NSURL* instagramURL = [NSURL URLWithString:@"https://instagram.com/"];
    NSURL* fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", instagramURL, self.userInstagram]];
    if ([[UIApplication sharedApplication] canOpenURL:fullURL]) {
        [[UIApplication sharedApplication] openURL:fullURL];
    }
}
- (IBAction)didTapSnapchat:(id)sender {
    NSURL* snapchatURL = [NSURL URLWithString:@"https://www.snapchat.com/add/"];
    NSURL* fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", snapchatURL, self.userSnapchat]];
    if ([[UIApplication sharedApplication] canOpenURL:fullURL]) {
        [[UIApplication sharedApplication] openURL:fullURL];
    }
}

- (void) queryMatchedUserImages:(NSString*) matchedUserName {
    // Now to load the info we need to query from here based on the user name
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    [postQuery whereKey:@"name" equalTo:matchedUserName];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.userProfilePhotos = userInfo[0][@"profileImages"];
            self.userSnapchat = userInfo[0][@"snapchatUsername"];
            self.userInstagram = userInfo[0][@"instagramUsername"];
            [self.gridView reloadData];
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MatchedProfileCell *cell = [self.gridView dequeueReusableCellWithReuseIdentifier:@"MatchedProfileCell" forIndexPath:indexPath];
    cell.matchedUserProfileImage.file = self.userProfilePhotos[indexPath.item];

    [cell.matchedUserProfileImage loadInBackground];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userProfilePhotos.count;
}

@end

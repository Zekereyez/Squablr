//
//  MatchesViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "MatchesViewController.h"
#import "MatchedProfileViewController.h"

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrayOfMatches;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Source and delegate
    self.tableView.dataSource = self;
    self.tableView.dataSource = self;
    
}

- (void) viewWillAppear:(BOOL)animated {
    // Load the current users matches everytime the user navigates to the match tab
    [self loadMatches];
}

- (void) loadMatches {
    [ParseUtils queryUserMatchesWithBlock:^(NSArray<Profile *> * _Nullable matches, NSError * _Nullable error) {
        if (matches) {
            self.arrayOfMatches = [NSMutableArray arrayWithArray:matches];
            [self.tableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MatchCell *matchCell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell" forIndexPath:indexPath];
    Profile *profile = self.arrayOfMatches[indexPath.row];
    matchCell.matchedUsername.text = profile.name;
    return matchCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfMatches.count;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"matchedProfileSegue"]) {
        MatchCell *matchCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:matchCell];
        Profile *matchedUserProfile = self.arrayOfMatches[indexPath.row];
        MatchedProfileViewController *matchedProfileVC = segue.destinationViewController;
        matchedProfileVC.profile = matchedUserProfile;
    }
}


@end

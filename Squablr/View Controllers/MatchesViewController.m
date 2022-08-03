//
//  MatchesViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "MatchesViewController.h"

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Source and delegate
    self.tableView.dataSource = self;
    self.tableView.dataSource = self;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MatchCell *match = [tableView dequeueReusableCellWithIdentifier:@"MatchCell" forIndexPath:indexPath];;
    return match;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end

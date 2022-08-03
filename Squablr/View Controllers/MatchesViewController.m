//
//  MatchesViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "MatchesViewController.h"

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
    
    // Make parse utils call that will return the array of users matches
    // so that we can fill in the current property of matches
    // and use the count and shit and fill the items in the cell with the names
    // of the users... seems about right
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MatchCell *match = [tableView dequeueReusableCellWithIdentifier:@"MatchCell" forIndexPath:indexPath];;
    return match;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end

//
//  UserFeedViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "UserFeedViewController.h"

@interface UserFeedViewController ()
@property (nonatomic, strong) NSMutableArray *userProfileInfo;
@property (nonatomic, strong) NSMutableArray *userProfilePhotos;
@property (nonatomic) NSUInteger profileIndex;
@property (nonatomic, strong) Profile *profileToShow;
@property (nonatomic, strong) PFUser *user;
@end

@implementation UserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // query for the 50 profiles in db
    [self queryUserProfileInfo];
    
    self.profileIndex = 0;
    
    self.navigationController.toolbarHidden = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - Action

- (void)handleLeft:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (void)handleRight:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToRight];
}

- (void)handleUp:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToUp];
}

- (void)handleDown:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToDown];
}

- (void)handleReload:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet =
        [[UIActionSheet alloc] initWithTitle:@"Load Cards"
                                    delegate:self
                           cancelButtonTitle:@"Cancel"
                      destructiveButtonTitle:nil
                           otherButtonTitles:@"Programmatically", @"From Xib", nil];
    [actionSheet showInView:self.view];
}


#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    // Handle direction
    if (direction == ZLSwipeableViewDirectionLeft) {
        
    }
    else if (direction == ZLSwipeableViewDirectionRight) {
        
    }
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    // call the line below with the initwithProfile
    if (self.profileIndex < self.userProfileInfo.count) {
        // Access the profile array with the current profile index
        Profile *currentProfile = self.userProfileInfo[self.profileIndex];
        NSLog(@"%@", self.userProfileInfo);
        CardView *view = [[CardView alloc] initWithProfile:swipeableView.bounds profile:currentProfile];
        view.backgroundColor = [UIColor systemGrayColor];
        self.profileIndex++;
        view.delegate = self;
        return view;
    }
    return nil;
}

#pragma mark - Color Card Function

- (UIColor *)colorForName:(NSString *)name {
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

-(void) queryUserProfileInfo {
    // Now to load the info we need to query from here based on the user name
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    postQuery.limit = 6;
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
//        NSLog(@"%@", userInfo);
        if (userInfo) {
            // Handle fetched data
            self.userProfileInfo = [NSMutableArray arrayWithArray:userInfo];
            // This is here so we guarantee that the user profile info is filled with
            // profile objects before the cards are initialized so we do not get any errors
            // or blank filled cards
            [self initializeCardsWithInfo];
        }
    }];
}

- (void)initializeCardsWithInfo {
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];
    self.swipeableView.dataSource = self;

    // Optional Delegate
    self.swipeableView.delegate = self;

    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{};

    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"|-20-[swipeableView]-20-|"
                                                      options:0
                                                      metrics:metrics
                                                        views:NSDictionaryOfVariableBindings(
                                                                  swipeableView)]];

    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|-50-[swipeableView]-90-|"
                                                      options:0
                                                      metrics:metrics
                                                        views:NSDictionaryOfVariableBindings(
                                                                  swipeableView)]];
}



@end

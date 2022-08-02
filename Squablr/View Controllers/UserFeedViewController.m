//
//  UserFeedViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "UserFeedViewController.h"

@interface UserFeedViewController ()
@property (nonatomic, strong) NSMutableArray *currentUserProfileInfo;
@property (nonatomic, strong) NSMutableArray *arrayOfUserObjects;
@property (nonatomic, strong) NSMutableArray *userPlaceHolderArray;
@property (nonatomic, strong) NSDictionary *userProfilesandEloScores;
@property (nonatomic) NSUInteger profileIndex;
@property (nonatomic) NSNumber *currUserWeight;
@property (nonatomic) NSNumber *currUserExperience;

@end

@implementation UserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // we want to grab the current users information ie important metrics like weight
    // and experience and make calculations based on that info
    // Loads up the users profile information into an array
    [self queryForCurrentUserInfo];
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
    if (self.profileIndex < self.arrayOfUserObjects.count) {
        // Access the profile array with the current profile index
        Profile *currentProfile = self.arrayOfUserObjects[self.profileIndex];
        CardView *view = [[CardView alloc] initWithBounds:swipeableView.bounds profile:currentProfile];
        self.profileIndex++;
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
    postQuery.limit = 50;
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.arrayOfUserObjects = [NSMutableArray arrayWithArray:userInfo];
            self.userPlaceHolderArray = [self userRankingSystem:_arrayOfUserObjects];
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

- (NSMutableArray *)userRankingSystem:(NSMutableArray *) unrankedUserObjArray;{
    NSMutableArray *sortedUserObjArray;
    NSDictionary *userObjEloScorePair;
    NSNumber *eloScore;
    // Loop through the array of user objects and determine elo scores
    for (Profile *unscoredUser in unrankedUserObjArray) {
        NSNumber *weight = unscoredUser.weightClass;
        double item = [self weightCalculation:weight];
        NSLog(@"%@", unscoredUser.name);
        NSLog(@"%@", unscoredUser.biography);
        NSLog(@"%@", @"Weight score: ");
        NSLog(@"%f", item);
        if (unscoredUser.biography.length == 0) {
            
        }
    }
    return sortedUserObjArray;
}

- (double)weightCalculation:(NSNumber *) currentUserOnFeedWeight {
    NSNumber *currentUserWeight = self.currUserWeight;
    NSInteger *weightDiff = (currentUserWeight.integerValue - currentUserOnFeedWeight.integerValue);
//    NSNumber *difference = currentUserWeight. - currentUserOnFeedWeight;
    NSNumber *weight = [NSNumber numberWithInteger:weightDiff];
    NSLog(@"%@", @"Weight: ");
    NSLog(@"%i", weightDiff);
    NSLog(@"%@", @"USER: ");
    NSLog(@"%@", currentUserWeight);
    if (weight == 0) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        weight = @2;
    }
    double w = [weight doubleValue];
    double weightSquared = pow(w, 2);
    return (1 / weightSquared);
}

- (double)experienceCalculation:(NSNumber *) currentUserOnFeedExp {
    NSNumber *currentUserExp = self.currUserExperience;
    NSInteger *expDiff = (currentUserExp.integerValue - currentUserOnFeedExp.integerValue);
//    NSNumber *difference = currentUserWeight. - currentUserOnFeedWeight;
    NSNumber *experienceToNumber = [NSNumber numberWithInteger:expDiff];
    NSLog(@"%@", @"Exp difference: ");
    NSLog(@"%i", expDiff);
    NSLog(@"%@", @"USER exp: ");
    NSLog(@"%@", currentUserExp);
    if (experienceToNumber == 0) {
        // change the weight since denominator cannot be 0
        // hence same weight and 1 lb apart will be treated the same
        experienceToNumber = @2;
    }
    double w = [experienceToNumber doubleValue];
    double weightSquared = pow(w, 2);
    return (1 / weightSquared);
}

- (void) queryForCurrentUserInfo {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    [postQuery whereKey:@"name" equalTo:[PFUser currentUser].username];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.currentUserProfileInfo = [NSMutableArray arrayWithArray:userInfo];
            NSLog(@"%@", userInfo);
            [self loadUserInfoIntoVariables];
        }
        else {
            return;
        }
    }];
}
- (void) loadUserInfoIntoVariables {
    NSLog(@"%@", [self.currentUserProfileInfo[0] name]);
    self.currUserWeight = [self.currentUserProfileInfo[0] weightClass];
    NSLog(@"%@", self.currUserWeight);
    self.currUserExperience = [self.currentUserProfileInfo[0] experience];
}

@end

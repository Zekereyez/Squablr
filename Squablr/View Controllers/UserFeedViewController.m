//
//  UserFeedViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//
#import <SpriteKit/SpriteKit.h>

#import "UserFeedViewController.h"
#import "MyScene.h"

@interface UserFeedViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfUserObjects;
@property (nonatomic) NSUInteger profileIndex;
@property (nonatomic) CGFloat xPos;
@property (nonatomic) CGFloat yPos;
@property (nonatomic) MyScene *scene;
@property (nonatomic) SKView *skView;

@end

@implementation UserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self queryUserProfileInfo];
    
    self.profileIndex = 0;
    
    self.navigationController.toolbarHidden = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//- (void)loadView {
//    [super loadView];
//    self.view = [SKView new];
//    self.view.bounds = UIScreen.mainScreen.bounds;
//}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - Action

- (void)handleLeft:(UIBarButtonItem *)sender {
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

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    // Handle direction
    if (direction == ZLSwipeableViewDirectionLeft) {
        // means that user disliked and can be put in "seen" array
        // or even recycled for later again
//        [self.swipeableView swipeTopViewToLeft];
        _skView = [SKView new];
        _skView.frame = self.view.frame;
        [self.view addSubview: _skView];
        MyScene* scene = [[MyScene alloc] initWithSize:self.view.frame.size];
        [_skView presentScene:scene];
//        _skView.backgroundColor = UIColor.clearColor;
        self.scene = scene;
    }
    else if (direction == ZLSwipeableViewDirectionRight) {
        // User has liked the current profile so send a like to parse
        // cast the UIView to Card View
        [_skView removeFromSuperview];
        [_skView presentScene:nil];
        CardView *profileCard = (CardView *) view;
        // Card View has a profile object so we can extract the
        // necessary information we need to write the like to parse
        Profile *currentProfile = profileCard.profile;
        // Send like to parse since profile not null
        if (currentProfile) {
            // insert the parse method to send like
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [ParseUtils saveLikeToParse:currentProfile];
                // Determine if the user has already liked the currentProfile
                bool matched = [ParseUtils likedUserProfileHasMatchedWithUser:currentProfile];
                // TODO: Create match animation for matched users
            });
        }
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

-(void) queryUserProfileInfo {
    // Now to load the info we need to query from here based on the user name
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    postQuery.limit = 50;
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.arrayOfUserObjects = [NSMutableArray arrayWithArray:userInfo];
            [RankingAlgorithmUtils sortProfilesByCompatibility:self.arrayOfUserObjects];
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

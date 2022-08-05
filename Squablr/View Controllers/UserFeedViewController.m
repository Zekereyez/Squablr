//
//  UserFeedViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//
#import <SpriteKit/SpriteKit.h>

#import "UserFeedViewController.h"
#import "MatchingAnimationScene.h"

@interface UserFeedViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfUserObjects;
@property (nonatomic) NSUInteger profileIndex;
@property (nonatomic) MatchingAnimationScene *matchingAnimationScene;
@property (nonatomic) SKView *animationSKView;

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

    }
    else if (direction == ZLSwipeableViewDirectionRight) {
        // Removing the scene
        [_animationSKView removeFromSuperview];
        [_animationSKView presentScene:nil];
        // User has liked the current profile so send a like to parse
        // cast the UIView to Card View
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
                if (matched) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.animationSKView = [SKView new];
                        self.animationSKView.frame = self.view.frame;
                        [self.view addSubview: self.animationSKView];
                        self.matchingAnimationScene = [[MatchingAnimationScene alloc] initWithSize:self.view.frame.size];
                        self.matchingAnimationScene.animationCompletionDelegate = self;
                        [self.animationSKView presentScene:self.matchingAnimationScene];
                        self.animationSKView.backgroundColor = UIColor.clearColor;
                        self.matchingAnimationScene = self.matchingAnimationScene;
                    });
                }
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

#pragma mark - Matching Animation Delegate Method
- (void)didFinishTappingOnBoxingGloves {
    [_animationSKView removeFromSuperview];
    [_animationSKView presentScene:nil];
}

@end

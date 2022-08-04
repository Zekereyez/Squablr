//
//  UserFeedViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "UserFeedViewController.h"

@interface UserFeedViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfUserObjects;
@property (nonatomic) NSUInteger profileIndex;
//@property (

@end

@implementation UserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self queryUserProfileInfo];
    
    self.profileIndex = 0;
    
    self.navigationController.toolbarHidden = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.blackBall = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 50.0, 50.0)];

    self.blackBall.backgroundColor = [UIColor blackColor];

    self.blackBall.layer.cornerRadius = 25.0;

    self.blackBall.layer.borderColor = [UIColor blackColor].CGColor;

    self.blackBall.layer.borderWidth = 0.0;

    [self.view addSubview:self.blackBall];

    // Initialize the animator.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Call the animation
    [self demo];
    
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

#pragma mark - UIDynamicAnimator Delegate

- (void)demo {

    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.blackBall]];

//    [self.animator addBehavior:gravityBehavior];
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.blackBall] mode:UIPushBehaviorModeContinuous];
    // The direction of the ball but needs to change on impact
    self.pushBehavior.pushDirection = CGVectorMake(2, 2);
    [self.animator addBehavior:self.pushBehavior];
    
    // Create bounds for the image to be contained within and bounce around
    
    
    
    // Collision behavior ie what happens when hits a certain point
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.blackBall]];

    // Necessary Tab bar boundary since tab bar is above the bottom of the screen
    // and is not fitted at the edge of the view
    [collisionBehavior addBoundaryWithIdentifier:@"tabbar"

                                       fromPoint:self.tabBarController.tabBar.frame.origin

                                         toPoint:CGPointMake(self.tabBarController.tabBar.frame.origin.x + self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.origin.y)];
    
    // Creates a boundary around the whole phone screen so all edges are now a boundary
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true;

    // Calls delegate methods which in this case change the color of the ball on impact
    [self.animator addBehavior:collisionBehavior];

    // The behavior of the item when a collision happens
    UIDynamicItemBehavior *ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.blackBall]];

    ballBehavior.elasticity = 0.65;

    [self.animator addBehavior:ballBehavior];
    
    gravityBehavior.action = ^{

            NSLog(@"%f", self.blackBall.center.y);

        };
    
    collisionBehavior.collisionDelegate = self;
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id)item withBoundaryIdentifier:(id)identifier atPoint:(CGPoint)p {
    self.blackBall.backgroundColor = [UIColor blueColor];
    // change the direction of the vector coordinates when they hit bounds no?
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id)item withBoundaryIdentifier:(id)identifier{
      self.blackBall.backgroundColor = [UIColor blackColor];
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    // Handle direction
    if (direction == ZLSwipeableViewDirectionLeft) {
        // means that user disliked and can be put in "seen" array
        // or even recycled for later again
    }
    else if (direction == ZLSwipeableViewDirectionRight) {
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

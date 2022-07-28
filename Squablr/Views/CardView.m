//
//  CardView.m
//  Squablr
//
//  Created by Zeke Reyes on 7/21/22.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithProfile:(CGRect)frame profile:(Profile *)profile {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.profile = profile;
        // Creating UIImage view programmatically
        PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
        imageView.image = nil;
        imageView.file = [profile[@"profileImages"] firstObject]; // TODO: Change this to the user profile images
        [imageView loadInBackground];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 10.0;
        imageView.layer.masksToBounds = true;
        [self addSubview:imageView];
        // Name Label
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(25, 500, 200, 40)];
        name.text = profile.name;
        name.numberOfLines = 0;
        name.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        name.adjustsFontSizeToFitWidth = YES;
        name.minimumScaleFactor = 10.0f/12.0f;
        name.clipsToBounds = YES;
        name.backgroundColor = [UIColor clearColor];
        name.textColor = [UIColor blackColor];
        name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:name];
        // Age Label
        UILabel *age = [[UILabel alloc]initWithFrame:CGRectMake(125, 500, 200, 40)];
        age.text = [profile.age stringValue];
        age.numberOfLines = 0;
        age.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        age.adjustsFontSizeToFitWidth = YES;
        age.minimumScaleFactor = 10.0f/12.0f;
        age.clipsToBounds = YES;
        age.backgroundColor = [UIColor clearColor];
        age.textColor = [UIColor blackColor];
        age.textAlignment = NSTextAlignmentLeft;
        [self addSubview:age];
        // Biography label
        UILabel *bio = [[UILabel alloc]initWithFrame:CGRectMake(25, 540, 200, 40)];
        bio.text = profile.biography;
        bio.numberOfLines = 0;
        bio.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        bio.adjustsFontSizeToFitWidth = YES;
        bio.minimumScaleFactor = 10.0f/12.0f;
        bio.clipsToBounds = YES;
        bio.backgroundColor = [UIColor clearColor];
        bio.textColor = [UIColor blackColor];
        bio.textAlignment = NSTextAlignmentLeft;
        [self addSubview:bio];
    }
    return self;
}

- (instancetype)initWithLoad:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        spinner.frame = CGRectOffset(self.frame, 0, 0);
        spinner.center = self.center;
        [spinner startAnimating];
        [self addSubview:spinner];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;

    // Corner Radius
    self.layer.cornerRadius = 10.0;
    /*
    
    // Creating UIImage view programmatically
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
    imageView.image = [UIImage imageNamed:@"banana.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = 10.0;
    imageView.layer.masksToBounds = true;
    [self addSubview:imageView];
    
    // Username label
    UILabel *username = [[UILabel alloc]initWithFrame:CGRectMake(25, 500, 200, 40)];
    username.text = @"Banana Man";
    username.numberOfLines = 1;
    username.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    username.adjustsFontSizeToFitWidth = YES;
    username.minimumScaleFactor = 10.0f/12.0f;
    username.clipsToBounds = YES;
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor blackColor];
    username.textAlignment = NSTextAlignmentLeft;
    [self addSubview:username];
    
    // Age Label
    UILabel *age = [[UILabel alloc]initWithFrame:CGRectMake(125, 500, 200, 40)];
    age.text = @"27";
    age.numberOfLines = 1;
    age.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    age.adjustsFontSizeToFitWidth = YES;
    age.minimumScaleFactor = 10.0f/12.0f;
    age.clipsToBounds = YES;
    age.backgroundColor = [UIColor clearColor];
    age.textColor = [UIColor blackColor];
    age.textAlignment = NSTextAlignmentLeft;
    [self addSubview:age];
    
    // Biography label
    UILabel *bio = [[UILabel alloc]initWithFrame:CGRectMake(25, 540, 200, 40)];
    bio.text = @"Banana. 🍌";
    bio.numberOfLines = 1;
    bio.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    bio.adjustsFontSizeToFitWidth = YES;
    bio.minimumScaleFactor = 10.0f/12.0f;
    bio.clipsToBounds = YES;
    bio.backgroundColor = [UIColor clearColor];
    bio.textColor = [UIColor blackColor];
    bio.textAlignment = NSTextAlignmentLeft;
    [self addSubview:bio];
     */
    
}

@end

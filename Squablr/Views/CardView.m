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
        name.translatesAutoresizingMaskIntoConstraints = NO;
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
        age.translatesAutoresizingMaskIntoConstraints = NO;
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
        bio.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bio];
        // Name label layout
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:name attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:name attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [self addConstraints:@[left, top]];
        // Age label layout
        NSLayoutConstraint *rightAge = [NSLayoutConstraint constraintWithItem:age attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
        NSLayoutConstraint *topAge = [NSLayoutConstraint constraintWithItem:age attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [self addConstraints:@[rightAge, topAge]];
        // Bio layout
        NSLayoutConstraint *bioTop = [NSLayoutConstraint constraintWithItem:bio attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:name attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        NSLayoutConstraint *bioLeft = [NSLayoutConstraint constraintWithItem:bio attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        [self addConstraints:@[bioTop, bioLeft]];
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
}

@end

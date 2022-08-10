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

- (instancetype)initWithBounds:(CGRect)frame profile:(Profile *)profile {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.profile = profile;
        // Creating UIImage view programmatically
        PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
        imageView.image = nil;
        self.userOnFeedProfilePhotos = profile[@"profileImages"];
        imageView.file = [profile[@"profileImages"] firstObject]; // TODO: Change this to the user profile images
        [imageView loadInBackground];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 10.0;
        imageView.layer.masksToBounds = true;
        [self addSubview:imageView];
        // Name Label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 500, 200, 40)];
        nameLabel.text = profile.name;
        nameLabel.numberOfLines = 0;
        nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.minimumScaleFactor = 10.0f/12.0f;
        nameLabel.clipsToBounds = YES;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
        // Age Label
        UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 500, 200, 40)];
        ageLabel.text = [profile.age stringValue];
        ageLabel.numberOfLines = 0;
        ageLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        ageLabel.adjustsFontSizeToFitWidth = YES;
        ageLabel.minimumScaleFactor = 10.0f/12.0f;
        ageLabel.clipsToBounds = YES;
        ageLabel.backgroundColor = [UIColor clearColor];
        ageLabel.textColor = [UIColor blackColor];
        ageLabel.textAlignment = NSTextAlignmentLeft;
        ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:ageLabel];
        // Biography label
        UILabel *bioLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 540, 200, 40)];
        bioLabel.text = profile.biography;
        bioLabel.numberOfLines = 0;
        bioLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        bioLabel.adjustsFontSizeToFitWidth = YES;
        bioLabel.minimumScaleFactor = 10.0f/12.0f;
        bioLabel.clipsToBounds = YES;
        bioLabel.backgroundColor = [UIColor clearColor];
        bioLabel.textColor = [UIColor blackColor];
        bioLabel.textAlignment = NSTextAlignmentLeft;
        bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bioLabel];
        // Name label layout
        NSLayoutConstraint *nameLabelLeftEdgeToParent = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *nameLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [self addConstraints:@[nameLabelLeftEdgeToParent, nameLabelTopEdgeToParent]];
        // Age label layout
        NSLayoutConstraint *ageLabelRightEdgeToParent = [NSLayoutConstraint constraintWithItem:ageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
        NSLayoutConstraint *ageLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:ageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        [self addConstraints:@[ageLabelRightEdgeToParent, ageLabelTopEdgeToParent]];
        // Bio layout
        NSLayoutConstraint *bioLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:bioLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        NSLayoutConstraint *bioLabelLeftEdgeToParent = [NSLayoutConstraint constraintWithItem:bioLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *bioLabelRightEdgeToParent = [NSLayoutConstraint constraintWithItem:bioLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
        [self addConstraints:@[bioLabelTopEdgeToParent, bioLabelLeftEdgeToParent, bioLabelRightEdgeToParent]];
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
    
    // Background Color
    self.backgroundColor = [UIColor systemGrayColor];
}

@end

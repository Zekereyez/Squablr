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
        // Setting profile
        self.profile = profile;
        // Initialization of index
        self.profilePictureIndex = 0;
        // Creating invisible half views with tap gesture recognizers
        [self setupSubviews];
        // Creating UIImage view programmatically
        [self setupImageView];
        // Name Label
        [self setupNameLabel];
        // Age Label
        [self setupAgeLabel];
        // Biography label
        [self setupBioLabel];
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

- (void) setupSubviews {
    // Creating invisible half views
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 175, 500)];
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(175, 0, 175, 500)];
    // Create the gestures for the subviews and add them to their
    // respective views
    [self setupGestureRecognizers];
    // Add subviews to the card view
    [self addSubview:_leftView];
    [self addSubview:_rightView];
    
}
- (void) setupGestureRecognizers {
    // Adding tap gesture recognizers for user photos
    self.tappedOnLeftHalf = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                                  action:@selector(previousProfileImage)];
    self.tappedOnRightHalf = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                                  action:@selector(nextProfileImage)];
    // Adding gestures to their respective views
    [_leftView addGestureRecognizer:_tappedOnLeftHalf];
    [_rightView addGestureRecognizer:_tappedOnRightHalf];
}

- (void) setupImageView {
    self.imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
    self.imageView.image = nil;
    self.userOnFeedProfilePhotos = self.profile[@"profileImages"];
    self.imageView.file = [_profile[@"profileImages"] firstObject];
    [self.imageView loadInBackground];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 10.0;
    self.imageView.layer.masksToBounds = true;
    [self addSubview:self.imageView];
}

- (void) setupNameLabel {
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 500, 200, 40)];
    _nameLabel.text = _profile.name;
    _nameLabel.numberOfLines = 0;
    _nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.minimumScaleFactor = 10.0f/12.0f;
    _nameLabel.clipsToBounds = YES;
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_nameLabel];
    [self setNameLabelConstraints];
}

- (void) setNameLabelConstraints {
    NSLayoutConstraint *nameLabelLeftEdgeToParent = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *nameLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    [self addConstraints:@[nameLabelLeftEdgeToParent, nameLabelTopEdgeToParent]];
}

- (void) setupAgeLabel {
    _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 500, 200, 40)];
    _ageLabel.text = [_profile.age stringValue];
    _ageLabel.numberOfLines = 0;
    _ageLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    _ageLabel.adjustsFontSizeToFitWidth = YES;
    _ageLabel.minimumScaleFactor = 10.0f/12.0f;
    _ageLabel.clipsToBounds = YES;
    _ageLabel.backgroundColor = [UIColor clearColor];
    _ageLabel.textColor = [UIColor blackColor];
    _ageLabel.textAlignment = NSTextAlignmentLeft;
    _ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_ageLabel];
    [self setAgeLabelConstraints];
}

- (void) setAgeLabelConstraints {
    NSLayoutConstraint *ageLabelRightEdgeToParent = [NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *ageLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    [self addConstraints:@[ageLabelRightEdgeToParent, ageLabelTopEdgeToParent]];
}

- (void) setupBioLabel {
    _bioLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 540, 200, 40)];
    _bioLabel.text = _profile.biography;
    _bioLabel.numberOfLines = 0;
    _bioLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    _bioLabel.adjustsFontSizeToFitWidth = YES;
    _bioLabel.minimumScaleFactor = 10.0f/12.0f;
    _bioLabel.clipsToBounds = YES;
    _bioLabel.backgroundColor = [UIColor clearColor];
    _bioLabel.textColor = [UIColor blackColor];
    _bioLabel.textAlignment = NSTextAlignmentLeft;
    _bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_bioLabel];
    [self setBioLabelConstraints];
}

- (void) setBioLabelConstraints {
    NSLayoutConstraint *bioLabelTopEdgeToParent = [NSLayoutConstraint constraintWithItem:_bioLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *bioLabelLeftEdgeToParent = [NSLayoutConstraint constraintWithItem:_bioLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *bioLabelRightEdgeToParent = [NSLayoutConstraint constraintWithItem:_bioLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    [self addConstraints:@[bioLabelTopEdgeToParent, bioLabelLeftEdgeToParent, bioLabelRightEdgeToParent]];
}

- (void) nextProfileImage {
    self.profilePictureIndex++;
    if (self.profilePictureIndex >= self.userOnFeedProfilePhotos.count) {
        self.profilePictureIndex = self.userOnFeedProfilePhotos.count - 1;
    }
    self.imageView.file = self.userOnFeedProfilePhotos[_profilePictureIndex];
    [self.imageView loadInBackground];
}

- (void) previousProfileImage {
    if (self.profilePictureIndex > 0) {
        self.profilePictureIndex--;
    }
    self.imageView.file = self.userOnFeedProfilePhotos[_profilePictureIndex];
    [self.imageView loadInBackground];
}

@end

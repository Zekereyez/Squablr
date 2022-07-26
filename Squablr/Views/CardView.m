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
    
    // Username label
    UILabel *username = [[UILabel alloc]initWithFrame:CGRectMake(25, 400, 200, 40)];
    username.text = @"USERNAME";
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
    UILabel *age = [[UILabel alloc]initWithFrame:CGRectMake(125, 400, 200, 40)];
    age.text = @"Age";
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
    UILabel *bio = [[UILabel alloc]initWithFrame:CGRectMake(25, 440, 200, 40)];
    bio.text = @"Biography";
    bio.numberOfLines = 1;
    bio.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    bio.adjustsFontSizeToFitWidth = YES;
    bio.minimumScaleFactor = 10.0f/12.0f;
    bio.clipsToBounds = YES;
    bio.backgroundColor = [UIColor clearColor];
    bio.textColor = [UIColor blackColor];
    bio.textAlignment = NSTextAlignmentLeft;
    [self addSubview:bio];
    
}

@end

#import "CardView.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "Parse/PFImageView.h"

#define PLANT_IMAGE @"ProfileImageFilename"


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

- (instancetype)initWithDict:(CGRect)frame plantDict:(NSDictionary *)plantDict{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
        self.plantDict = plantDict;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = nil;
        [imgView setImageWithURL:[[APIManager shared] getPlantImageURL:plantDict[PLANT_IMAGE]]];
        
        imgView.layer.cornerRadius = 10;
        imgView.frame = CGRectMake(12.5, 25, 250, 400);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectOffset(self.frame, 10, 10)];
        name.numberOfLines = 0;
        name.text = [plantDict[@"CommonName"] lowercaseString];
        [name sizeToFit];
        [self addSubview:name];
        
        UIButton *detailsButton = [[UIButton alloc] initWithFrame: CGRectOffset(self.frame, 0, 0)];
        [detailsButton setTitle:@"" forState:UIControlStateNormal];
        detailsButton.contentMode = UIViewContentModeScaleAspectFill;
        [detailsButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailsButton];
    }
    return self;
}

- (instancetype)initWithPlant:(CGRect)frame plant:(Plant *)plant{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
        self.plant = plant;
        
        PFImageView *imgView = [[PFImageView alloc] initWithFrame:CGRectMake(12.5, 25, 250, 400)];
        imgView.image = nil;
        imgView.file = plant.image;
        [imgView loadInBackground];
        
        
        imgView.layer.cornerRadius = 10;
//        imgView.frame = CGRectOffset(self.frame, 15, 15 );
        imgView.frame = CGRectMake(12.5, 25, 250, 400);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectOffset(self.frame, 10, 10)];
        name.numberOfLines = 0;
        name.text = [plant.name lowercaseString];
        [name sizeToFit];
        [self addSubview:name];
        
        UIButton *detailsButton = [[UIButton alloc] initWithFrame: CGRectOffset(self.frame, 0, 0)];
        [detailsButton setTitle:@"" forState:UIControlStateNormal];
        detailsButton.contentMode = UIViewContentModeScaleAspectFill;
//        detailsButton.center = self.center;
        [detailsButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailsButton];
    }
    return self;
}

- (void)buttonPressed {
    [self.delegate plantClicked:self.plant];
}

- (UIViewController *)parentViewController {
    UIResponder *responder = [self nextResponder];
    while (responder != nil) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
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
    self.layer.cornerRadius = 15.0;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

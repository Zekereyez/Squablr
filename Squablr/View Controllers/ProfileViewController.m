//
//  ProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "ProfileViewController.h"
#import "Parse/PFImageView.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *userProfileInfo;
@property (nonatomic, strong) NSMutableArray *userProfilePhotos;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self queryUserProfileInfo];
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.gridView.collectionViewLayout;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = (self.gridView.frame.size.width / 3 - 15);
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.userProfilePhotos = [[NSMutableArray alloc] init];
}

- (IBAction)didTapEdit:(id)sender {
    [self performSegueWithIdentifier:@"editSegue" sender:nil];
}

// Instatiation method for UIImagePickerController
- (IBAction)didTapPhotoPicker:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

// The delegate method for image picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    [self resizeImage:editedImage withSize:CGSizeMake(500.00, 500.00)];
    
    // Working method for assigning a user a profile image
    // TODO: TIME TO MODULARIZE AND CREATE AND UPLOAD ARRAY OF USER IMAGES
    NSData *imageData = UIImagePNGRepresentation(editedImage);
    PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    PFUser *user = [PFUser currentUser];
    user[@"profile"][@"imageFile"] = [Profile getPFFileFromImage:editedImage];
    
    // load the picture into the local array
    if (self.userProfilePhotos != nil) {
        [self.userProfilePhotos addObject:imageFile];
    }
    else {
        self.userProfilePhotos = [[NSMutableArray alloc] initWithObjects:imageFile, nil];
    }
    // Update the Parse image array with the local array of photos
    user[@"profile"][@"profileImages"] = self.userProfilePhotos;
    [user saveInBackground];
    [self.gridView reloadData];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getPhoto {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)didTapLogout:(id)sender {
    [GIDSignIn.sharedInstance signOut];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (!error) {
            // Sends user to the login page
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            self.view.window.rootViewController = loginViewController;
        }
    }];
}

-(void) queryUserProfileInfo {
    _userProfileName.text = [NSString stringWithFormat:@"%@", [PFUser currentUser].username];
    // Now to load the info we need to query from here based on the user name
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Profile"];
    [postQuery whereKey:@"name" equalTo:[PFUser currentUser].username];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.userProfileInfo = [NSMutableArray arrayWithArray:userInfo];
            self.userProfilePhotos = userInfo[0][@"profileImages"];
            // If the call is successful we need to load the info into the user profile
            [self loadUserProfileInfo];
            [self.gridView reloadData];
        }
    }];
}

-(void) loadUserProfileInfo {
    // Extract the array element properties for the user and assign into profile labels
    // TODO: Make sure the arrayofusers has only one element in it
    if (self.userProfileInfo.count == 0) {return;}
    if (self.userProfileInfo.count == 1) {
        NSString *age = [self.userProfileInfo[0] age];
        self.userAge.text = [NSString stringWithFormat:@"%@", age];
        NSString *weight = [self.userProfileInfo[0] weightClass];
        self.userWeight.text = [NSString stringWithFormat:@"%@", weight];
        NSString *stance = [self.userProfileInfo[0] stance];
        self.userStance.text = [NSString stringWithFormat:@"%@", stance];
        NSString *experience = [self.userProfileInfo[0] experience];
        self.userExperience.text = [NSString stringWithFormat:@"%@", experience];
        NSString *bio = [self.userProfileInfo[0] biography];
        self.userBio.text = [NSString stringWithFormat:@"%@", bio];
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePictureCell *cell = [self.gridView dequeueReusableCellWithReuseIdentifier:@"ProfilePictureCell" forIndexPath:indexPath];
    cell.profileImage.file = self.userProfilePhotos[indexPath.item];

    [cell.profileImage loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userProfilePhotos.count;
}

@end

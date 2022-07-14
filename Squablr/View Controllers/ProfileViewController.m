//
//  ProfileViewController.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "Profile.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *arrayOfUserInfo;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self queryUserProfileInfo];
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
    self.userProfilePic.image = editedImage;
    
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
    PFQuery *postQuery = [Profile query];
    // this key is for test purposes
    [postQuery includeKey:@"age"];
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Profile *> * _Nullable userInfo, NSError * _Nullable error) {
        if (userInfo) {
            // Handle fetched data
            self.arrayOfUserInfo = [NSMutableArray arrayWithArray:userInfo];
            // logging an array item
            NSLog(@"%@", [self.arrayOfUserInfo[0] stance]);
            // If the call is successful we need to load the info into the user profile
            [self loadUserProfileInfo];
        }
        else {
            // Log error
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void) loadUserProfileInfo {
    // Extract the array element properties for the user and assign into profile labels
    // TODO: Make sure the arrayofusers has only one element in it
    if (self.arrayOfUserInfo.count == 1) {
        NSString *age = [self.arrayOfUserInfo[0] age];
        self.userAge.text = [NSString stringWithFormat:@"%@", age];
        NSString *weight = [self.arrayOfUserInfo[0] weightClass];
        self.userWeight.text = [NSString stringWithFormat:@"%@", weight];
        NSString *stance = [self.arrayOfUserInfo[0] stance];
        self.userStance.text = [NSString stringWithFormat:@"%@", stance];
        NSString *experience = [self.arrayOfUserInfo[0] experience];
        self.userExperience.text = [NSString stringWithFormat:@"%@", experience];
        NSString *bio = [self.arrayOfUserInfo[0] biography];
        self.userBio.text = [NSString stringWithFormat:@"%@", bio];
    }
}

@end

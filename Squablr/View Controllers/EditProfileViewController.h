//
//  EditProfileViewController.h
//  Squablr
//
//  Created by Zeke Reyes on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *stanceField;
@property (weak, nonatomic) IBOutlet UITextField *experienceField;
@property (weak, nonatomic) IBOutlet UITextField *bioField;
@property (weak, nonatomic) IBOutlet UITextField *snapchatField;
@property (weak, nonatomic) IBOutlet UITextField *instagramField;
@property (nonatomic) NSString* userSnapchat;
@property (nonatomic) NSString* userInstagram;
@end

NS_ASSUME_NONNULL_END

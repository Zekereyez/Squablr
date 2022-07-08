//
//  User.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "User.h"

@implementation User
@dynamic userID;
@dynamic name;
@dynamic age;
@dynamic weightClass;
@dynamic stance;
@dynamic experience;
@dynamic biography;
@dynamic profileImages;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    User *newUser = [User new];
    newUser.name = [PFUser currentUser];
    newUser.age = @(0);
    newUser.weightClass = @(0);
    newUser.stance = @"1";
    newUser.experience = @(0);
    newUser.biography = @"";
    newUser.profileImages = [self getPFFileFromImage:image];
    
    [newUser saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    // With the change of the class we want to see if there is a change of
    // member funcitons as well which is why above line wasn't working
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}
@end

//
//  User.m
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import "Profile.h"

@implementation Profile
@dynamic userID;
@dynamic name;
@dynamic age;
@dynamic weightClass;
@dynamic stance;
@dynamic experience;
@dynamic biography;
@dynamic imageFile;

+ (nonnull NSString *)parseClassName {
    return @"Profile";
}

+ (void) writeUserToParse: (PFBooleanResultBlock  _Nullable)completion {
    Profile *newUser = [Profile new];
    newUser.name = [PFUser currentUser].username;
    newUser.imageFile = nil;
    newUser.age = @(18);
    newUser.weightClass = @(100);
    newUser.stance = @"Orthodox";
    newUser.experience = @(1);
    newUser.biography = @"I'm new here! (:";
    newUser.userUsageCount = @(0);
    // This creates the user pointer to the profile class
    PFUser *user = [PFUser currentUser];
    user[@"profile"] = newUser;
    // Saves the user profile to parse
    [user saveInBackground];
    
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

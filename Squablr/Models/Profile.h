//
//  User.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Profile : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *weightClass;
@property (nonatomic, strong) NSString *stance;
@property (nonatomic, strong) NSNumber *experience;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) PFFileObject *imageFile;
@property (nonatomic, strong) NSNumber *userUsageCount;
// an elo score will be the name of the score that we are
// giving users in how they are ranked and is a means to
// standardize our users for our recommendation algorithm
@property (nonatomic, strong) NSNumber *eloScore; // an elo score signifies how "good" a user profile is and we will match users with similar scores
+ (void) writeUserToParse: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
@end

NS_ASSUME_NONNULL_END

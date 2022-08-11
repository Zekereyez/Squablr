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
@property (nonatomic, weak) NSString *userID;
@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSNumber *age;
@property (nonatomic, weak) NSNumber *weightClass;
@property (nonatomic, weak) NSString *stance;
@property (nonatomic, weak) NSNumber *experience;
@property (nonatomic, weak) NSString *biography;
@property (nonatomic, weak) NSString *snapchatUsername;
@property (nonatomic, weak) NSString *instagramUsername;
@property (nonatomic, weak) PFFileObject *imageFile;

+ (void) writeUserToParse: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END

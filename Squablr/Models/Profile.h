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
@property (nonatomic, strong) PFFileObject *profileImages;
+(void) writeUserToParse: (PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END

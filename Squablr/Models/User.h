//
//  User.h
//  Squablr
//
//  Created by Zeke Reyes on 7/8/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *weightClass;
@property (nonatomic, strong) NSString *stance;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) PFFileObject *profileImages;

@end

NS_ASSUME_NONNULL_END

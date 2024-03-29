//
//  MatchCell.h
//  Squablr
//
//  Created by Zeke Reyes on 8/3/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *matchedUsername;
@property (weak, nonatomic) IBOutlet UIImageView *matchedUserInCellProfilePicture;


@end

NS_ASSUME_NONNULL_END

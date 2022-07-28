//
//  LocationCell.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (void)updateWithLocation:(NSDictionary *)location;

@end

NS_ASSUME_NONNULL_END

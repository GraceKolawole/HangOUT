//
//  HangOUTCell.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import <UIKit/UIKit.h>
#import "PFImageView.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "ProfilePic.h"
NS_ASSUME_NONNULL_BEGIN

@interface HangOUTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet PFImageView *postPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) ProfilePic *pic;
@property (weak, nonatomic) IBOutlet UIButton *detaliButton;

@end

NS_ASSUME_NONNULL_END

//
//  ProfileViewContoller.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"
#import "LoginViewController.h"
#import "SignupViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewContoller : UIViewController
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

NS_ASSUME_NONNULL_END

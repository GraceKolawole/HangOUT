//
//  GroupViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/11/22.
//

#import "GroupViewController.h"
#import "GroupPassViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface GroupViewController ()
- (IBAction)introveredLogin:(id)sender;
- (IBAction)extrovertedLogin:(id)sender;
- (IBAction)ambivertedLogin:(id)sender;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ambivertedLogin:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GroupPassViewController *GroupPassViewController = [storyboard instantiateViewControllerWithIdentifier:@"GroupPassViewController"];

    sceneDelegate.window.rootViewController = GroupPassViewController;

    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will
    }];
}

- (IBAction)extrovertedLogin:(id)sender {
}

- (IBAction)introveredLogin:(id)sender {
}
@end

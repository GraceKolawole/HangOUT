//
//  HomeViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "HomeViewController.h"
#import "PostViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "HangOUTCell.h"
#import "PFImageView.h"
#import "ProfilePic.h"
#import "DateTools.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Post *profilepicture;
@property (nonatomic, strong) NSMutableArray *postsArray;
@property (strong, nonatomic) Post *post;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        self.refreshControl = [[UIRefreshControl alloc] init];

        self.tableView.dataSource = self;
        self.tableView.delegate = self;

        [self.refreshControl addTarget:self action: @selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
        [self.tableView insertSubview:self.refreshControl atIndex:0];

        PFQuery *postQuery = [Post query];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery includeKey:@"author"];
        postQuery.limit = 35;

        [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
            if (posts) {
                self.postsArray = (NSMutableArray *)posts;
                [self.tableView reloadData];
            }
            else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];

}

- (void)beginRefresh: (UIRefreshControl *)UIRefreshControl {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 35;

    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.postsArray = (NSMutableArray *)posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HangOUTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HangOUTCell"];

    Post *post = self.postsArray[indexPath.row];

    if(post.image == nil){
        [cell.postPictureImageView setHidden:YES];
    }
    else {
        [cell.postPictureImageView setHidden:NO];
        cell.postPictureImageView.file = post[@"image"];
        [cell.postPictureImageView loadInBackground];
    }

    cell.captionLabel.text = post.caption;
        CGFloat fixedWidth = cell.captionLabel.frame.size.width;
    CGSize newSize = [cell.captionLabel sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = cell.captionLabel.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    cell.captionLabel.frame = newFrame;
    [cell.captionLabel setNeedsUpdateConstraints];
    [cell.captionLabel layoutIfNeeded];
    
    cell.userLabel.text = post.author.username;
    cell.usernameLabel.text =  post.author.username;
    cell.dateLabel.text = [post.createdAt shortTimeAgoSinceNow];

    PFQuery *picQuery = [ProfilePic query];
    [picQuery includeKey:@"author"];
    [picQuery whereKey:@"author" equalTo:post.author];

    [picQuery findObjectsInBackgroundWithBlock:^(NSArray<ProfilePic *> * _Nullable pic, NSError * _Nullable error) {
          if (pic) {
              for(ProfilePic *p in pic){
                  cell.profilePictureImageView.file = [p objectForKey:@"image"];
                  [cell.profilePictureImageView loadInBackground];
              }

          }
          else {
              NSLog(@"%@", error.localizedDescription);
          }
          }];

    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.postsArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}
- (IBAction)didTapLogout:(id)sender {

    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];

    sceneDelegate.window.rootViewController = loginViewController;

    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Post *post = self.postsArray[indexPath.row];
    if(post.image == nil){
        return 206;
    }
    else {
        return 446;
    }
}
- (IBAction)didTapFavorite:(id)sender {

}


@end

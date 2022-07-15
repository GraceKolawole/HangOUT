//
//  HomeViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "HomeViewController.h"
#import "PostViewController.h"
#import "ProfilePictureViewController.h"
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
@property (nonatomic, strong) NSMutableArray<Post *> *postsArray;
//
@property (strong, nonatomic) Post *post;
//@property (strong, nonatomic) ProfilePic *pic;
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

        // Server fetch
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

    // get the current user
    // set the user image
    // set the property

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



- (IBAction)didTapLogout:(id)sender {
   // [self dismissViewControllerAnimated:true completion:nil];

    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];

    sceneDelegate.window.rootViewController = loginViewController;

    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
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
//        if (self.post.favorited){
//            self.post.favorited =NO;
//            self.post.favoriteCount -=1;
//            //todo : update fav text
//            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
//
//            NSString *favoriteCount = [NSString stringWithFormat:@"%d", self.post.likeCount];
//                    [self.likeCount setTitle:favoriteCount forState:UIControlStateNormal];
//
//        }
//
//        else{
//            self.post.favorited =YES;
//            self.post.likeCount +=1;
//            //todo : update fav text
//            [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
//
//            NSString *likeCount = [NSString stringWithFormat:@"%d", self.post.likeCount];
//                    [self.likeButton setTitle:likeCount forState:UIControlStateNormal];
//        }
//
}


@end

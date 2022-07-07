//
//  HomeViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "HangOUTCell.h"
#import "PFImageView.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
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

        // Server fetch
        PFQuery *postQuery = [Post query];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery includeKey:@"author"];
        postQuery.limit = 20;

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
    
    cell.post = post;
      
    cell.postPictureImageView.file = post[@"image"];
    [cell.postPictureImageView loadInBackground];
    
//    cell.profilePictureImageView.file = post[@"image"];
//    [cell.profilePictureImageView loadInBackground];
    
    cell.captionLabel.text = post.caption;
    cell.userLabel.text = post.author.username;
    cell.usernameLabel.text =  post.author.username;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

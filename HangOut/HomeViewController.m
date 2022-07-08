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
#import "ProfilePictureViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Post *profilepicture;
@property (nonatomic, strong) NSMutableArray *postsArray;
@property (strong, nonatomic) Post *post;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;

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
//- (IBAction)didTapPicture:(id)sender {
//    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ProfilePictureViewController *profilePictureViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProfilePictureViewController"];
//
//    sceneDelegate.window.rootViewController = profilePictureViewController;
//
//    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
//        // PFUser.current() will now be nil
//    }];
//}
//- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//
//    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//}
////- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
////    return [[UITableViewCell alloc] init];
////}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//
//    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
//
//    // Do something with the images (based on your use case)
//    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(200, 200)];
//    self.profilePictureImageView.image = resizedImage;
//
//    //self.pictureImageView.image = resizedImage;
//    // Dismiss UIImagePickerController to go back to your original view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
//    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//
//    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
//    resizeImageView.image = image;
//
//    UIGraphicsBeginImageContext(size);
//    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return newImage;
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"In the prepareForSegue");
    if ([[segue identifier] isEqualToString:@"DetailsSegue"]) {
        NSLog(@"This is the detail segue");
        HangOUTCell *cell = (HangOUTCell *)sender;
        Post *post = cell.post;
        ProfilePictureViewController *profileVC = [segue destinationViewController];
        profileVC.post = post;
    }
    
}


@end
                                                                                              

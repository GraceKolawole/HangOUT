//
//  ProfileViewContoller.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/8/22.
//

#import "ProfileViewContoller.h"
#import "ProfilePictureViewController.h"
#import "ProfilePic.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "PFImageView.h"
//UITableViewDataSource, UITableViewDelegate,
@interface ProfileViewContoller () < UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) ProfilePic  *profilepicture;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (strong, nonatomic) ProfilePic *pic;
@property (weak, nonatomic) PFImageView *profilePictureImageView;

@end

@implementation ProfileViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.refreshControl = [[UIRefreshControl alloc] init];

//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;

    [self.refreshControl addTarget:self action: @selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView insertSubview:self.refreshControl atIndex:0];

    // Server fetch
    PFQuery *picQuery = [ProfilePic query];
    [picQuery includeKey:@"author"];
    [picQuery whereKey:@"author" equalTo:[PFUser currentUser]];


    [picQuery findObjectsInBackgroundWithBlock:^(NSArray<ProfilePic *> * _Nullable pic, NSError * _Nullable error) {
          if (pic) {
              for(ProfilePic *p in pic){
                  self.profilePictureImageView.file = [p objectForKey:@"image"];
                  [self.profilePictureImageView loadInBackground];
              }
              
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
         
         PFQuery *picQuery = [ProfilePic query];
         [picQuery orderByDescending:@"updateAt"];
         picQuery.limit = 1;

        [picQuery findObjectsInBackgroundWithBlock:^(NSArray<ProfilePic *> * _Nullable pic, NSError * _Nullable error) {
              if (pic) {
                  self.picArray = (NSMutableArray *)pic;
                  [self.tableView reloadData];
              }
              else {
                  NSLog(@"%@", error.localizedDescription);
              }
              }];
         [self.refreshControl endRefreshing];
}

- (IBAction)tappedAlbum:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(200, 200)];
    self.profilePictureImageView.image = resizedImage;
    
//    id profilePicObject = resizedImage;
//    [NSNotificationCenter.defaultCenter postNotificationName:@"handleProfilePicChange" object:profilePicObject];
    
    [ProfilePic profilepicUserImage:resizedImage withCompletion:^(BOOL succeeded, NSError * _Nullable error) {}];
    
    
    //self.pictureImageView.image = resizedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.picArray count];
//}


@end

//
//  ProfilePictureViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/7/22.
//

#import "ProfilePictureViewController.h"
#import "PostViewController.h"
#import "ProfileViewContoller.h"
#import "Post.h"
#import "ProfilePic.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface ProfilePictureViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *albumButton;

@property (nonatomic, strong) NSMutableArray *postsArray;

@end

@implementation ProfilePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)tappedAlbum:(id)sender {

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(200, 200)];
    self.profilePictureImageView.image = resizedImage;
    
    [ProfilePic profilepicUserImage:resizedImage withCompletion:^(BOOL succeeded, NSError * _Nullable error) {}];

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

- (IBAction)didTapChange:(id)sender {
    [ProfilePic profilepicUserImage:self.profilePictureImageView.image withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error != nil){
            NSLog(@"User share failed: %@", error.localizedDescription);
           
        } else {
            
            UINavigationController *navigationController = self.navigationController;
            [navigationController popViewControllerAnimated:YES];
            NSLog(@"User successfully changed profile picture");
        }
}];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end

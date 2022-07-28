//
//  PhotoMapViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/26/22.
//

#import "PhotoMapViewController.h"
#import "EventsViewController.h"
#import "Parse/Parse.h"
#import "LocationCell.h"

@interface PhotoMapViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImage *categoryImage;

- (IBAction)Camera:(id)sender;


@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier: @"EventsViewController"];
    vc.modalPresentationStyle = UIModalPresentationPageSheet;
    UISheetPresentationController *sheet = [vc sheetPresentationController];
    //sheet.detents = [NSArray arrayWithObjects:UISheetPresentationControllerDetentIdentifierMedium, UISheetPresentationControllerDetentIdentifierLarge, nil];
    sheet.detents = @[[UISheetPresentationControllerDetent mediumDetent], [UISheetPresentationControllerDetent largeDetent]];
    sheet.largestUndimmedDetentIdentifier = UISheetPresentationControllerDetentIdentifierMedium;
    sheet.prefersScrollingExpandsWhenScrolledToEdge = NO;
    sheet.prefersEdgeAttachedInCompactHeight = YES;
    sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = YES;
    
    [self presentViewController:vc animated:NO completion:nil];

}



- (IBAction)Camera:(id)sender {
    NSLog(@"PhotoMapViewContoller");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(200, 200)];
    self.categoryImage = resizedImage;
//    self.categoryImageView.image=self.categoryImage;
    
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


//#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"tagSegue"]) {
        EventsViewController *eventsVC = segue.destinationViewController;
//        eventsVC.delegate = self;
//
    }
}
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

    @end

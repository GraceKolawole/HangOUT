//
//  FilterViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/28/22.
//

#import "FilterViewController.h"
#import "SceneDelegate.h"
#import "StateViewController.h"
#import "StateCell.h"
#import "Parse/Parse.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didtapstate:(id)sender {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier: @"StateViewController"];
//        vc.modalPresentationStyle = UIModalPresentationPageSheet;
//        UISheetPresentationController *sheet = [vc sheetPresentationController];
//        sheet.detents = @[[UISheetPresentationControllerDetent mediumDetent], [UISheetPresentationControllerDetent largeDetent]];
//        sheet.largestUndimmedDetentIdentifier = UISheetPresentationControllerDetentIdentifierMedium;
//        sheet.prefersScrollingExpandsWhenScrolledToEdge = NO;
//        sheet.prefersEdgeAttachedInCompactHeight = YES;
//    sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = YES;
//
//        [self presentViewController:vc animated:NO completion:nil];
//    sceneDelegate.window.rootViewController = vc;
    
}
- (void)tapBehindDetected:(UITapGestureRecognizer *)sender
{

    if (sender.state == UIGestureRecognizerStateEnded)
    {

        CGPoint location = [sender locationInView: self.presentingViewController.view];

        if (![self.presentedViewController.view pointInside:[self.presentedViewController.view convertPoint:location fromView:self.view.window] withEvent:nil])
        {
            if(self.presentedViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
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

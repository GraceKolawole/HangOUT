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
#import "EventsViewController.h"

@interface FilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)didtapstate:(id)sender {
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender: (id)string {
    if ([segue.identifier isEqualToString:@"PresentStateViewController"]) {
        StateViewController *vc = [segue destinationViewController];
        vc.delegate = self.stateFilterdelegate;
    }
}


@end


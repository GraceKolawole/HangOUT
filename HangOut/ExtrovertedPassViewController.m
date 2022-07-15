//
//  ExtrovertedPassViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/12/22.
//

#import "ExtrovertedPassViewController.h"
#import "Parse/Parse.h"

@interface ExtrovertedPassViewController ()
@property (weak, nonatomic) IBOutlet UITextField *groupNameTFd;
@property (weak, nonatomic) IBOutlet UITextField *groupPassTFd;

- (IBAction)login:(id)sender;
- (IBAction)signUp:(id)sender;
@end

@implementation ExtrovertedPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)loginUser{
    NSString *username = self.groupNameTFd.text;
    NSString *password = self.groupPassTFd.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
           
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"FourthSegue" sender:nil];
        }
        
    }];
}
- (void)signUpUser {

   PFUser *newUser = [PFUser user];
   
   newUser.username = self.groupNameTFd.text;
   newUser.password = self.groupPassTFd.text;
   
   [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
       if (error != nil) {
           NSLog(@"Error: %@", error.localizedDescription);
           // Todo - segue
       } else {
           NSLog(@"User registered successfully");
           [self performSegueWithIdentifier:@"fourthSegue" sender:nil];
 
       }
   }];
}

- (IBAction)signUp:(id)sender {
    if([self.groupNameTFd.text isEqual:@""] || [self.groupPassTFd.text isEqual:@""] ){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                               message:@"Message"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                      }];
    [alert addAction:cancelAction];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
    
    }
    else{
        [self signUpUser];
    }
}

- (IBAction)login:(id)sender {
    if ([self.groupNameTFd.text isEqual:@""] || [self.groupPassTFd.text isEqual:@""]){

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                               message:@"Message"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                      }];
   
    [alert addAction:cancelAction];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
        
        [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{

    }];
        
    }
    else{
        [self loginUser];
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

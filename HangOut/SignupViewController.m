//
//  SignupViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/6/22.
//

#import "SignupViewController.h"
#import "Parse/Parse.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *addressTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
- (IBAction)signupUser:(id)sender;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)signupUser {
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameTextFeild.text;
    newUser.password = self.passwordTextFeild.text;
    newUser.email = self.emailTextFeild.text;
    newUser.password = self.addressTextFeild.text;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            // Todo - segue
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"FirstSegue" sender:nil];
  
        }
    }];
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupUser:(id)sender {
    if([self.usernameTextFeild.text isEqual:@""] || [self.passwordTextFeild.text isEqual:@""] || [self.emailTextFeild.text isEqual:@""] || [self.addressTextFeild.text isEqual:@""]){
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
        [self signupUser];
    }}
@end

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
}

- (void)signupUser {
    PFUser *newUser = [PFUser user];

    newUser.username = self.usernameTextFeild.text;
    newUser.password = self.passwordTextFeild.text;
    newUser.email = self.emailTextFeild.text;

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            // Todo - segue
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"FirstSegue" sender:nil];

        }
    }];

}

- (IBAction)signupUser:(id)sender {
    if([self.usernameTextFeild.text isEqual:@""] || [self.passwordTextFeild.text isEqual:@""] || [self.emailTextFeild.text isEqual:@""]){
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

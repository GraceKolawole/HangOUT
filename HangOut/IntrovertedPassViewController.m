//
//  IntrovertedPassViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/12/22.
//

#import "IntrovertedPassViewController.h"
#import "Parse/Parse.h"

@interface IntrovertedPassViewController ()
@property (weak, nonatomic) IBOutlet UITextField *groupNameTFd;
@property (weak, nonatomic) IBOutlet UITextField *groupPassTFd;
@property (nullable, nonatomic, strong) NSString *ingroupname;
@property (nullable, nonatomic, strong) NSString *ingrouppass;

- (IBAction)login:(id)sender;
- (IBAction)signUp:(id)sender;
@end

@implementation IntrovertedPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)loginUser{
    NSString *ingroupname = self.groupNameTFd.text;
    NSString *ingrouppass = self.groupPassTFd.text;
    
    [PFUser logInWithUsernameInBackground:ingroupname password:ingrouppass block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
           
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"ThirdSegue" sender:nil];
        }
        
    }];
}

- (void)signUpUser {

    PFUser *newUser = [PFUser user];
    
    newUser.ingroupname = self.groupNameTFd.text;
    newUser.ingrouppass = self.groupPassTFd.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            // Todo - segue
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"ThirdSegue" sender:nil];
  
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

//
//  GroupPassViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/12/22.
//

#import "GroupPassViewController.h"
#import "Parse/Parse.h"

@interface GroupPassViewController ()
@property (weak, nonatomic) IBOutlet UITextField *introvertNameTFd;
@property (weak, nonatomic) IBOutlet UITextField *introvertPassTFd;
@property (weak, nonatomic) IBOutlet UITextField *extrovertNameTFd;
@property (weak, nonatomic) IBOutlet UITextField *extrovertPassTFd;
@property (weak, nonatomic) IBOutlet UITextField *ambivertNameTFd;
@property (weak, nonatomic) IBOutlet UITextField *ambivertPassTFd;

- (IBAction)introvertLogin:(id)sender;
- (IBAction)introvertSignup:(id)sender;
- (IBAction)extrovertLogin:(id)sender;
- (IBAction)extrovertSignup:(id)sender;
- (IBAction)ambivertLogin:(id)sender;
- (IBAction)anbivertSignup:(id)sender;


@end

@implementation GroupPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)ambivertLoginUser{
    NSString *username = self.ambivertNameTFd.text;
    NSString *password = self.ambivertPassTFd.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
           
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"fifthSegue" sender:nil];
        }
        
    }];
}
- (IBAction)anbivertSignup:(id)sender {
}

- (IBAction)ambivertLogin:(id)sender {
    if ([self.ambivertNameTFd.text isEqual:@""] || [self.ambivertPassTFd.text isEqual:@""]){

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
        [self ambivertLoginUser];
    }
}
- (void)extrovertLoginUser{
    NSString *username = self.extrovertNameTFd.text;
    NSString *password = self.extrovertPassTFd.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
           
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"fourthSegue" sender:nil];
        }
        
    }];
}
- (IBAction)extrovertSignup:(id)sender {
}

- (IBAction)extrovertLogin:(id)sender {
    if ([self.extrovertNameTFd.text isEqual:@""] || [self.extrovertPassTFd.text isEqual:@""]){

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
        [self extrovertLoginUser];
    }
}
- (void)introvertLoginUser{
    NSString *username = self.introvertNameTFd.text;
    NSString *password = self.introvertPassTFd.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
           
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"ThirdSegue" sender:nil];
        }
        
    }];
}

- (IBAction)introvertSignup:(id)sender {
}

- (IBAction)introvertLogin:(id)sender {
    if ([self.introvertNameTFd.text isEqual:@""] || [self.introvertPassTFd.text isEqual:@""]){

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
        [self introvertLoginUser];
    }
}
@end

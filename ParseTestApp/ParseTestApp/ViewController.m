//
//  ViewController.m
//  ParseTestApp
//
//  Created by Christopher E White on 2/17/16.
//  Copyright © 2016 Christopher White. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ViewController () <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property(nonatomic, weak) IBOutlet UIButton *signUpButton;
@property(nonatomic, weak) IBOutlet UIButton *logInButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        
        [self.signUpButton setTitle:@"Log Out" forState:UIControlStateNormal];
        self.logInButton.hidden = YES;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender
{
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    logInViewController.delegate = self;
    [self presentViewController:logInViewController animated:YES completion:nil];
}

- (IBAction)signUp:(id)sender
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            
            [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
            self.logInButton.hidden = NO;
            
        }];
        
    } else {
        
        PFSignUpViewController *controller = [[PFSignUpViewController alloc] init];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

#pragma mark - PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.signUpButton setTitle:@"Log Out" forState:UIControlStateNormal];
        self.logInButton.hidden = YES;
    }];
}

#pragma mark - PFSignUpViewControllerDelegate

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.signUpButton setTitle:@"Log Out" forState:UIControlStateNormal];
        self.logInButton.hidden = YES;
    }];
}

@end

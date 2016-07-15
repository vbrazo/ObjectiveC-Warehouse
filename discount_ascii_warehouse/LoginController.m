//
//  ViewController.m
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/12/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

    - (void)viewDidLoad {
    
        [super viewDidLoad];
    
        if ([FBSDKAccessToken currentAccessToken]) {
            NSLog(@"Token is available");
            [self fetchUserInfo];
        } else {
            FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
            loginButton.frame = CGRectMake(100, 150, 100, 40);
            loginButton.center = self.view.center;
            [self.view addSubview:loginButton];
            loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
        }
    
    }

    -(void)fetchUserInfo {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 [self performSegueWithIdentifier: @"transGrid" sender: self];
             }
         }];
    }

    - (void)  loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
        NSLog(@"LOGGED IN TO FACEBOOK");
        [self fetchUserInfo];
    }

@end
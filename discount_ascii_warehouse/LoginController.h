//
//  ViewController.h
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/12/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginController : UIViewController

    @property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end
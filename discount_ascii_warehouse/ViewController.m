//
//  ViewController.m
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/13/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *lblSearch;

@end

@implementation ViewController

    -(void) viewDidLoad{
        [super viewDidLoad];
        WarehouseService *warehouse = [[WarehouseService alloc] init];
        [warehouse reset];
        [warehouse add];
    }

@end
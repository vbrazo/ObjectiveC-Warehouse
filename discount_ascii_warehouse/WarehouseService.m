//
//  WarehouseService.m
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/15/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import "WarehouseService.h"
@import AFNetworking;

@implementation WarehouseService

    -(void)reset {
        
        CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Warehouse"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [[coreDataStack persistentStoreCoordinator] executeRequest:delete withContext:[coreDataStack masterContext] error:&deleteError];
    
    }

    -(void)add {
        
        CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET: @"https://rorwarehouse.herokuapp.com/api/v1/warehouse/index" parameters: nil progress: nil success:^(NSURLSessionTask *task, id responseObject) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *responseArray = responseObject;
                for (id object in responseArray) {
                    
                    Warehouse *warehouse = [NSEntityDescription insertNewObjectForEntityForName:@"Warehouse" inManagedObjectContext:[coreDataStack masterContext]];
                    
                    warehouse.face  = [object objectForKey: @"face"];
                    warehouse.type  = [object objectForKey: @"type"];
                    warehouse.price = [object objectForKey: @"price"];
                    warehouse.size  = [object objectForKey: @"size"];
                    warehouse.stock = [object objectForKey: @"stock"];
            
                }
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *responseDict = responseObject;
                for (NSString* key in responseDict) {
                    id value = [responseDict objectForKey:key];
                    NSLog(@"dictionary value%@", value);
                }
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        NSError *error = nil;
    
        if ([[coreDataStack masterContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        
    }

@end
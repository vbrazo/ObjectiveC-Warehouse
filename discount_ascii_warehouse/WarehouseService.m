//
//  WarehouseService.m
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/15/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import "WarehouseService.h"

@implementation WarehouseService

    CoreDataStack *coreDataStack;

    -(void)reset {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Warehouse"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [[coreDataStack persistentStoreCoordinator] executeRequest:delete withContext:[coreDataStack masterContext] error:&deleteError];
    
    }

    -(void)add {
        
        Warehouse *warehouse = [NSEntityDescription insertNewObjectForEntityForName:@"Warehouse" inManagedObjectContext:[coreDataStack masterContext]];
    
        warehouse.type = @"asd";
    
        NSError *error = nil;
    
        if ([[coreDataStack masterContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        
    }

@end
//
//  CoreDataStack.m
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/13/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@implementation CoreDataStack

    #pragma mark - Core Data stack
    @synthesize managedObjectContext = _managedObjectContext;
    @synthesize managedObjectModel = _managedObjectModel;
    @synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

    - (NSManagedObjectContext *)mainContext {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: [self persistentStoreCoordinator]];
        [_managedObjectContext setMergePolicy: NSMergeByPropertyObjectTrumpMergePolicy];
        [_managedObjectContext setParentContext: [self masterContext]];
        
        return _managedObjectContext;
    
    }

    - (NSManagedObjectContext *)masterContext {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: [self persistentStoreCoordinator]];
        
        return _managedObjectContext;
        
    }

    - (NSManagedObjectContext *)newPrivateQueueContext {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: [self persistentStoreCoordinator]];
        [_managedObjectContext setMergePolicy: NSMergeByPropertyObjectTrumpMergePolicy];
        [_managedObjectContext setParentContext: [self mainContext]];
        
        return _managedObjectContext;
        
    }

    - (void)saveContext:(NSManagedObjectContext *) context {
        [context performBlockAndWait:^{
           
            if (context.hasChanges) {
                NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
                if (managedObjectContext != nil) {
                    NSError *error = nil;
                    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                    }
                }
            }
            
            if (context.parentContext) {
                [self saveContext: [context parentContext]];
            }
            
        }];
    }

    - (NSURL *)applicationDocumentsDirectory {
        return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }

    - (NSManagedObjectModel *)managedObjectModel {
        if (_managedObjectModel != nil) {
            return _managedObjectModel;
        }
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"discount_ascii_warehouse" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        return _managedObjectModel;
    }

    - (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
        if (_persistentStoreCoordinator != nil) {
            return _persistentStoreCoordinator;
        }
    
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"discount_ascii_warehouse.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        return _persistentStoreCoordinator;
    }

@end
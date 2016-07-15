//
//  CoreDataStack.h
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/13/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject 

    @property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
    @property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
    @property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    - (void)saveContext:(NSManagedObjectContext *) context;
    - (NSURL *)applicationDocumentsDirectory;

    - (NSManagedObjectContext *)mainContext;
    - (NSManagedObjectContext *)masterContext;
    - (NSManagedObjectContext *)newPrivateQueueContext;

@end
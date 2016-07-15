//
//  Warehouse.h
//  discount_ascii_warehouse
//
//  Created by Vitor Oliveira on 7/14/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Warehouse : NSManagedObject

    @property (nonatomic, strong) NSString* face;
    @property (nonatomic, strong) NSNumber* price;
    @property (nonatomic, strong) NSNumber* size;
    @property (nonatomic, strong) NSNumber* stock;
    @property (nonatomic, strong) NSString* type;
    
@end
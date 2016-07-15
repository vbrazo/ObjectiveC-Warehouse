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
    @property (nonatomic, strong) NSString* id;
    @property (nonatomic) float_t* price;
    @property (nonatomic) int32_t* size;
    @property (nonatomic) int32_t* stock;
    @property (nonatomic, strong) NSString* type;
    @property (nonatomic) int32_t* uid;

@end
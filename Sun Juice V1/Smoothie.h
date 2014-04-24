//
//  Smoothie.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Smoothie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderingValue;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * calorieSmall;
@property (nonatomic, retain) NSString * calorieMedium;
@property (nonatomic, retain) NSString * calorieLarge;
@property (nonatomic, retain) NSString * priceSmall;
@property (nonatomic, retain) NSString * priceMedium;
@property (nonatomic, retain) NSString * priceLarge;
@property (nonatomic, retain) NSManagedObject *smoothieType;

@end

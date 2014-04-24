//
//  SmoothieType.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Smoothie;

@interface SmoothieType : NSManagedObject

@property (nonatomic, retain) NSString * label;
//@property int scopeNumber;
@property (nonatomic, retain) NSSet *smoothies;
@end

@interface SmoothieType (CoreDataGeneratedAccessors)

- (void)addSmoothiesObject:(Smoothie *)value;
- (void)removeSmoothiesObject:(Smoothie *)value;
- (void)addSmoothies:(NSSet *)values;
- (void)removeSmoothies:(NSSet *)values;

@end

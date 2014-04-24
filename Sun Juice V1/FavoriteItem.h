//
//  FavoriteItem.h
//  Sun Juice
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteItem : NSObject

@property (retain, nonatomic)NSString *smoothieName;
@property (retain, nonatomic)NSString *smoothieIngredients;

@property (retain, nonatomic)NSString *caloriesSmall;
@property (retain, nonatomic)NSString *caloriesMedium;
@property (retain, nonatomic)NSString *caloriesLarge;

@property(retain,nonatomic)NSString *priceSmall;
@property(retain,nonatomic)NSString *priceMedium;
@property(retain,nonatomic)NSString *priceLarge;

-(void)assignSmoothieName:(NSString *)name;
-(void)assignSmoothieIngredients:(NSString *)ingredients;

-(void)assignCalories:(NSString *)small andMedium:(NSString *)medium andLarge:(NSString *)large;

-(void)assignPrices:(NSString *)small andMedium:(NSString *)medium andLarge:(NSString *)large;

@end

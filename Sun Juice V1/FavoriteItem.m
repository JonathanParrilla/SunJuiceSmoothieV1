//
//  FavoriteItem.m
//  Sun Juice
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "FavoriteItem.h"

@implementation FavoriteItem

@synthesize smoothieName,smoothieIngredients;
@synthesize caloriesLarge,caloriesMedium,caloriesSmall;
@synthesize priceLarge,priceMedium,priceSmall;


-(void)assignSmoothieName:(NSString *)name
{
    smoothieName = name;
}


-(void)assignSmoothieIngredients:(NSString *)ingredients
{
    smoothieIngredients = ingredients;
}


-(void)assignCalories:(NSString *)small andMedium:(NSString *)medium andLarge:(NSString *)large
{
    caloriesLarge = large;
    caloriesMedium = medium;
    caloriesSmall = small;
}


-(void)assignPrices:(NSString *)small andMedium:(NSString *)medium andLarge:(NSString *)large
{
    priceLarge = large;
    priceMedium = medium;
    priceSmall = small;
}


@end

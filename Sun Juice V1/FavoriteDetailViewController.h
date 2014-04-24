//
//  FavoriteDetailViewController.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoriteList;

@class FavoriteItem;

@interface FavoriteDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) FavoriteItem *currentItem;

- (void)setDetailItem:(id)newDetailItem;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *ingredients;

@property (weak, nonatomic) IBOutlet UILabel *priceSmall;

@property (weak, nonatomic) IBOutlet UILabel *priceMedium;

@property (weak, nonatomic) IBOutlet UILabel *priceLarge;


@property (weak, nonatomic) IBOutlet UILabel *calorieSmall;

@property (weak, nonatomic) IBOutlet UILabel *calorieMedium;

@property (weak, nonatomic) IBOutlet UILabel *calorieLarge;


@end

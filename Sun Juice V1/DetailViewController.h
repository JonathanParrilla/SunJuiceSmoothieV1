//
//  DetailViewController.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Social/Social.h>

@class FavoriteList;

@class FavoriteItem;

@interface DetailViewController : UIViewController <UIAlertViewDelegate>
{
    FavoriteList *userFavoriteList;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *ingredients;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceForSmall;

@property (weak, nonatomic) IBOutlet UILabel *priceForMedium;

@property (weak, nonatomic) IBOutlet UILabel *priceForLarge;

@property (weak, nonatomic) IBOutlet UILabel *smoothieType;

@property (weak, nonatomic) IBOutlet UILabel *caloriesForSmall;

@property (weak, nonatomic) IBOutlet UILabel *caloriesForMedium;

@property (weak, nonatomic) IBOutlet UILabel *caloriesForLarge;


- (IBAction)addSmoothieToFavoritesList:(id)sender;


- (IBAction)shareToFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareToFacebook;

@end

//
//  FavoriteDetailViewController.m
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "FavoriteDetailViewController.h"

#import "FavoriteItem.h"

#import "FavoriteList.h"

@interface FavoriteDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation FavoriteDetailViewController

@synthesize name,ingredients;
@synthesize priceLarge,priceMedium,priceSmall;
@synthesize calorieLarge,calorieMedium,calorieSmall;

@synthesize currentItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (currentItem)
    {
        
        //NSLog(@"There is a detail item name: %@",[[self.detailItem valueForKey:@"name"] description]);
        
        name.text = currentItem.smoothieName;
        
        ingredients.text = currentItem.smoothieIngredients;
        
        
        priceSmall.text = currentItem.priceSmall;
        
        priceMedium.text = currentItem.priceMedium;
        
        priceLarge.text = currentItem.priceLarge;
        
        
        
        calorieSmall.text = currentItem.caloriesSmall;
        
        calorieMedium.text = currentItem.caloriesMedium;
        
        calorieLarge.text = currentItem.caloriesLarge;
        
    }
    
    //NSLog(@"There is no Detail Item");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //NSLog(@"%@",[[self.detailItem valueForKey:@"name"] description]);
    
    
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

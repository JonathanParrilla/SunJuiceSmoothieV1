//
//  DetailViewController.m
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "DetailViewController.h"

#import "FavoriteItem.h"

#import "FavoriteList.h"

#import "Smoothie.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize ingredients, smoothieType, priceForLarge,priceForMedium,priceForSmall,caloriesForLarge,caloriesForMedium,caloriesForSmall;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem)
    {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"name"] description];
        
        ingredients.text = [[self.detailItem valueForKey:@"ingredients"] description];
        
        smoothieType.text = [NSString stringWithFormat:@"Type: %@",[[self.detailItem smoothieType] valueForKey:@"label"]];
        
        priceForSmall.text = [[self.detailItem valueForKey:@"priceSmall"] description];
        
        priceForMedium.text = [[self.detailItem valueForKey:@"priceMedium"] description];
        
        priceForLarge.text = [[self.detailItem valueForKey:@"priceLarge"] description];
        
        caloriesForSmall.text = [[self.detailItem valueForKey:@"calorieSmall"] description];
        
        caloriesForMedium.text = [[self.detailItem valueForKey:@"calorieMedium"] description];
        
        caloriesForLarge.text = [[self.detailItem valueForKey:@"calorieLarge"] description];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Change the navigation item to display name of item
    [[self navigationItem] setTitle:[self.detailItem name]];
    
    userFavoriteList = [FavoriteList myFavoriteList];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Smoothies", @"Smoothies");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)addSmoothieToFavoritesList:(id)sender
{
    FavoriteItem *smoothieCurrentlyDisplayed = [[FavoriteItem alloc]init];
    
    [smoothieCurrentlyDisplayed assignSmoothieName: self.detailDescriptionLabel.text];
        
    [smoothieCurrentlyDisplayed assignSmoothieIngredients: ingredients.text ];
        
        
        
    [smoothieCurrentlyDisplayed assignPrices:priceForSmall.text andMedium:priceForMedium.text andLarge:priceForLarge.text ];
        
    [smoothieCurrentlyDisplayed assignCalories:caloriesForSmall.text andMedium:caloriesForMedium.text andLarge:caloriesForLarge.text];
        
        
    Boolean aChange = TRUE;
        
    userFavoriteList.listHasChanged = &(aChange);
        
    [userFavoriteList addToList:smoothieCurrentlyDisplayed];
        
    
        
}

// Share to facebook - Nestor
- (IBAction)shareToFacebook:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController * controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *smoothieName = [[self.detailItem valueForKey:@"name"] description];
        
        NSString *message = [NSString stringWithFormat:@"I am drinking a %@ smoothie! You know you want some! Come and get it at Sun Juice Smoothie!", smoothieName];
        
        [controller setInitialText:message];
        
        [self presentViewController:controller animated:YES completion:NO];
        
    }
    [self.shareToFacebook setStyle:UIBarButtonItemStylePlain];
}


// Add smoothie to favorite's list when you shake your apple device (iPhone or iPad) - Nestor
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self showAlert];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        
    {
        FavoriteItem *smoothieCurrentlyDisplayed = [[FavoriteItem alloc]init];
        
        [smoothieCurrentlyDisplayed assignSmoothieName: self.detailDescriptionLabel.text];
        
        [smoothieCurrentlyDisplayed assignSmoothieIngredients: ingredients.text ];
        
        
        
        [smoothieCurrentlyDisplayed assignPrices:priceForSmall.text andMedium:priceForMedium.text andLarge:priceForLarge.text ];
        
        [smoothieCurrentlyDisplayed assignCalories:caloriesForSmall.text andMedium:caloriesForMedium.text andLarge:caloriesForLarge.text];
        
        Boolean aChange = TRUE;
        
        userFavoriteList.listHasChanged = &(aChange);
        
        
        [userFavoriteList addToList:smoothieCurrentlyDisplayed];
        //NSLog(@"user pressed OK");
    }
    
    else
    {
        //NSLog(@"user pressed Cancel");
        
    }
}

-(IBAction)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shake To Add To Favorites" message:@"Would you like to confirm adding this smoothie to favorites?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel",nil];
    
    [alert show];
}
    
    
@end

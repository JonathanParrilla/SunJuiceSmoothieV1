//
//  FavoritesViewController.m
//  Sun Juice V1
//
//  Created by nestor manuel santiago on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "FavoritesViewController.h"

#import "FavoriteDetailViewController.h"

#import "FavoriteList.h"

#import "FavoriteItem.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    userFavoriteList = [FavoriteList myFavoriteList];
    
    favoriteSmoothies = [[NSMutableArray alloc] init];
    
    //NSLog(@"BEFORE LOAD Favorite Smoothies: %lu",(unsigned long)[favoriteSmoothies count]);
    
    //NSLog(@"The number of entries in favorites (Favorite's View) are: %lu",(unsigned long)[userFavoriteList entries]);
    
    //NSLog(@"%lu",(unsigned long)[[FavoriteList myFavoriteList]entries]);
    
    for (int index = 0; index < [userFavoriteList entries]; index++)
    {
        FavoriteItem *currentSmoothie = [userFavoriteList.list objectAtIndex:index];
        
        [favoriteSmoothies insertObject:currentSmoothie.smoothieName atIndex:index];
        
        //NSLog(@"In Favorite's List the current smoothie loaded is: %@",currentSmoothie.smoothieName);
    }
    
    //NSLog(@"AFTER LOAD Favorite Smoothies: %lu",(unsigned long)[favoriteSmoothies count]);
    
}


-(void) viewWillAppear:(BOOL)animated
{
    Boolean *hasListChanged = userFavoriteList.listHasChanged;
    
    //NSLog(@"View WILL Appear: BEFORE LOAD: %lu",(unsigned long)[favoriteSmoothies count]);
    
    if(hasListChanged)
    {
        
        [favoriteSmoothies removeAllObjects];
        
        [self.tableView reloadData];
        
        
        for (int index = 0; index < [userFavoriteList entries]; index++)
        {
            FavoriteItem *currentSmoothie = [userFavoriteList.list objectAtIndex:index];
            
            [favoriteSmoothies insertObject:currentSmoothie.smoothieName atIndex:index];
            
            //NSLog(@"In Favorite's List the current smoothie loaded is: %@",currentSmoothie.smoothieName);
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        //NSLog(@"View WILL Appear: AFTER LOAD: %lu",(unsigned long)[favoriteSmoothies count]);
        
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return favoriteSmoothies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"smoothieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *name = favoriteSmoothies[indexPath.row];
    
    cell.textLabel.text = name;
    
    //NSLog(@" Cell Should have loaded");
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        
        NSString *nameOfSmoothie = favoriteSmoothies[indexPath.row];
        
        FavoriteItem *smoothieToBeDeleted = [userFavoriteList lookUpItemInList:nameOfSmoothie];
        
        [userFavoriteList removeFromList:smoothieToBeDeleted];
        
        [favoriteSmoothies removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     //FavoriteDetailViewController *detailViewController = [[FavoriteDetailViewController alloc] initWithNibName:@"FavoriteDetail" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"SunJuice_iPad" bundle:nil];
        self.detailViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"showFavoriteDetail"];
        
        NSString *name = favoriteSmoothies[indexPath.row];
        
        FavoriteItem *item = [userFavoriteList lookUpItemInList:name];
        
        self.detailViewController.currentItem = item;
        
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    
    else
    {
        UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        self.detailViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"showFavoriteDetail"];
        
        NSString *name = favoriteSmoothies[indexPath.row];
        
        FavoriteItem *item = [userFavoriteList lookUpItemInList:name];
        
        self.detailViewController.currentItem = item;
        
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
    

}


@end

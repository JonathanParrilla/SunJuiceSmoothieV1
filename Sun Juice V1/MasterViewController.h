//
//  MasterViewController.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@class DetailViewController;
@class FavoriteList;



// We do not need the SearchDisplayDelegate, but I left it in just in case I want to get fancier later.
@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
    FavoriteList *userFavoriteList;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) AppDelegate *app;

// tableView will be manipulated to show BOTH our Store and the Search Results.
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//Not needed. I'll erase it later.
//@property (strong,nonatomic) NSMutableArray *filteredSmoothieArray;

// searchBar will be used to accept data from users.
@property IBOutlet UISearchBar *searchBar;

- (IBAction)filterSmoothies:(id)sender;

-(void)loadAllSmoothies;

@end

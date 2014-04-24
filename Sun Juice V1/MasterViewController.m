//
//  MasterViewController.m
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "Smoothie.h"

#import "SmoothieType.h"

#import "FavoriteList.h"

@interface MasterViewController ()
{
    // We need two arrays and a boolean for our search feature to work.
    
    // smoothieArray will contain ALL of the smoothies in the Database.
    NSMutableArray *smoothieArray;
    
    //searchResults will contain, you guessed it, only the smoothies in the result.
    NSMutableArray *searchResults;
    
    // isFiltered will tell us if users are searching or not searching.
    BOOL isFiltered;
    
    // READ
    int numberOfTimesFilteredHasBeenPressed;
    
}

// This is a fancy method to configure each cell as it is drawn.
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end



@implementation MasterViewController
{
    NSManagedObjectContext *context;
}

// We synthesize our tableView.
@synthesize tableView = _tableView;


-(void)viewWillAppear:(BOOL)animated
{
    //Nothing to add here so far.
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    userFavoriteList = [FavoriteList myFavoriteList];
    
    // ALL WE NEED TO DO IS CALL THIS METHOD
    [self loadAllSmoothies];
    
    numberOfTimesFilteredHasBeenPressed = 1;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // If it's filtered (as in a user is using the search feature)
    
    if(isFiltered)
    {
        // Return the count of the search results array
        return [searchResults count];
    }
    
    // Else they are not using the search feature, so return the number of objects in the database section.
    else
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [sectionInfo numberOfObjects];
    }
}

// This method is used to display each cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This string will hold the name of the cell identifier. I used "Cell".
    static NSString *cellIdentifier = @"Cell";
    
    //We create a table view cell named cell and make sure the cells are resuable and to use the identifier named 'cellIdentifier ' which we defined above.
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // We now call the configureCell method and pass it our cell along with the current indexPath.
    [self configureCell:cell atIndexPath:indexPath];
    
    // Now that the cell is configured or customized, we return it in order for it to be displayed.
    return cell;
}

//CONFIGURE CELL - I modified it to configure the cell based on whether the user is using the search feature or not.
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // If the cell is NOT for a search, hence not filtered
    if(!isFiltered)
    {
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [[object valueForKey:@"name"] description];
    }
    
    // Else it is for a search result, hence it is filtered.
    else
    {
        // So create a smoothie object named tempSmoothie and assign it the index row from searchResults.
        Smoothie *tempSmoothie = [searchResults objectAtIndex:indexPath.row] ;
        
        // Now take the tempSmoothie name and assign it to the cell's text label.
        cell.textLabel.text = tempSmoothie.name;
    }
    
}

// Did Select Row is used ONLY for the iPad.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // If it is not filtered (no search function used, so no search Array items are present.)
    if(!isFiltered)
    {
        // Test to see if it's the iPad, which is should be.
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            // Create a storyboard and assign it the iPad story board.
            UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"SunJuice_iPad" bundle:nil];
            
            //Set the detail controller to the view named 'showDetail' in the story board.
            self.detailViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"showDetail"];
            
            //Get the managed object that was just pressed from the database.
            NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            
            // Send this item to the detail view.
            self.detailViewController.detailItem = object;
            
            // Push the detail view 
            [self.navigationController pushViewController:self.detailViewController animated:YES];
        }
    }
    
    // Else you are selecting a search result option
    else
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"SunJuice_iPad" bundle:nil];
            self.detailViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"showDetail"];
            
            
            // So we obtain the smoothie that matches what was selected from the search Results array.
            Smoothie *object = [searchResults objectAtIndex:indexPath.row];
            
            
            self.detailViewController.detailItem = object;
            
            [self.navigationController pushViewController:self.detailViewController animated:YES];
        }
    }
    
    
    
}


// prePare for segue is used by the iPhone
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        // Same isFiltered test as for the iPad.
        // If the item is not from the search array, use the database managed object.
        if(!isFiltered)
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            [[segue destinationViewController] setDetailItem:object];
        }
        
        // Else it's from the search results array
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            Smoothie *object = [searchResults objectAtIndex:indexPath.row];
            [[segue destinationViewController] setDetailItem:object];
        }
        
    }
}



#pragma mark - Fetched results controller
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Smoothie" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Smoothies"];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


/// SEARCH BAR METHODS - Jonathan

// Whenever ANY change takes place in the search bar.
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchBar.showsScopeBar = true;
    
    // If there are no characters present
    if(searchText.length == 0)
    {
        // Nothing is to be filtered
        isFiltered = NO;
    }
    
    // Else we are filtering
    else
    {
        // So is filtered is set to yes.
        isFiltered = YES;
        
        // Init search results array
        searchResults = [[NSMutableArray alloc] init];
        
        // For each smoothie in the smoothie array
        for(Smoothie *smoothie in smoothieArray)
        {
            // Check the range of the smoothie.name and see if it matches what is being entered.
            NSRange smoothieRange = [smoothie.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            // If it finds ANY smoothies that match
            if(smoothieRange.location != NSNotFound)
            {
                //Add those smoothies to the searchResults array.
                [searchResults addObject:smoothie];
            }
        }
    }
    
    //Reload the tableview
    [self.tableView reloadData];
}


// Whenever the button 'Search' is pressed do the following
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsScopeBar = false;
    
    // Resign first responder. So make the keyboard disappear.
    [self.searchBar resignFirstResponder];
    
    
}

// Whenever the button 'cancel' is pressed while searching
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsScopeBar = false;
    
    // Make the keyboard disappear.
    [self.searchBar resignFirstResponder];
}


//Filter the smoothies. - Jonathan
- (IBAction)filterSmoothies:(id)sender
{
    NSString *type;
    
    switch (numberOfTimesFilteredHasBeenPressed)
    {
        case 1:
            type = @"Tropical Smoothie";
            numberOfTimesFilteredHasBeenPressed++;
            break;
            
        case 2:
            type = @"Berry Smoothie";
            numberOfTimesFilteredHasBeenPressed++;
            break;
            
        case 3:
            type = @"Citrus Smoothie";
            numberOfTimesFilteredHasBeenPressed++;
            break;
            
        case 4:
            type = @"Milk-Based";
            numberOfTimesFilteredHasBeenPressed++;
            break;
            
        case 5:
            type = @"Functional";
            numberOfTimesFilteredHasBeenPressed++;
            break;
            
            
        default:
            numberOfTimesFilteredHasBeenPressed = 1;
            break;
    }
    
    // Change the navigation item to display name of filter
    
    if(type == NULL)
    {
        [[self navigationItem] setTitle:@"Smoothies"];
    }
    else
    [[self navigationItem] setTitle:type];
    
    
    NSLog(@"Type from switch case is %@",type);
    
    // So is filtered is set to yes.
    isFiltered = YES;
    
    // Init search results array
    searchResults = [[NSMutableArray alloc] init];
    
    // For each smoothie in the smoothie array
    for(Smoothie *smoothie in smoothieArray)
    {
        // Check the range of the smoothie.name and see if it matches what is being entered.
        //NSRange smoothieRange = [smoothie.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        NSString *currentType = [[smoothie smoothieType] valueForKey:@"label"];
        
        if([currentType isEqualToString:type])
        {
            //Add those smoothies to the searchResults array.
            [searchResults addObject:smoothie];
        }
        else if (type == NULL)
        {
            [searchResults addObject:smoothie];
        }
        
        
    }

    [[self tableView] reloadData];
    

}


// loadAllSmoothies method (it does more than load all the smoothies) - Jonathan
-(void)loadAllSmoothies
{
    // Init the smoothies array
    smoothieArray = [[NSMutableArray alloc] init];
    
    
    // Create and Load smoothie types
    SmoothieType *Tropical = [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    Tropical.label = @"Tropical Smoothie";
    
    
    
    SmoothieType *Berry = [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    Berry.label = @"Berry Smoothie";
    
    
    
    SmoothieType *Citrus = [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    Citrus.label = @"Citrus Smoothie";
    
    
    
    SmoothieType *MilkBased = [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    MilkBased.label = @"Milk-Based";
    
    
    
    SmoothieType *New = [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    New.label = @"New Smoothie";
    
    
    
    SmoothieType *Functional= [NSEntityDescription insertNewObjectForEntityForName:@"SmoothieType" inManagedObjectContext:_managedObjectContext];
    
    Functional.label = @"Functional";
    
    
    
    // Get the path and load the smoothie plist into the dictionary. 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SunJuiceList" ofType:@"plist"];
    
    NSDictionary *smoothieDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    
    // Obtain all the keys (names of smoothies)
    NSArray *smoothieDictionaryKeys = [smoothieDictionary allKeys];
    
    // Loop through the smoothie names and load their data into CoreData.
    for (int x = 0; x < [smoothieDictionaryKeys count]; x++)
    {
        Smoothie *tempSmoothie = [NSEntityDescription insertNewObjectForEntityForName:@"Smoothie" inManagedObjectContext:_managedObjectContext];
        
        //The key is the smoothie name, so let's grab that.
        NSString *name = [smoothieDictionaryKeys objectAtIndex:x];
        
        //Now we get the contents of each smoothie
        NSArray *smoothieDetails = [smoothieDictionary objectForKey:name];
        
        NSString *ingredients = [smoothieDetails objectAtIndex:0];
        
        NSString *priceForSmall = [smoothieDetails objectAtIndex:1];
        
        NSString *priceForMedium = [smoothieDetails objectAtIndex:2];
        
        NSString *priceForLarge = [smoothieDetails objectAtIndex:3];
        
        NSString *type = [smoothieDetails objectAtIndex:4];
        
        // Now we add our details to the temporary smoothie
        tempSmoothie.name = name;
        tempSmoothie.ingredients = ingredients;
        tempSmoothie.priceSmall = priceForSmall;
        tempSmoothie.priceMedium = priceForMedium;
        tempSmoothie.priceLarge = priceForLarge;
        
        
        
        if([type isEqualToString:@"Tropical"])
        {
            tempSmoothie.smoothieType = Tropical;
        }
        else if([type isEqualToString:@"Berry"])
        {
            tempSmoothie.smoothieType = Berry;
        }
        else if([type isEqualToString:@"Citrus"])
        {
            tempSmoothie.smoothieType = Citrus;
        }
        else if([type isEqualToString:@"Milk-Based"])
        {
            tempSmoothie.smoothieType = MilkBased;
        }
        else if([type isEqualToString:@"New"])
        {
            tempSmoothie.smoothieType = New;
        }
        else if([type isEqualToString:@"Functional"])
        {
            tempSmoothie.smoothieType = Functional;
        }
        
        
        [smoothieArray addObject:tempSmoothie];
    
    
    }
}

@end

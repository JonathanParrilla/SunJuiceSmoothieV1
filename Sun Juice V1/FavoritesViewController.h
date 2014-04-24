//
//  FavoritesViewController.h
//  Sun Juice V1
//
//  Created by nestor manuel santiago on 4/13/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoriteItem;
@class FavoriteList;
@class FavoriteDetailViewController;

@interface FavoritesViewController : UITableViewController
{
    FavoriteList *userFavoriteList;
    NSMutableArray *favoriteSmoothies;
}

@property (retain, nonatomic)FavoriteDetailViewController *detailViewController;

@end

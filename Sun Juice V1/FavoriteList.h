//
//  FavoriteList.h
//  Sun Juice
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FavoriteItem;

@interface FavoriteList : NSObject

@property NSMutableArray *list;
@property FavoriteItem *smoothieItem;
@property (nonatomic) Boolean *listHasChanged;
@property (retain, nonatomic)FavoriteItem *currentlySelectedSmoothie;

+(FavoriteList *)myFavoriteList;

-(id)init;

-(void)addToList:(FavoriteItem *)aSmoothieItem;

-(void)removeFromList:(FavoriteItem *)aSmoothieItem;

-(FavoriteItem *)lookUpItemInList:(NSString *)aSmoothieName;

-(void)sortFavoriteList;

-(NSUInteger) entries;


@end

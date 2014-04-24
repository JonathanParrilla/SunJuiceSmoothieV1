//
//  FavoriteList.m
//  Sun Juice
//
//  Created by jonathan a parrilla on 4/14/14.
//  Copyright (c) 2014 Jonathan A Parrilla and Nestor Santiago. All rights reserved.
//

#import "FavoriteList.h"

#import "FavoriteItem.h"

@implementation FavoriteList

@synthesize list;
@synthesize smoothieItem;
@synthesize listHasChanged;
@synthesize currentlySelectedSmoothie;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        list = [NSMutableArray array];
    }
    
    return self;
}


+(FavoriteList *)myFavoriteList
{
    static FavoriteList *userFavoriteList = nil;
       
    @synchronized(self)
    {
        if(!userFavoriteList)
        {
            userFavoriteList = [[FavoriteList alloc] init];
        }
    }
    
    return userFavoriteList;
}


-(void)addToList:(FavoriteItem *)aSmoothieItem
{
    [list addObject:aSmoothieItem];
}


-(void)removeFromList:(FavoriteItem *)aSmoothieItem
{
    [list removeObjectIdenticalTo:aSmoothieItem];
}


-(FavoriteItem *)lookUpItemInList:(NSString *)aSmoothieName
{
    for (FavoriteItem *nextSmoothie in list )
        if ( [[nextSmoothie smoothieName] caseInsensitiveCompare: aSmoothieName] == NSOrderedSame )
            return nextSmoothie;
    
    return nil;
}

-(void)sortFavoriteList
{
    
    [list sortUsingComparator: ^( id obj1, id obj2)
     {
         return [[ obj1 smoothieName] compare: [obj2 smoothieName]];
     }];
    
}

-( NSUInteger) entries
{
    
    return [list count];
}

@end

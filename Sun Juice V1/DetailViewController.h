//
//  DetailViewController.h
//  Sun Juice V1
//
//  Created by jonathan a parrilla on 4/13/14.
//  Copyright (c) 2014 jonathan a parrilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

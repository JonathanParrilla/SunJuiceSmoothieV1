//
//  AboutViewController.h
//  Sun Juice V1
//
//  Created by nestor manuel santiago on 4/13/14.
//  Copyright (c) 2014 jonathan a parrilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface AboutViewController : UIViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) AppDelegate *app;
@property (weak, nonatomic) IBOutlet UIImageView *storePicture;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *hoursOfOperation;

@end

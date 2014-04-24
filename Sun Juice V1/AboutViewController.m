//
//  AboutViewController.m
//  Sun Juice V1
//
//  Created by nestor manuel santiago on 4/13/14.
//  Copyright (c) 2014 jonathan a parrilla. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize storePicture;
@synthesize address,phoneNumber,hoursOfOperation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set the address, phone number and hours of operation.
    
    
    address.text = @"Address: 1405 Sunset Dr, \nCoral Gables, FL 33143";
    
    phoneNumber.text = @"Phone: (305) - 667 - 1555";
    
    hoursOfOperation.text = @"Hours: 9:00 AM - 9:00 PM";
    
    
    
    //Set the store picture details
    
    storePicture.image = [UIImage imageNamed:@"inside.jpg"];
    
    [storePicture.layer setBorderColor: [[UIColor orangeColor] CGColor]];
    [storePicture.layer setBorderWidth: 5.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

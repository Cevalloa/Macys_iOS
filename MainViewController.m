//
//  MainViewController.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import "MainViewController.h"
#import "Product.h"

/*
 --- USE THIS CLASS FOR ---
 1) Modifying the initial first view controller
 */

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    DatabaseSingleton *dbs = [DatabaseSingleton singletonInstance];
    [dbs dataBasePreperation];
    
    //This deletes the rows in the table, used for debugging
    //[dbs deleteAllProducts];
   
}

#pragma mark - IB Actions



- (IBAction)buttonCreateProduct:(id)sender {
    DatabaseSingleton *dbs = [DatabaseSingleton singletonInstance];
    [dbs insertIntoDatabase];
}



@end

//
//  ProductShowCaseTableViewController.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseSingleton.h"

/*
 --- USE THIS CLASS FOR --
 1) Editing the tableview of items that are displayed to the user 
 
 */


@interface ProductShowCaseTableViewController : UITableViewController

//Property to pass information to DetailViewController
@property (nonatomic) NSString *submitToDetail;

@end

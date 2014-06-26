//
//  MainViewController.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DatabaseSingleton.h"

/*
 --- USE THIS CLASS FOR ---
 1) Modifying the initial first view controller
 */

@interface MainViewController : UIViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;


#pragma mark - IB Action
- (IBAction)buttonCreateProduct:(id)sender;


@end

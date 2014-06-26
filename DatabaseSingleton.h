//
//  DatabaseSingleton.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

/*
 --- USE THIS CLASS FOR ---
 1) Modifying how database is accessed
 2) Any type of interaction with the database 
 3) Modifying how data is pulled
 */

@interface DatabaseSingleton : NSObject

//Property to set databasePath
@property (strong, nonatomic) NSString *databasePath;

//sets database to contact
@property (nonatomic) sqlite3 *contactDB;

//totalProductList that is pulled into ProductShowCaseTableViewController's tableview
@property (nonatomic) NSMutableArray *totalProductList;

//Property used to tell detailview what product to show
@property (nonatomic) NSMutableDictionary *detailProductToShow;

//Helps method:insertIntoDatabase iterate through old products
@property (nonatomic) int currentProductIndex;

#pragma mark -  Service Methods
//For use of creating the singleton
+(instancetype)singletonInstance;

#pragma mark - Public Methods (Database)
//Called to prepare the database
-(void)dataBasePreperation;

//Called to insert Products that don't exist in database, used with doesMacysProductExist
-(void)insertIntoDatabase;

//shows all the products, used with ProductShowCaseTableView
-(void)showAllProducts;

//Deleted tablerow with passedInID
-(void)deleteSelectedProduct:(NSString *)toPassIn;

//deletes all rows
-(void)deleteAllProducts;

//Checks if macys product exists, used with insertIntoDatabase
-(BOOL)doesMacysProductExist:(NSString *)toPassIn;

//Gives selected row to detail view
-(void)currentDetailObjectSelect:(NSString *)currentIdToPassIn;

//Updates description for product in detailviewcontroller
-(void)updateCurrentDescriptionForDetailView:(NSString *)newDescription withID:(NSString *)toPassIn;

@end

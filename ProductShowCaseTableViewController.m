//
//  ProductShowCaseTableViewController.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//



/*
 --- USE THIS CLASS FOR --
 1) Editing the tableview of items that are displayed to the user
 
 */

#import "ProductShowCaseTableViewController.h"
#import "Product.h"
#import "DetailViewController.h"

@interface ProductShowCaseTableViewController ()

@end

@implementation ProductShowCaseTableViewController

#pragma mark - View Lifecycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DatabaseSingleton *singletonInstance = [DatabaseSingleton singletonInstance];
    [singletonInstance showAllProducts];
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    DatabaseSingleton *singletonInstance = [DatabaseSingleton singletonInstance];
    return singletonInstance.totalProductList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    DatabaseSingleton *singletonInstance = [DatabaseSingleton singletonInstance];
    int currentValue = [[singletonInstance.totalProductList objectAtIndex:indexPath.row] intValue];
    Product *productToShow =  [Product createNewItem:currentValue];
    
    cell.textLabel.text = productToShow.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    //If I were to customize uitableview cell, you would have to subclass it
    //With the short time alloted, custom cells were skipped
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DatabaseSingleton *singletonInstance = [DatabaseSingleton singletonInstance];
    int currentValue = [[singletonInstance.totalProductList objectAtIndex:indexPath.row] intValue];
    Product *productToShow =  [Product createNewItem:currentValue];
    
    self.submitToDetail = productToShow.theId;
    
    [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
    
}

#pragma mark - Service Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailViewSegue"]){
        DetailViewController *dvc = (DetailViewController *)segue.destinationViewController;
        dvc.objectToShow = self.submitToDetail;
    }
}
@end

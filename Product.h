//
//  Product.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 -- USE THIS CLASS FOR ---
 1) Modify the actual product information
 2) Modify the product before it enters SQLite
 3) Alter how the product converts into JSON
 4) Change how the product converts back from JSON
 
 */

@interface Product : NSObject


//The fields for product
@property (nonatomic) NSString* theId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) int regularPrice;
@property (nonatomic) int salePrice;
@property (nonatomic) NSString *productPhoto;
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSDictionary *stores;

//Initalizer that creates mock data from Json

/*converts JSON into NSDictionary Data
  1)Calls createMockDataUsingJSON, return value is placed in convertsFromJson
  2)Creates new product
 */
-(id)initWithTheID:(int)passedID;

//Class initializer (calls initWithTheID), (passes newID into passedID)
+(id)createNewItem:(int)newID;

/*
 1)Creates dictionary from static data
 2)Converts created NSDictionary into jsonData
 3)Places JSON data into NSData Variable
 */
-(NSData *)createMockDataUsingJSON:(int)passedID;

//Converts json into NSDictionary
/*
 1) converts passed in json data into NSDictionary
 2) assigns NSDictionary values to Product(this class)'s properties
 */
-(void)convertFromJSON:(NSData *)passedInData;


@end

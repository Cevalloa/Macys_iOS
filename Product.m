//
//  Product.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import "Product.h"

/*
-- USE THIS CLASS FOR ---
1) Modify the actual product information
2) Modify the product before it enters SQLite
3) Alter how the product converts into JSON
4) Change how the product converts back from JSON

*/

@implementation Product

//Initalizer that creates mock data from Json
//Initializer then converts JSON into NSDictionary Data
//Calls createMockDataUsingJSON, return value is placed in convertsFromJson
//Creates new product
-(id)initWithTheID:(int)passedID{
    self = [super init];
    
    if (self){
        NSData *dataFromMock = [self createMockDataUsingJSON:passedID];
        [self convertFromJSON:dataFromMock];
    }
    
    return self;
}

//Class initializer (calls initWithTheID), (passes newID into passedID)
+(id)createNewItem:(int)newID{
    
    return [[self alloc] initWithTheID:newID];
}

//Depending on the ID passed in
/*
 1)Creates dictionary from static data
 2)Converts created NSDictionary into jsonData
 3)Places JSON data into NSData Variable
 */
-(NSData *)createMockDataUsingJSON:(int)passedID{
    
    NSDictionary *productionDictionary = @{@"key": @"value"};
    
    NSArray *keys = @[@"theID", @"name", @"description", @"regularPrice", @"salesPrice", @"productPhoto",@"colors", @"stores"];
    
    if (passedID == 1){
        
        NSArray *values = @[@"1", @"Button Shirt",
                            @"The best looking button down shirt around!",
                            [NSNumber numberWithInt:20],
                            [NSNumber numberWithInt:10],
                            @"imageDownButtonShirt",
                            @[@"black", @"grey"],
                            @{@"Near Me": @"Store 444", @"Far Away" : @"Store 232"}
                            
                            ];
        productionDictionary = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];

        
    }else if (passedID == 2){
        
        NSArray *values = @[@"2", @"Jeans",
                            @"Great Quality Pants",
                            [NSNumber numberWithInt:10],
                            [NSNumber numberWithInt:7],
                            @"imageBlueJeans",
                            @[@"blue", @"dark blue"],
                            @{@"Near Me": @"Store 232", @"Far Away" : @"Store 444"}
                            
                            ];
        productionDictionary = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
        
    }else if(passedID ==3){
        NSArray *values = @[@"3", @"T-Shirt",
                            @"Great quality t-shirt!",
                            [NSNumber numberWithInt:8],
                            [NSNumber numberWithInt:5],
                            @"imageTShirt",
                            @[@"white", @"black"],
                            @{@"Near Me": @"Store 300", @"Far Away" : @"Store 444"}
                            
                            ];
        productionDictionary = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];

    }
    
    NSError *error;
    
    //Converts dictionary into JSON
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:productionDictionary options:NSJSONWritingPrettyPrinted error:&error ];
    
    return jsonData;
}

//Converts json into NSDictionary
/*
 1) converts passed in json data into NSDictionary
 2) assigns NSDictionary values to Product(this class)'s properties
 */
-(void)convertFromJSON:(NSData *)passedInData{
    NSError *error;
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:passedInData options:kNilOptions error:&error];
    
    self.theId = [jsonDictionary objectForKey:@"theID"];
    self.name = [jsonDictionary objectForKey:@"name"];
    self.description = [jsonDictionary objectForKey:@"description"];
    self.regularPrice = [[jsonDictionary objectForKey:@"regularPrice"] integerValue];
    self.salePrice = [[jsonDictionary objectForKey:@"salesPrice"]integerValue];
    self.productPhoto = [jsonDictionary objectForKey:@"productPhoto"];
    self.colors = [jsonDictionary objectForKey:@"colors"];
    self.stores = [jsonDictionary objectForKey:@"stores"];
    
    
}

                  
@end

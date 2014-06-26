//
//  DatabaseSingleton.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/23/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import "DatabaseSingleton.h"
#import "Product.h"

@implementation DatabaseSingleton


#pragma mark - Service Methods
//Initiates singleton
+(instancetype)singletonInstance
{
    static DatabaseSingleton *singletonInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[DatabaseSingleton alloc] init];
    });
    
    return singletonInstance;
}

#pragma mark - Public Methods (Database)
//Called to prepare the database
-(void)dataBasePreperation{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    //grabs documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    //build the path to the database file
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"macys.db"]];
    
    // Used to check if DB already exists
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //checks if database already exists
    if([filemgr fileExistsAtPath:_databasePath] == YES)
    {
        const char *dbpath = [_databasePath UTF8String];;
        
        //if there is no DB, makes database via call to sqlite3_open()
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS AllOfMacysProduct (ID Text PRIMARY KEY, NAME TEXT, DESCRIPTION TEXT, REGULAR_PRICE INT, SALE_PRICE INT, PRODUCT_PHOTO TEXT, COLORS TEXT, STORES TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"failed to make the table");
            }
            sqlite3_close(_contactDB);
        }else{
            NSLog(@"made the table");
        }
    }
    

}

//Called to insert Products that don't exist in database, used with doesMacysProductExist
-(void)insertIntoDatabase{

    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];

    //Before entry, checks if macys product already exists
    for(int i=1; i<4; i++){

        //If this already exists, the for loop keeps running
        if ([self doesMacysProductExist:[NSString stringWithFormat:@"%d",i]]){
            NSLog(@"already exists");
        
        //If the product doesnt exist, creates new product
        }else{
            
               //Creates new product with specific ID
            Product *productJson = [Product createNewItem:i];
            _currentProductIndex = i;
         
               //Prepares entry for new Product
            if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
            {
                
                //Converts dictionary into NSData
                NSData *prepareForStringSubmission = [NSPropertyListSerialization dataWithPropertyList:productJson.stores format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
                
                //Converts NSData into NString, so String can be transformed into NSDictionary on data retrieval
                NSString *stringToEnterDataBase = [[NSString alloc] initWithData:prepareForStringSubmission encoding:NSUTF8StringEncoding];
             
                //Inserts row from created instance Product's properties
         NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO AllOfMacysProduct (ID, NAME, DESCRIPTION, REGULAR_PRICE, SALE_PRICE, PRODUCT_PHOTO, COLORS, STORES) VALUES (\"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \'%@\', \'%@\')",
                                productJson.theId, productJson.name, productJson.description, productJson.regularPrice, productJson.salePrice, productJson.productPhoto, [productJson.colors description], stringToEnterDataBase];
                

                
            const char *insert_stmt = [insertSQL UTF8String];
            
                //Checks if entry was successful
            sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"it works new insert");
            }else {
                NSLog(@"insert doesnt work");
            }
                
                sqlite3_finalize(statement);
                sqlite3_close(_contactDB);
                
            }
            //Breaks out of for loop when there is a match
            break;
        }
        
    }
}

//shows all the products, used with ProductShowCaseTableView
-(void)showAllProducts{
    //A running list of all active products
    _totalProductList = [[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt  *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM AllOfMacysProduct";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {

            [_totalProductList removeAllObjects];
            
           while (sqlite3_step(statement) == SQLITE_ROW) {
               
                NSString *productId = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
               
               //Adds product to running list of all current products
                 [_totalProductList addObject:[NSString stringWithFormat:@"%@", productId]];
                
           }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

//Updates description for product in detailviewcontroller
-(void)updateCurrentDescriptionForDetailView:(NSString *)newDescription withID:(NSString *)toPassIn{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"UPDATE AllOfMacysProduct set DESCRIPTION = '%@' where ID =\'%@\'", newDescription, toPassIn];
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Successful description update");
        }else {
            NSLog(@"Description update failure");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

}

//Gives selected row to detail view
-(void)currentDetailObjectSelect:(NSString *)currentIdToPassIn{
    
    NSArray *keys = @[@"theID",@"name",@"description",
                      @"regularPrice", @"salesPrice",
                      @"producePhoto",
                      @"colors", @"stores"];
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM AllOfMacysProduct WHERE ID = %@", currentIdToPassIn];
        const char *query_stmt = [querySQL UTF8String];

        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            //Assigns row to values
            while (sqlite3_step(statement) == SQLITE_ROW) {

                NSString *currentId = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                NSString *currentName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                NSString *currentDescription = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 2)];
                int currentValue = sqlite3_column_int(statement, 3);
                int currentSaleValue = sqlite3_column_int(statement, 4);
                
                NSString *currentPhoto = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 5)];
                
                NSString *currentColors = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 6)];
                NSString *currentStores = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 7)];
                
                
                NSArray *values = @[currentId, currentName, currentDescription,
                                    [NSNumber numberWithInt:currentValue], [NSNumber numberWithInt:currentSaleValue],
                                    currentPhoto, currentColors, currentStores
                                    ];
                
                //Used for detailview to access the item's properties
                _detailProductToShow = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];

         
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

//Deleted tablerow with passedInID
-(void)deleteSelectedProduct:(NSString *)toPassIn{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE from AllOfMacysProduct where ID =\'%@\'", toPassIn];
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"deleted row");
        }else {
            NSLog(@"didnt delete row");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    
    
}

//deletes all rows
-(void)deleteAllProducts{
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];

    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM AllOfMacysProduct"];
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"deleted all");
        }else {
            NSLog(@"didnt delete all");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    
}

//Checks if macys product exists, used with insertIntoDatabase
-(BOOL)doesMacysProductExist:(NSString *)toPassIn{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    BOOL recordExist=NO;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK){
        
        NSString *insertSQL = [NSString stringWithFormat:@"select * from AllOfMacysProduct where ID =\'%@\'", toPassIn];
        const char *insert_stmt = [insertSQL UTF8String];
        
        
         sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
    
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            recordExist = YES;
            NSLog(@"the record already exists");
        
        }else {
            NSLog(@"record does not exist");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

    return recordExist;
}


@end

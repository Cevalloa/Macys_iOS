//
//  DetailViewController.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import "DetailViewController.h"
#import "DatabaseSingleton.h"
#import "EnlargedPhotoViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - View Lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    DatabaseSingleton *singletonDataBase = [DatabaseSingleton singletonInstance];
    
    //Brings in NSDictionary  from ProductShowCaseTVC with Product's properties
    [singletonDataBase currentDetailObjectSelect:self.objectToShow];
    
    NSDictionary *dictionaryForTheDetail = singletonDataBase.detailProductToShow;
    
    //Assigns brought in values to class's IBOutlets
    self.title =[dictionaryForTheDetail objectForKey:@"name"];
    
    
    [self.buttonImageViewProduct setImage:[UIImage imageNamed:[dictionaryForTheDetail objectForKey:@"producePhoto"]] forState:UIControlStateNormal];
    
    //Sets the contentview of the button's image
    [[self.buttonImageViewProduct imageView] setContentMode: UIViewContentModeScaleAspectFill];
    
    self.propertyToPassToImageView = [dictionaryForTheDetail objectForKey:@"producePhoto"];
    
    self.textViewProductDescription.text = [dictionaryForTheDetail objectForKey:@"description"];
    
    self.labelBeforePrice.text = [[dictionaryForTheDetail objectForKey:@"regularPrice"] description];
    
    self.labelAfterPrice.text = [[dictionaryForTheDetail objectForKey:@"salesPrice"] description];
    
    //Turns NSString into NSArray (NSArray saved into SQLite as text)
    NSArray *arrayPulledInColors = [[dictionaryForTheDetail objectForKey:@"colors"] componentsSeparatedByString:@","];
    
    //Selects colors from Array
    NSString *firstColor = [arrayPulledInColors objectAtIndex:0];
    NSString *secondColor = [arrayPulledInColors objectAtIndex:1];
    
    //Removes array  from NSString
    NSCharacterSet *removeArrayCharsFromString = [NSCharacterSet characterSetWithCharactersInString:@"()\n\"  "];
    
    //Removes array char values
    self.labelProductColors.text = [firstColor stringByTrimmingCharactersInSet:removeArrayCharsFromString];
    
    self.labelSecondProductColor.text = [secondColor stringByTrimmingCharactersInSet:removeArrayCharsFromString];

    //brings in NSDictionary stored as an NString on SQLite
    NSString *dictionaryDataPulledInStores = [dictionaryForTheDetail objectForKey:@"stores"];
    
    //Converts the NSTring data into an NSDictionary
    NSDictionary *storesBroughtInDictionary = [NSPropertyListSerialization propertyListWithData:[dictionaryDataPulledInStores dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions format:NULL error:NULL];
    
    self.labelCloseStore.text = [storesBroughtInDictionary valueForKey:@"Near Me"];
    self.labelSecondCloseStore.text = [storesBroughtInDictionary valueForKey:@"Far Away"];
    
    
}

#pragma  mark - Handle Gestures
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Used for the textview to dismiss keyboard when there is a background touch
    [self.textViewProductDescription endEditing:YES];
}

#pragma mark - IB Actions

- (IBAction)buttonUpdateDescription:(id)sender {
    DatabaseSingleton *singletonDataBase = [DatabaseSingleton singletonInstance];
    
    //Updates current description
    [singletonDataBase updateCurrentDescriptionForDetailView:self.textViewProductDescription.text withID:self.objectToShow];
    
    //Creates alertview to indicate the description has been updated
    UIAlertView *updatedDescription = [[UIAlertView alloc] initWithTitle:@"Updated!" message:@"The description has been updated" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    
    [updatedDescription show];
    
}

- (IBAction)buttonDeleteThisProduct:(id)sender {
    DatabaseSingleton *singletonDataBase = [DatabaseSingleton singletonInstance];

    //deletes selected product
    [singletonDataBase deleteSelectedProduct:self.objectToShow];
    
    //Pushes back navigationviewcontroller to ProductShowCaseTVC
    [self.navigationController popViewControllerAnimated:YES];
    
    UIAlertView *successfulDeletion = [[UIAlertView alloc] initWithTitle:@"Deleted" message:@"The selected object has been deleted" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [successfulDeletion show];
}

#pragma mark - Service Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pushLargePhotoView"]){
        
        EnlargedPhotoViewController *epvc = (EnlargedPhotoViewController *)segue.destinationViewController;
        
        //sends the name of the image to EnlargedPhotoViewController
        epvc.thisProductImage = self.propertyToPassToImageView;
    }
}

@end

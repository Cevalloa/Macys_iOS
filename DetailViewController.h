//
//  DetailViewController.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 --- USE THIS CLASS FOR ---
 1) Modifying the detail product page
 
*/

@interface DetailViewController : UIViewController

@property (nonatomic) NSString *objectToShow;
@property (nonatomic) NSString *propertyToPassToImageView;

#pragma mark - IB Actions
- (IBAction)buttonUpdateDescription:(id)sender;
- (IBAction)buttonDeleteThisProduct:(id)sender;

#pragma mark - IB Outlets
@property (weak, nonatomic) IBOutlet UILabel *labelBeforePrice;
@property (weak, nonatomic) IBOutlet UILabel *labelAfterPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelProductColors;
@property (weak, nonatomic) IBOutlet UILabel *labelSecondProductColor;
@property (weak, nonatomic) IBOutlet UILabel *labelCloseStore;
@property (weak, nonatomic) IBOutlet UILabel *labelSecondCloseStore;
@property (weak, nonatomic) IBOutlet UITextView *textViewProductDescription;
@property (weak, nonatomic) IBOutlet UIButton *buttonImageViewProduct;
@end

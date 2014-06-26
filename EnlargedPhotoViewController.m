//
//  EnlargedPhotoViewController.m
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import "EnlargedPhotoViewController.h"

/*
 --- USE THIS CLASS FOR --
 1) Editing the enlarged photo from the detailviewcontroller
 */

@interface EnlargedPhotoViewController ()

@end

@implementation EnlargedPhotoViewController

#pragma mark - View Lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //Sets the image from DetailViewController as the imageViewLargeProductPhoto
    self.imageViewLargeProductPhoto.image = [UIImage imageNamed:self.thisProductImage];
}






@end

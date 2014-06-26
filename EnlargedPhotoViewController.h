//
//  EnlargedPhotoViewController.h
//  Macys_iOS
//
//  Created by Alex Cevallos on 6/24/14.
//  Copyright (c) 2014 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 --- USE THIS CLASS FOR --
 1) Editing the enlarged photo from the detailviewcontroller
 */

@interface EnlargedPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLargeProductPhoto;

@property (nonatomic) NSString *thisProductImage;

@end

//
//  ViewController.h
//  PEM
//
//  Created by Sandra Zollner on 30.05.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *semestersArray;

@end

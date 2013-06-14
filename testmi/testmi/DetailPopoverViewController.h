//
//  PopoverViewController.h
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPopoverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleString;
@end

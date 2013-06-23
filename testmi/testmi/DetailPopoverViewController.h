//
//  PopoverViewController.h
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "ViewController1.h"

@interface DetailPopoverViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic,assign) ViewController1 *delegate;

@property NSMutableDictionary *semestersdicView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleString;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *gradeArray;
@property (strong, nonatomic) NSArray *noGradeArray;
@property (weak, nonatomic) IBOutlet UIButton *save;
- (IBAction)saveAction:(id)sender;
@end

//
//  PopoverViewController.h
//  PEM
//
//  Created by Sandra Zollner on 01.06.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPopoverViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleString;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *gradeArray;
@property (strong, nonatomic) NSArray *noGradeArray;
- (IBAction)selectGradeAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@end

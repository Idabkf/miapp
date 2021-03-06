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
#import "PopoverTable.h"

@interface DetailPopoverViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    //AFPickerView *defaultPickerView
    NSMutableDictionary *lecture;
}

@property(nonatomic,assign) ViewController1 *delegate;
@property(nonatomic,assign) PopoverTable *delegate2;

@property NSMutableDictionary *semestersdicView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ectsLabel;
@property (weak, nonatomic) IBOutlet UILabel *belegtLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestandenLabel;

@property (weak, nonatomic) IBOutlet UISwitch *belegtSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *bestandenSwitch;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property (strong, nonatomic) IBOutlet UILabel *ungradedLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)belegen:(id)sender;


- (IBAction)bestanden:(id)sender;




@property (nonatomic, strong) NSString *seminarTitle;

@property (nonatomic, strong) NSString *titleString;

@property (strong, nonatomic) NSArray *gradeArray;
@property (strong, nonatomic) NSArray *noGradeArray;
@property (weak, nonatomic) IBOutlet UIButton *save;

@property int modulFlag;
@property int semesterIndex;
@property int lectureIndex;

- (IBAction)saveAction:(id)sender;
@end

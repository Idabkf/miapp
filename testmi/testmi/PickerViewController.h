//
//  PickerViewController.h
//  testmi
//
//  Created by danqing liu on 13-6-11.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FachComponent 0
#define SemesterComponent 1


@interface PickerViewController : UIViewController  <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSDictionary *list;
@property (strong, nonatomic) NSMutableArray *semester;
@property (strong, nonatomic) NSMutableArray *fach;
@property (weak, nonatomic) IBOutlet UIButton *select;
- (IBAction)SelectAction:(id)sender;
- (IBAction)SpeicherAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *speicher;


@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UITextField *FachField;
@property (weak, nonatomic) IBOutlet UIImageView *yes3;

@property (weak, nonatomic) IBOutlet UIImageView *yes2;
- (IBAction)Card:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cardbt;
- (IBAction)wood:(id)sender;
- (IBAction)green:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *SemesterField;
@property (weak, nonatomic) IBOutlet UIButton *woodbt;
@property (weak, nonatomic) IBOutlet UIImageView *yes1;
@property (weak, nonatomic) IBOutlet UIButton *greenbt;
@property int d;

@property NSString *oldFach;

@end

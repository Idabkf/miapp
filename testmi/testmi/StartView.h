//
//  StartView.h
//  testmi
//
//  Created by danqing liu on 13-6-15.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FachComponent 0
#define SemesterComponent 1

@interface StartView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) NSString *Fach;
@property (weak, nonatomic) NSString *Semester;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
//- (IBAction)SelectAction:(id)sender;

- (IBAction)StartAction:(id)sender;

@property (strong, nonatomic) NSDictionary *list;
@property (strong, nonatomic) NSMutableArray *semester;
@property (strong, nonatomic) NSMutableArray *fach;

@end

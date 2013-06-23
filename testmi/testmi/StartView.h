//
//  StartView.h
//  testmi
//
//  Created by danqing liu on 13-6-15.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define FachComponent 0
#define SemesterComponent 1

@interface StartView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *Fachlabel;
@property (weak, nonatomic) IBOutlet UILabel *Semesterlabel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
//- (IBAction)SelectAction:(id)sender;

- (IBAction)StartAction:(id)sender;

@property (strong, nonatomic) NSDictionary *list;
@property (strong, nonatomic) NSMutableArray *semester;
@property (strong, nonatomic) NSMutableArray *fach;
@property (weak, nonatomic) IBOutlet UIImageView *lmu;

@end

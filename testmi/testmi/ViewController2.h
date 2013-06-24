//
//  ViewController2.h
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UITableViewController{
    UISwitch *toggleSwitch;

}

@property (nonatomic,retain) IBOutlet UISwitch *toggleSwitch;

-(IBAction) switchValueChanged;
@property NSMutableDictionary *semestersdicView;
@property (nonatomic, assign) BOOL alternativeGrades;
@property (nonatomic, strong) NSArray *gradeArray;
@property (nonatomic, strong) NSMutableDictionary *GradesAndLectures;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;

@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;

- (void) updateTable;
- (IBAction)menubt:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *menu;
@property (weak, nonatomic) IBOutlet UIButton *bt;

@end

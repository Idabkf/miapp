//
//  ViewController2.h
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UISwitch *toggleSwitch;

}
@property (weak, nonatomic) IBOutlet UIImageView *backg;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *calcBtn;
- (IBAction)setCalculation:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *calcLabel;
@property (weak, nonatomic) IBOutlet UILabel *calcLab;
@property (weak, nonatomic) IBOutlet UILabel *ectsLabel;

@property NSMutableDictionary *semestersdicView;
@property (nonatomic, assign) BOOL alternativeGrades;
@property (nonatomic, strong) NSArray *gradeArray;
@property (nonatomic, strong) NSMutableDictionary *GradesAndLectures;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;

@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *editLab;

- (void) updateTable;
- (IBAction)menubt:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *menu;

@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *saveLab;



@end

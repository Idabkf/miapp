//
//  ViewController1.h
//  testmi
//
//  Created by danqing liu on 13-6-10.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lecture.h"
#import "Semester.h"
#import "FPPopoverController.h"
@interface ViewController1 : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate, FPPopoverControllerDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    FPPopoverController *popover;
    CGPoint savedOffset;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property NSMutableDictionary *semestersdicParser;
@property NSMutableDictionary *semestersdicView;

@property int level;
@property BOOL tr;
@property int td;
@property BOOL inTd;
@property Lecture *currentLecture;
@property NSMutableString *tmp;

@property NSString *plistLocation;
@property NSMutableDictionary *currentLecture1;

//- (void)fetchEntries;
//-(void)createPList;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelBig;
@property (weak, nonatomic) IBOutlet UIImageView *backg;

@property int modulFlag;

- (void) dismissPopover;
- (void) updatePlist;


@property (weak, nonatomic) IBOutlet UIView *menu;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)menubtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UIButton *bt;
- (IBAction)Save:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@property (weak, nonatomic) IBOutlet UILabel *setLab;
@property (weak, nonatomic) IBOutlet UILabel *changeLab;
@property (weak, nonatomic) IBOutlet UILabel *saveLab;



@end

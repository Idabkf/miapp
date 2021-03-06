//
//  PopoverTable.h
//  testmi
//
//  Created by Sandra Zollner on 17.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
@interface PopoverTable : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, FPPopoverControllerDelegate>{
        FPPopoverController *popover;
}
@property NSMutableDictionary *semestersdicView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *add;
- (IBAction)addAction:(id)sender;
//@property (weak,nonatomic) UITextField *TextField;
- (IBAction)SaveAction:(id)sender;
- (void) updateTable;
- (void) dismissPopover;
@property (weak, nonatomic) IBOutlet UIImageView *backg;

@property (nonatomic, strong) NSString *titleString;
@property (weak, nonatomic) IBOutlet UILabel *kompetenzenBla;
@property (nonatomic, strong) NSString *titleForSegue;
@property (nonatomic, strong) NSString *chosenLecture;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UITextView *TextField;
@property(nonatomic,strong) NSMutableDictionary *plist;
@property (nonatomic,strong) NSMutableArray *lectures;
- (IBAction)back:(id)sender;

@property int semesterIndex;
@property int lectureIndex;

@property int modulFlag;
@property BOOL secondTable;
@end

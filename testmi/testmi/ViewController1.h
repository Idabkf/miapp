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
@interface ViewController1 : UITableViewController<NSXMLParserDelegate, FPPopoverControllerDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    FPPopoverController *popover;
}
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

- (void) dismissPopover;



@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;


@end

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
@interface ViewController1 : UITableViewController<NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
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

- (void)fetchEntries;




//@property(nonatomic,strong) NSArray *semester;
@property(nonatomic,strong) Semester *i_semester;
@property(nonatomic,strong) NSMutableDictionary *blist;

@property(nonatomic,strong) NSArray *semester;

@property (nonatomic,strong) NSMutableArray *arry1;
@property (nonatomic,strong) NSMutableArray *arry2;
@property (nonatomic,strong) NSMutableArray *arry3;
@property (nonatomic,strong) NSMutableArray *arry4;
@property (nonatomic,strong) NSMutableArray *arry5;
@property (nonatomic,strong) NSMutableArray *arry6;
@property (nonatomic,strong) NSMutableArray *arry7;
@property (nonatomic,strong) NSMutableArray *arry8;
@property (nonatomic,strong) NSMutableArray *arry9;
@property NSInteger *lecture;

-(void)createPList;


@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;


@end

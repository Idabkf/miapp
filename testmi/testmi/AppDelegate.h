//
//  AppDelegate.h
//  testmi
//
//  Created by danqing liu on 13-6-10.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lecture.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
}
@property NSMutableDictionary *semestersdicParser;
@property NSMutableDictionary *semestersdicView;
@property NSString *plistLocation;

@property int level;
@property BOOL tr;
@property int td;
@property BOOL inTd;
@property Lecture *currentLecture;
@property NSMutableDictionary *currentLecture1;
@property NSMutableString *tmp;

- (void)fetchEntries;
-(void)createPList;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIPickerView *pickrView;
@end

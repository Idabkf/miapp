//
//  ViewController2.h
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UITableViewController
@property NSMutableDictionary *semestersdicView;
@property (nonatomic, strong) NSArray *gradeArray;
@property (nonatomic, strong) NSMutableDictionary *GradesAndLectures;

@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)Edit:(id)sender;

- (void) updateTable;

@end

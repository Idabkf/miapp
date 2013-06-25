//
//  PopoverTable.h
//  testmi
//
//  Created by Sandra Zollner on 17.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverTable : UITableViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *add;
- (IBAction)addAction:(id)sender;
//@property (weak,nonatomic) UITextField *TextField;
- (IBAction)SaveAction:(id)sender;

@property (nonatomic, strong) NSString *titleString;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UITextView *TextField;
@property(nonatomic,strong) NSMutableDictionary *plist;
@property (nonatomic,strong) NSMutableArray *lectures;
@end

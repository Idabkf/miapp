//
//  PopoverTable.h
//  testmi
//
//  Created by Sandra Zollner on 17.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverTable : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleString;
@property(nonatomic,strong) NSMutableDictionary *plist;
@property (nonatomic,strong) NSMutableArray *lectures;
@end

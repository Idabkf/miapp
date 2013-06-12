//
//  PageViewController.h
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "ViewController1.h"

@interface PageViewController : UIViewController
<UIPageViewControllerDataSource>
{
    UIPageViewController *pageController;
    int pageindex;
}
@property (strong, nonatomic) UIPageViewController *pageController;

@end
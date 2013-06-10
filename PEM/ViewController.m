//
//  ViewController.m
//  PEM
//
//  Created by Sandra Zollner on 30.05.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import "ViewController.h"
#import "cvCell.h"
#import "semesterHeader.h"
#import "FPPopoverController.h"
#import "PopoverViewController.h"


@interface ViewController ()
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //example data in dataArray
    NSMutableArray *firstSection = [[NSMutableArray alloc] init]; NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    
    [firstSection addObject:[NSString stringWithFormat:@"Einführung in die Programmmierung"]];
    [firstSection addObject:[NSString stringWithFormat:@"Analysis für Informatiker und Statistiker"]];
    [firstSection addObject:[NSString stringWithFormat:@"Digitale Medien"]];
    [secondSection addObject:[NSString stringWithFormat:@"Programmierung und Modellierung"]];
    [secondSection addObject:[NSString stringWithFormat:@"Algorithmen und Datenstrukturen"]];
    [secondSection addObject:[NSString stringWithFormat:@"Rechnerarchitektur"]];
    
    //self.dataArray = [[NSArray alloc] initWithObjects:firstSection, secondSection, nil];
    
    //init cells for collection view
    [self.collectionView registerClass:[cvCell class] forCellWithReuseIdentifier:@"Cell"];
    
    //[self.collectionView registerClass:[semesterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"BachelorG"ofType:@"plist"];
    self.semestersArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    //layout for collection view
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(309, 39)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(0, 40);
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
	// Do any additional setup after loading the view, typically from a nib.
}

//how many sections we need
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.semestersArray count];
}

//how many cells in one section
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *semester = [self.semestersArray objectAtIndex:section];
    return [semester count]; }


//defines content of cells
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    cvCell *cell = (cvCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *semester = [self.semestersArray objectAtIndex:indexPath.section];
    
    NSMutableDictionary *lecture = [semester objectAtIndex:indexPath.row];
        
    [cell.titleLabel setText:[lecture objectForKey:@"lecture"]];
    
    return cell;
    
}

//headers
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        semesterHeader *headerView = (semesterHeader*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"%i. Semester", indexPath.section+1];
        NSLog(@"%@",title);
        [headerView.titleLabel setText:title];
        reusableview = headerView;
    }
    
    return reusableview;
}

//size of the insets
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*popver
    PopoverViewController *viewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"popover"];
    
    //title
    //NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    //NSString *cellData = [data objectAtIndex:indexPath.row];
    //viewController.title = nil;
    //[viewController.self.titleLabel setText:cellData];
    NSLog(@"%@", viewController.titleLabel.text);
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:viewController];
    
    popover.tint = FPPopoverDefaultTint;
    //popover.border = NO;
    //popover.tint = FPPopoverWhiteTint;
    
    popover.contentSize = CGSizeMake(290, 400);
    
    popover.arrowDirection = FPPopoverNoArrow;
    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - 20 - popover.contentSize.height/2) ];
     */
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

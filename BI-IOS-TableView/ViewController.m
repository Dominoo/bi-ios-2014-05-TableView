//
//  ViewController.m
//  BI-IOS-TableView
//
//  Created by Dominik Vesely on 21/10/14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "ViewController.h"
#import "FirstCell.h"

@interface ViewController ()
@property (weak, nonatomic) UITableView *tableView;
@property (readonly) NSMutableArray *dataArray;

@end

@implementation ViewController
@synthesize dataArray = _dataArray;



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [@[@"Petr", @"Lukáš", @"Dominik"] mutableCopy];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Titulek";
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(removeButtonAction:)];
    
    
 /*   UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView; */
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[FirstCell class] forCellReuseIdentifier:@"cell"];
    
   /* UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    self.tableView.tableHeaderView = searchBar;
    
    MySearchController *searchController = [[MySearchController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchController = searchController;
    */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)refreshControlAction:(id)sender
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
    
    
    }

- (void)addButtonAction:(id)sender
{
    [self.dataArray addObject:[[NSDate date] description]];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] ] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (void)removeButtonAction:(id)sender
{
    NSInteger random = (arc4random() % self.dataArray.count);
    [self.dataArray removeObjectAtIndex:random];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:random inSection:0] ] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.text = [indexPath description];
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"http://www.hey.fr/tools/emoji/ios_emoji_smiling_face_with_heart-shaped_eyes.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    });
    
    return cell;
}


#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}





@end

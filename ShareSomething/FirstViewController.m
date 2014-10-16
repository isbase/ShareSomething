//
//  FirstViewController.m
//  ShareSomething
//
//  Created by dev on 14-10-14.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    BOOL                _reloading;
    UIRefreshControl    *_refreshControl;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _reloading = NO;
    
    self.tableView.frame = self.view.frame;
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
    [self.tableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:(@selector(refreshControlState)) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshButtonCLick:(id)sender
{
    if (_reloading || _refreshControl.refreshing) return;
    NSLog(@"走了   %f",self.tableView.contentOffset.y);
    
    self.tableView.contentOffset = CGPointMake(0, -64);
    if (self.tableView.contentOffset.y == -64) {
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^(void){
                             self.tableView.contentOffset = CGPointMake(0, - 150);
                         } completion:^(BOOL finished){
                             [_refreshControl beginRefreshing];
                             [_refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
                         }];
    }
}



-(void)refreshControlState
{
    
    _reloading = YES;
    NSLog(@"刷新");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_refreshControl endRefreshing];
        _reloading = NO;
    });
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

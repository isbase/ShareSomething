//
//  FirstViewController.h
//  ShareSomething
//
//  Created by dev on 14-10-14.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;



-(IBAction)refreshButtonCLick:(id)sender;

@end


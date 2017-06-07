//
//  YourOrdersViewController.h
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourOrdersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *yourOrdersArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *yourOrdersTableView;
@property (strong, nonatomic) IBOutlet UILabel *statusLbl;
@property (strong, nonatomic)  NSString *From;



@end

//
//  Shipping_Info.h
//  SteelonCall
//
//  Created by Manoyadav on 13/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.

#import <UIKit/UIKit.h>
#import "Shipping_info_cell.h"
#import "Shipping_lastCell.h"

@interface Shipping_Info : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *Dict;
    NSString *S_H_Price;
}
@property (strong, nonatomic) IBOutlet UITableView *shipping_table;
@property (strong, nonatomic) NSDictionary *json_dict;

@end

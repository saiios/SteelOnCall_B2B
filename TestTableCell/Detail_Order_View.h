//
//  Detail_Order_View.h
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail_Order.h"
#import "Detail_Order_Cell_0.h"
#import "Detail_Order_LastCell.h"
#import "STParsing.h"
#import "UIImageView+WebCache.h"

@interface Detail_Order_View : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *user_data;
    NSString *user_id;
    NSArray *Ordered_Products,*Orders_Dictionary;
    NSArray *Orders_Dict,*Payment_Dict,*Shipment_Dict;
}
@property (strong,nonatomic) NSString *mainProductId;

@property (strong, nonatomic) IBOutlet UITableView *Orders_table;

@end

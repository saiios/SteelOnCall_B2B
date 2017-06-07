//
//  Shipping_info_cell.h
//  SteelonCall
//
//  Created by Manoyadav on 14/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shipping_info_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *sellername;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *tons;
@property (strong, nonatomic) IBOutlet UILabel *shipping;
@property (strong, nonatomic) IBOutlet UILabel *handling;
@property (strong, nonatomic) IBOutlet UILabel *subtotal;
@property (strong, nonatomic) IBOutlet UILabel *total_lbl;

@end

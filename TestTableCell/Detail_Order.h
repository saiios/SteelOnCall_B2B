//
//  Detail_Order.h
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail_Order : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *border_view;
@property (strong, nonatomic) IBOutlet UIView *Buttons_view;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIImageView *img;

@end

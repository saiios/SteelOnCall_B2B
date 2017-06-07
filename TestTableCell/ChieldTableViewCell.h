//
//  ChieldTableViewCell.h
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewNode.h"
@interface ChieldTableViewCell : UITableViewCell
@property (retain, strong) TreeViewNode *treeNode;
@property (nonatomic) BOOL isExpanded;
@property (strong, nonatomic) IBOutlet UILabel *chield_lbl;

@end

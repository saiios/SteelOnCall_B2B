//
//  CateGoryTableViewCell.h
//  SteelonCall
//
//  Created by Manoyadav on 03/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewNode.h"
@interface CateGoryTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *cellLabel;
@property (retain, nonatomic) IBOutlet UIButton *cellButton;
@property (retain, strong) TreeViewNode *treeNode;
- (IBAction)cellClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *expandBtn;

- (IBAction)expand:(id)sender;
- (void)setTheButtonBackgroundImage:(UIImage *)backgroundImage;
@end

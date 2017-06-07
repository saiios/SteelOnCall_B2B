//
//  MainTableViewCell.m
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)mainCellClicked:(UIButton *)sender {
    if (sender.selected) {
        [sender setSelected:NO];
        self.treeNode.isExpanded = !self.treeNode.isExpanded;
        // [self setSelected:NO];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProjectTreeNodeButtonClicked" object:self];

        
    }else{
        [sender setSelected:YES];
        if (self.treeNode.nodeLevel == 0) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"close" object:self];
        }
        
        
        self.treeNode.isExpanded = !self.treeNode.isExpanded;
       // [self setSelected:NO];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProjectTreeNodeButtonClicked" object:self];
        
    }
}

@end

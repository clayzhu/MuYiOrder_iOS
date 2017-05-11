//
//  BaseTextLabelCell.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/11.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextLabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@property (weak, nonatomic) IBOutlet UIView *editingIndicatorLine;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

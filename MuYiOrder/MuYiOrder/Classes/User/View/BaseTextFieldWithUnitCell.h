//
//  BaseTextFieldWithUnitCell.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/11.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextFieldWithUnitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIView *editingIndicatorLine;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

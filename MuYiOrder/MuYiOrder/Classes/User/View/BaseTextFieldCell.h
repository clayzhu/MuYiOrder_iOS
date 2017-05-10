//
//  BaseTextFieldCell.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/4.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *editingIndicatorLine;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

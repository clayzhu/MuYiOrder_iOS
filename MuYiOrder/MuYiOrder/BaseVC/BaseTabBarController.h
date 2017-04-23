//
//  BaseTabBarController.h
//  Baicheng
//
//  Created by Apple on 2017/4/10.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

- (UIViewController *)setWithStoryboardName:(NSString *)sbName
                           viewControllerId:(NSString *)vcId
                                      title:(NSString *)title
                                      image:(NSString *)imageName
                              selectedImage:(NSString *)selectedImageName;

@end

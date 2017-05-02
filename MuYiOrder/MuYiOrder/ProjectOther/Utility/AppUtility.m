//
//  AppUtility.m
//  TianChengSoundbox
//
//  Created by ug19 on 15/12/23.
//  Copyright © 2015年 Ugood. All rights reserved.
//

#import "AppUtility.h"

@implementation AppUtility

/** Determine whether user sign in*/
+ (BOOL)isSignedIn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kLogined];
}

+ (void)signIn {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLogined];
}

+ (void)signOut {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLogined];
    [BmobUser logout];
}

+ (NSString *)deviceTokenStringFromData:(NSData *)deviceToken {
	NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
																					  withString:@""]
								 stringByReplacingOccurrencesOfString:@">"
								 withString:@""]
								stringByReplacingOccurrencesOfString:@" "
								withString:@""];
	return deviceTokenStr;
}

+ (void)saveDeviceTokenData:(NSData *)deviceToken {
	NSString *deviceTokenStr = [AppUtility deviceTokenStringFromData:deviceToken];
	[[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:kDeviceToken];
}

+ (NSString *)getDeviceToken {
	return [[NSUserDefaults standardUserDefaults] stringForKey:kDeviceToken];
}

+ (void)removeDeviceToken {
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:kDeviceToken];
}

@end

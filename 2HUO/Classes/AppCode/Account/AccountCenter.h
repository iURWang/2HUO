//
//  Account.h
//  2HUO
//
//  Created by iURCoder on 4/7/16.
//  Copyright © 2016 iUR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@class User;

typedef NS_ENUM(NSUInteger, UserLoginType) {
    UserLoginTypeWeiBo                = 0,
    UserLoginTypeOICQ                 = 1,
    
};

typedef void (^RegCallBack)(BOOL success);
typedef void (^GetSMSCodeCallBack)(BOOL success);
typedef void (^UpdateUserCallBack)(BOOL success);
typedef void (^UserLoginCallBack)(BOOL success);
typedef void (^UserLoginResultBlock)(BOOL success, User * user);
typedef void (^UserLogoutCallBack)(BOOL success);
typedef void (^ClearCacheCallBack)(BOOL success,CGFloat progress);

@interface AccountCenter : NSObject

@property (nonatomic, strong) User     * user;
@property (nonatomic,   copy) NSString * token;
@property (nonatomic, strong) UIImage  * userHeadFace;

+ (instancetype)shareInstance;

- (void)save:(User *)user;

- (void)login:(UMSocialSnsType)type viewController:(UIViewController*)viewController complete:(UserLoginCallBack)complete;

- (void)logout;

- (void)logoutWithType:(UMSocialSnsType)type;

- (void)clearCache:(ClearCacheCallBack)callback;

- (void)updateUserInfo:(NSDictionary *)info complete:(UpdateUserCallBack)complete;

- (void)getSMSCode:(NSString *)phone complete:(GetSMSCodeCallBack)complete;

- (void)regWithParams:(NSDictionary *)params complete:(RegCallBack)complete;

- (void)loginWithParams:(NSDictionary *)params complete:(RegCallBack)complete;

@end

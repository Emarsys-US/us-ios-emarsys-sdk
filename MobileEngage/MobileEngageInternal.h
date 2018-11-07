//
// Copyright (c) 2017 Emarsys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAppLoginParameters.h"
#import "EMSNotification.h"
#import "MEInAppTrackingProtocol.h"
#import "EMSResponseModel.h"
#import "EMSRequestManager.h"
#import "EMSPushNotificationProtocol.h"

@protocol MobileEngageStatusDelegate;
@class EMSConfig;
@class MENotificationCenterManager;
@class MERequestContext;
@class MEInApp;
@class MERequestModelRepositoryFactory;
@class MELogRepository;
@class EMSNotificationCache;

NS_ASSUME_NONNULL_BEGIN

typedef void (^MESuccessBlock)(NSString *requestId, EMSResponseModel *);

typedef void (^MEErrorBlock)(NSString *requestId, NSError *error);

typedef void (^MESourceHandler)(NSString *source);


@interface MobileEngageInternal : NSObject <MEInAppTrackingProtocol, EMSPushNotificationProtocol>

@property(nonatomic, strong) EMSRequestManager *requestManager;
@property(nonatomic, strong) MESuccessBlock successBlock;
@property(nonatomic, strong) MEErrorBlock errorBlock;

@property(nonatomic, weak, nullable) id <MobileEngageStatusDelegate> statusDelegate;
@property(nonatomic, strong) NSData *pushToken;
@property(nonatomic, strong, nullable) MENotificationCenterManager *notificationCenterManager;
@property(nonatomic, strong) MERequestContext *requestContext;

- (instancetype)initWithRequestManager:(EMSRequestManager *)requestManager
                        requestContext:(MERequestContext *)requestContext
                     notificationCache:(EMSNotificationCache *)notificationCache;

- (BOOL)trackDeepLinkWith:(NSUserActivity *)userActivity
            sourceHandler:(nullable MESourceHandler)sourceHandler;

- (void)appLogin;

- (void)appLoginWithCompletionBlock:(EMSCompletionBlock)completionBlock;

- (void)appLoginWithContactFieldValue:(NSString *)contactFieldValue;

- (void)appLoginWithContactFieldValue:(NSString *)contactFieldValue
                      completionBlock:(EMSCompletionBlock)completionBlock;


- (void)trackCustomEvent:(nonnull NSString *)eventName
         eventAttributes:(NSDictionary<NSString *, NSString *> *)eventAttributes;

- (void)trackCustomEvent:(nonnull NSString *)eventName
         eventAttributes:(NSDictionary<NSString *, NSString *> *)eventAttributes
         completionBlock:(EMSCompletionBlock)completionBlock;

- (NSString *)trackInternalCustomEvent:(NSString *)eventName
                       eventAttributes:(nullable NSDictionary<NSString *, NSString *> *)eventAttributes
                       completionBlock:(nullable EMSCompletionBlock)completionBlock;


- (void)appLogout;
- (void)appLogoutWithCompletionBlock:(EMSCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

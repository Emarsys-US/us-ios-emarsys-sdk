#import "Kiwi.h"
#import "MERequestContext.h"
#import "EMSUUIDProvider.h"
#import "EMSDeviceInfo.h"

SPEC_BEGIN(MERequestContextTests)


        __block EMSUUIDProvider *uuidProvider = [EMSUUIDProvider new];
        __block EMSTimestampProvider *timestampProvider = [EMSTimestampProvider new];
        __block EMSDeviceInfo *deviceInfo = [EMSDeviceInfo new];

        describe(@"intialization", ^{

            it(@"should throw exception when uuidProvider is nil", ^{
                @try {
                    MERequestContext *requestContext = [[MERequestContext alloc] initWithConfig:[EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
                            [builder setMerchantId:@"merchantId"];
                            [builder setContactFieldId:@3];
                            [builder setMobileEngageApplicationCode:@"applicationCode"];
                        }]
                                                                                   uuidProvider:nil
                                                                              timestampProvider:[EMSTimestampProvider mock]
                                                                                     deviceInfo:[EMSDeviceInfo mock]];
                    fail(@"Expected Exception when uuidProvider is nil!");
                } @catch (NSException *exception) {
                    [[exception.reason should] equal:@"Invalid parameter not satisfying: uuidProvider"];
                    [[theValue(exception) shouldNot] beNil];
                }
            });

            it(@"should throw exception when timestampProvider is nil", ^{
                @try {
                    MERequestContext *requestContext = [[MERequestContext alloc] initWithConfig:[EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
                            [builder setMerchantId:@"merchantId"];
                            [builder setContactFieldId:@3];
                            [builder setMobileEngageApplicationCode:@"applicationCode"];
                        }]
                                                                                   uuidProvider:[EMSUUIDProvider mock]
                                                                              timestampProvider:nil
                                                                                     deviceInfo:[EMSDeviceInfo mock]];
                    fail(@"Expected Exception when timestampProvider is nil!");
                } @catch (NSException *exception) {
                    [[exception.reason should] equal:@"Invalid parameter not satisfying: timestampProvider"];
                    [[theValue(exception) shouldNot] beNil];
                }
            });

            it(@"should throw exception when deviceInfo is nil", ^{
                @try {
                    MERequestContext *requestContext = [[MERequestContext alloc] initWithConfig:[EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
                            [builder setMerchantId:@"merchantId"];
                            [builder setContactFieldId:@3];
                            [builder setMobileEngageApplicationCode:@"applicationCode"];
                        }]
                                                                                   uuidProvider:[EMSUUIDProvider mock]
                                                                              timestampProvider:[EMSTimestampProvider mock]
                                                                                     deviceInfo:nil];
                    fail(@"Expected Exception when deviceInfo is nil!");
                } @catch (NSException *exception) {
                    [[exception.reason should] equal:@"Invalid parameter not satisfying: deviceInfo"];
                    [[theValue(exception) shouldNot] beNil];
                }
            });

        });

        describe(@"clientState", ^{

            beforeEach(^{
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults removeObjectForKey:kCLIENT_STATE];
                [userDefaults synchronize];
            });

            it(@"should load the stored value", ^{
                NSString *clientState = @"Stored client state";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults setObject:clientState
                                 forKey:kCLIENT_STATE];
                [userDefaults synchronize];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.clientState should] equal:clientState];
            });

            it(@"should store client state", ^{
                NSString *expectedClientState = @"Stored client state";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.clientState should] beNil];

                [context setClientState:expectedClientState];

                [[[userDefaults stringForKey:kCLIENT_STATE] should] equal:expectedClientState];
                [[context.clientState should] equal:expectedClientState];
            });
        });

        describe(@"contactToken", ^{

            beforeEach(^{
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults removeObjectForKey:kCONTACT_TOKEN];
                [userDefaults synchronize];
            });

            it(@"should load the stored value", ^{
                NSString *contactToken = @"Stored contactToken";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults setObject:contactToken
                                 forKey:kCONTACT_TOKEN];
                [userDefaults synchronize];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.contactToken should] equal:contactToken];
            });

            it(@"should store contact token", ^{
                NSString *expectedContactToken = @"Stored contact token";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.contactToken should] beNil];

                [context setContactToken:expectedContactToken];

                [[[userDefaults stringForKey:kCONTACT_TOKEN] should] equal:expectedContactToken];
                [[context.contactToken should] equal:expectedContactToken];
            });
        });

        describe(@"refreshToken", ^{

            beforeEach(^{
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults removeObjectForKey:kREFRESH_TOKEN];
                [userDefaults synchronize];
            });

            it(@"should load the stored value", ^{
                NSString *refreshToken = @"Stored refreshToken";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults setObject:refreshToken
                                 forKey:kREFRESH_TOKEN];
                [userDefaults synchronize];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.refreshToken should] equal:refreshToken];
            });

            it(@"should store refresh token", ^{
                NSString *expectedRefreshToken = @"Stored refresh token";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.refreshToken should] beNil];

                [context setRefreshToken:expectedRefreshToken];

                [[[userDefaults stringForKey:kREFRESH_TOKEN] should] equal:expectedRefreshToken];
                [[context.refreshToken should] equal:expectedRefreshToken];
            });
        });

        describe(@"contactFieldValue", ^{

            beforeEach(^{
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults removeObjectForKey:kCONTACT_FIELD_VALUE];
                [userDefaults synchronize];
            });

            it(@"should load the stored value", ^{
                NSString *contactFieldValue = @"Stored contactFieldValue";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                [userDefaults setObject:contactFieldValue
                                 forKey:kCONTACT_FIELD_VALUE];
                [userDefaults synchronize];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.contactFieldValue should] equal:contactFieldValue];
            });

            it(@"should store contactFieldValue", ^{
                NSString *expectedContactFieldValue = @"Stored contactFieldValue";

                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];

                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [[context.contactFieldValue should] beNil];

                [context setContactFieldValue:expectedContactFieldValue];

                [[[userDefaults stringForKey:kCONTACT_FIELD_VALUE] should] equal:expectedContactFieldValue];
                [[context.contactFieldValue should] equal:expectedContactFieldValue];
            });

        });

        describe(@"reset", ^{

            it(@"should clear contactFieldValue, contactToken, refreshToken", ^{
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kEMSSuiteName];
                MERequestContext *context = [[MERequestContext alloc] initWithConfig:[EMSConfig nullMock]
                                                                        uuidProvider:uuidProvider
                                                                   timestampProvider:timestampProvider
                                                                          deviceInfo:deviceInfo];
                [userDefaults setObject:@"testContactFieldValue"
                                 forKey:kCONTACT_FIELD_VALUE];
                [userDefaults setObject:@"testContactToken"
                                 forKey:kCONTACT_TOKEN];
                [userDefaults setObject:@"testRefreshToken"
                                 forKey:kREFRESH_TOKEN];
                [userDefaults synchronize];

                [context reset];

                [[userDefaults stringForKey:kCONTACT_FIELD_VALUE] shouldBeNil];
                [[userDefaults stringForKey:kCONTACT_TOKEN] shouldBeNil];
                [[userDefaults stringForKey:kREFRESH_TOKEN] shouldBeNil];
            });
        });

SPEC_END

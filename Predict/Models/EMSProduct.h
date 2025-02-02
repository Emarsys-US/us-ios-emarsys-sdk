//
// Copyright (c) 2019 Emarsys. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "EMSProductBuilder.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EMSProductBuilderBlock)(EMSProductBuilder *builder);

@interface EMSProduct : NSObject

@property(nonatomic, readonly) NSString *productId;
@property(nonatomic, readonly) NSString *title;
@property(nonatomic, readonly) NSURL *linkUrl;
@property(nonatomic, readonly) NSDictionary<NSString *, NSString *> *customFields;
@property(nonatomic, readonly, nullable) NSURL *imageUrl;
@property(nonatomic, readonly, nullable) NSURL *zoomImageUrl;
@property(nonatomic, readonly, nullable) NSString *categoryPath;
@property(nonatomic, readonly, nullable) NSNumber *available;
@property(nonatomic, readonly, nullable) NSString *productDescription;
@property(nonatomic, readonly, nullable) NSNumber *price;
@property(nonatomic, readonly, nullable) NSNumber *msrp;
@property(nonatomic, readonly, nullable) NSString *album;
@property(nonatomic, readonly, nullable) NSString *actor;
@property(nonatomic, readonly, nullable) NSString *artist;
@property(nonatomic, readonly, nullable) NSString *author;
@property(nonatomic, readonly, nullable) NSString *brand;
@property(nonatomic, readonly, nullable) NSNumber *year;

+ (instancetype)makeWithBuilder:(EMSProductBuilderBlock)builderBlock;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToProduct:(EMSProduct *)product;

- (NSUInteger)hash;

@end

NS_ASSUME_NONNULL_END
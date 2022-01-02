//
//  CABackdropLayer.h
//  Button
//
//  Created by Oskar Groth on 2021-12-14.
//

#ifndef CABACKDROPLAYER_H
#define CABACKDROPLAYER_H

#include <QuartzCore/CALayer.h>

CA_EXTERN_C_BEGIN

@interface CALayer (Private)

@property (assign) BOOL allowsGroupBlending;
@property (assign) BOOL shadowPathIsBounds;

@end

CA_EXTERN_C_END

CA_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN


@class CABackdropLayer;

@protocol CABackdropLayerDelegate <CALayerDelegate>

@optional

- (void)backdropLayerStatisticsDidChange:(CABackdropLayer *)layer;

@end

@interface CABackdropLayer: CALayer

@property BOOL ignoresOffscreenGroups;
@property BOOL windowServerAware;
@property CGFloat bleedAmount;
@property CGFloat statisticsInterval;
@property (copy) NSString *statisticsType;
@property BOOL disablesOccludedBackdropBlurs;
@property BOOL allowsInPlaceFiltering;
@property BOOL captureOnly;
@property CGFloat marginWidth;
@property CGRect backdropRect;
@property CGFloat scale;
@property BOOL usesGlobalGroupNamespace;
@property (copy) NSString *groupName;
@property (getter=isEnabled) BOOL enabled;

@end

/** Backdrop layer statistics keys. **/

CA_EXTERN NSString * const kCABackdropStatisticsNone;
CA_EXTERN NSString * const kCABackdropStatisticsType1;
CA_EXTERN NSString * const kCABackdropStatisticsTime;
CA_EXTERN NSString * const kCABackdropStatisticsType;
CA_EXTERN NSString * const kCABackdropStatisticsRedAverage;
CA_EXTERN NSString * const kCABackdropStatisticsGreenAverage;
CA_EXTERN NSString * const kCABackdropStatisticsBlueAverage;
CA_EXTERN NSString * const kCABackdropStatisticsLuminanceStandardDeviation;

NS_ASSUME_NONNULL_END

CA_EXTERN_C_END

#endif // CABACKDROPLAYER_H


//
//  TDStickerLibraryExtension.h
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/7/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef _TDStickerLibrary_TDStickerLibraryExtension_H_
    #define _TDStickerLibrary_TDStickerLibraryExtension_H_

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare protocol for TDStickerLibraryExtensionProgressDelegate
//  ------------------------------------------------------------------------------------------------
@protocol TDStickerLibraryExtensionProgressDelegate <NSObject>
@required

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when procedure maybe to show progress, call the delegate method.
 *  when procedure maybe to show progress, call the delegate method.
 */
- ( void ) showExtensionProgress;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when procedure maybe to dismiss progress, call the delegate method.
 *  when procedure maybe to dismiss progress, call the delegate method.
 */
- ( void ) dismissExtensionProgress;


@optional
//  --------------------------------
//  ------------------------------------------------------------------------------------------------
//  TODO: FURTURE, to implement. now is unimplementation by caller. (因為系統還沒有總和值, 現在沒得取百分比 ... )
/**
 *  @brief when procedure maybe to get progress's percent, call the delegate method.
 *
 *  @param percent                  percent of progress. (value is 0 ~ 1.0f)
 */
- ( void ) extensionProgressProgressing:(CGFloat)percent;
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
#pragma mark declare protocol for TDStickerLibraryExtensionDelegate
//  ------------------------------------------------------------------------------------------------
/**
 *  to centralize others sub-delegate into this delegate; for Sticker Library System.
 */
//  把其他對外的次有的 delegate 全都集中到這個主要的 delegate 上面.
@protocol TDStickerLibraryExtensionDelegate <NSObject, TDStickerLibraryExtensionProgressDelegate>

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



#endif  //  End of _TDStickerLibrary_TDStickerLibraryExtension_H_.















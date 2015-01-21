//
//  TDStickerLibraryTabInfo.m
//  DemoStickerLibrary
//
//  Created by Robin Hsu on 2015/1/21.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDStickerLibraryTabInfo.h"

@implementation TDStickerLibraryTabInfo

// ※ 環境設定新建一個 default class 之類的方式, 把一些相關設定值都預設進去裡頭, 如果開發人員讓 object = nil 帶入, 就自建一個 default 的 出來傳遞,
//  如果有 new 這個 class 就帶入這個 new 出來的 class 的值... 這樣應該不錯用才是 @@~

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------
+ (instancetype) loadData:(NSString *)filename
{
    if ( nil == filename )
    {
        return nil;
    }
    
    TDStickerLibraryTabInfo       * info;
    
    info                            = [[TDStickerLibraryTabInfo alloc] init];
    if ( nil == info )
    {
        return nil;
    }
    
    
    return info;
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

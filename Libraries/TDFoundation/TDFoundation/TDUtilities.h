//
//  TDUtilities.h
//  TDFoundation
//
//  Created by Robin Hsu on 2015/1/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDUtilities : NSObject

@end

typedef NS_ENUM( NSUInteger, TDGetPathDirectory ) {
    TDLibraryDirectory              = NSLibraryDirectory,
    TDDocumentDirectory             = NSDocumentDirectory,
    TDCachesDirectory               = NSCachesDirectory,
    
    TDHomeDirectory                 = 201,
    TDTemporaryDirectory            = 202,
    
    TDResourcesDirectory            = 301,
    
};


//  ------------------------------------------------------------------------------------------------
NSString * TDGetPathForDirectories( TDGetPathDirectory directory, NSString * name, NSString * typeExt, NSString * inDirectorySubpath );


//  ------------------------------------------------------------------------------------------------




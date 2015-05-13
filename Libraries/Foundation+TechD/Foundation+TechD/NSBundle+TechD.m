//
//  NSBundle+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/4/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "NSBundle+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation NSBundle (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
+ ( NSBundle *) assetBundle:(NSString *)bundleName with:(Class)aClass
{
    NSParameterAssert( nil != bundleName );
    NSParameterAssert( nil != aClass );
    
    NSBundle                      * bundle;
    NSString                      * bundleResourcePath;
    
    bundle                          = [NSBundle bundleForClass: aClass];
    NSParameterAssert( nil != bundle );
    bundleResourcePath              = [bundle resourcePath];
    NSParameterAssert( nil != bundleResourcePath );
    bundleResourcePath              = [bundleResourcePath stringByAppendingPathComponent: bundleName];
    NSParameterAssert( nil != bundleResourcePath );
    return [NSBundle bundleWithPath: bundleResourcePath];
}

//  ------------------------------------------------------------------------------------------------
+ ( NSString * ) localizedStringForKey:(NSString *)akey with:(NSString *)tableName inBundle:(NSString *)bundleName with:(Class)aClass
{
    return NSLocalizedStringFromTableInBundle( akey, tableName, [NSBundle assetBundle: bundleName with: aClass], nil );
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


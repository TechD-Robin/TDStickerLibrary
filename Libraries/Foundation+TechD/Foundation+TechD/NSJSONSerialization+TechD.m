//
//  NSJSONSerialization+TechD.m
//  Foundation+TechD
//
//  Created by Robin Hsu on 2015/3/20.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import "NSJSONSerialization+TechD.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@implementation NSJSONSerialization (TechD)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) saveJSONContainer:(NSDictionary *)container toFileAtPath:(NSString *)filepath
{
    if ( ( nil == container ) || ( nil == filepath ) )
    {
        return NO;
    }
    
    NSError                   * error;
    NSFileManager             * manager;
    NSOutputStream            * outputStream;
    
    error                       = nil;
    outputStream                = nil;
    manager                     = [NSFileManager defaultManager];
    
    //  first, remove the exist file.
    if ( [manager fileExistsAtPath: filepath] == YES )
    {
        if ( [manager removeItemAtPath: filepath error: &error] == NO )
        {
            NSLog( @"delete file error : %@", error );
        }
    }
    
    //  second, save container to file.
    outputStream                = [NSOutputStream outputStreamToFileAtPath: filepath append: NO];
    if ( nil == outputStream )
    {
        NSLog( @"save json to file error." );
        return NO;
    }
    
    [outputStream               open];
    [NSJSONSerialization        writeJSONObject: container toStream: outputStream options: 0 error: &error];
    if ( nil != error )
    {
        NSLog( @"json data save to file error :%@", error );
        [outputStream           close];
        return NO;
    }
    
    //  finish.
    [outputStream               close];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


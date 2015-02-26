//
//  TDUtilities.m
//  TDFoundation
//
//  Created by Robin Hsu on 2015/1/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "TDUtilities.h"

@implementation TDUtilities

@end


//  ------------------------------------------------------------------------------------------------
NSString * TDGetPathForDirectories( TDGetPathDirectory directory, NSString * name, NSString * typeExt, NSString * inDirectorySubpath )
{

    NSArray                       * searchList;
    NSString                      * searchPath;
    NSString                      * filename;
    NSString                      * filenameWithExt;
    
    searchList                      = nil;
    searchPath                      = nil;
    filename                        = nil;
    filenameWithExt                 = nil;
    switch ( directory )
    {
        case TDLibraryDirectory:
        case TDDocumentDirectory:
        case TDCachesDirectory:
        {
            searchList              = NSSearchPathForDirectoriesInDomains( (NSSearchPathDirectory)directory, NSUserDomainMask, YES );
            searchPath              = [searchList objectAtIndex: 0];
            break;
        }
        case TDHomeDirectory:
        {
            searchPath              = NSHomeDirectory();
            break;
        }
        case TDTemporaryDirectory:
        {
            searchPath              = [NSTemporaryDirectory() stringByStandardizingPath];
            break;
        }
        case TDResourcesDirectory:
        {
            filename                = [[NSBundle mainBundle] pathForResource: name ofType: typeExt inDirectory: inDirectorySubpath];
            return filename;
        }
            
        default:
        {
            return nil;
        }
    }
    
    if ( ( nil != inDirectorySubpath ) && ( [inDirectorySubpath isEqualToString: @""] == NO ) )
    {
        searchPath                  = [searchPath stringByAppendingFormat: @"/%s", [inDirectorySubpath UTF8String]];
    }
    filename                        = [searchPath stringByAppendingFormat: @"/%s", [name UTF8String]];
    
    
    if ( ( nil != typeExt ) && ( [typeExt isEqualToString: @""] == NO ) )
    {
        //filename                    = [filename stringByAppendingFormat: @".%s", [typeExt UTF8String]];
        filename                    = [filename stringByAppendingPathExtension: typeExt];
    }

    if ( [[NSFileManager defaultManager] fileExistsAtPath: filename] == NO )
    {
        return nil;
    }

    return filename;
}


//  ------------------------------------------------------------------------------------------------
NSString * TDGetImageNameForScreenScale( NSString * imageName, NSInteger scaleScreen )
{
    if ( nil == imageName )
    {
        return nil;
    }
    
    // split & check aKey
    NSString                      * file;
    NSString                      * extension;
    
    file                            = imageName;
    extension                       = [imageName pathExtension];
    if ( [[extension lowercaseString] isEqualToString: @"png"] == YES )
    {
        return imageName;
    }
    if ( ( nil != extension ) && ( [extension length] != 0 ) )
    {
        file                            = [imageName substringToIndex: ( [imageName length] - 4 )];
    }
    
    file                            = [NSString stringWithFormat: @"%s@%dx", [file UTF8String], scaleScreen];
    imageName                       = [file stringByAppendingPathExtension: @"png"];
    return imageName;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------













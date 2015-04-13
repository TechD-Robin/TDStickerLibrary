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
NSString * TDGetPathForDirectories( TDGetPathDirectory directory, NSString * name, NSString * typeExt, NSString * inDirectorySubpath, BOOL checkFileExist )
{

    NSArray                       * searchList;
    NSString                      * searchPath;
    NSString                      * filename;
    
    searchList                      = nil;
    searchPath                      = nil;
    filename                        = nil;
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
        //searchPath                  = [searchPath stringByAppendingFormat: @"/%s", [inDirectorySubpath UTF8String]];
        searchPath                  = [searchPath stringByAppendingPathComponent: inDirectorySubpath];
    }
    //filename                        = [searchPath stringByAppendingFormat: @"/%s", [name UTF8String]];
    filename                        = [searchPath stringByAppendingPathComponent: name];
    
    
    if ( ( nil != typeExt ) && ( [typeExt isEqualToString: @""] == NO ) )
    {
        //filename                    = [filename stringByAppendingFormat: @".%s", [typeExt UTF8String]];
        filename                    = [filename stringByAppendingPathExtension: typeExt];
    }

    if ( ( YES == checkFileExist ) && ( [[NSFileManager defaultManager] fileExistsAtPath: filename] == NO ) )
    {
        return nil;
    }

    return filename;
}

//  ------------------------------------------------------------------------------------------------
NSString * TDGetPathForDirectoriesWithTimestamp( TDGetPathDirectory directory, NSString * name, NSString * timestamp, NSString * typeExt, NSString * inDirectorySubpath, BOOL checkFileExist )
{
    NSString                      * filename;
    
    filename                        = name;
    if ( ( nil != typeExt ) && ( [typeExt length] > 0 ) )
    {
        filename                    = [filename stringByAppendingPathExtension: typeExt];
    }
    if ( ( nil != timestamp ) && ( [timestamp length] > 0 ) )
    {
        filename                    = [filename stringByAppendingPathExtension: timestamp];
    }
    
    filename                        = TDGetPathForDirectories( directory, [filename stringByDeletingPathExtension], [filename pathExtension], inDirectorySubpath, checkFileExist );
    if ( nil == filename )
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
    
    file                            = [NSString stringWithFormat: @"%s@%dx", [file UTF8String], (int)scaleScreen];
    imageName                       = [file stringByAppendingPathExtension: @"png"];
    return imageName;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------













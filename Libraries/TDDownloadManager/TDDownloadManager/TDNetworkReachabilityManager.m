//
//  TDNetworkReachabilityManager.m
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/10.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <netinet/in.h>
#import <arpa/inet.h>               //  for solve : implicit declaration of function ‘inet_ntop’ is invalid C99.

#import "TDNetworkReachabilityManager.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief define type for AFNetwork Reachability Status's callback block.
 *  define type for AFNetwork Reachability Status's callback block.
 *
 *  @param status                   the various reachability states.
 *
 *  @return void                    nothing.
 */
typedef     void (^AFNetworkReachabilityStatusBlock)(AFNetworkReachabilityStatus status);


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDNetworkReachabilityManager

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDNetworkReachabilityManager ()
{
    /**
     *  the container of manager object.
     */
    NSMutableArray                * afManagerContainer;
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDNetworkReachabilityManager (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) _ShareManager;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for i/o container data.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief insert a manager object into container.
 *  insert a manager object into container.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _InsertManager:(AFNetworkReachabilityManager *)afManager;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief remove a manager object from container.
 *  remove a manager object from container.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _RemoveManager:(AFNetworkReachabilityManager *)afManager;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief keeping be allocated memory for manager object.
 *  keeping be allocated memory for manager object; because ARC mode will auto release the manager object when run to method end.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) _KeepingManager:(AFNetworkReachabilityManager *)afManager;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief release be allocated memory for manager object.
 *  release be allocated memory for manager object; release the manager object when run the callback method finish at last.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) _ReleaseManager:(AFNetworkReachabilityManager *)afManager;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check procedure of network reachable.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the network reachability status.
 *  check the network reachability status with a status block to be executed when check finish.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *  @param statusBlock              a status block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) _CheckReachabilityStatus:(AFNetworkReachabilityManager *)afManager withStatusBlock:(void (^)(AFNetworkReachabilityStatus status))statusBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the network reachability status.
 *  check the network reachability status with a reachable block to be executed when check finish.
 *
 *  @param afManager                a AFNetworkReachability's manager object.
 *  @param reachableBlock           a reachable block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) _CheckReachabilityStatus:(AFNetworkReachabilityManager *)afManager withResultBlock:(void (^)(BOOL isReachable))reachableBlock;


//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDNetworkReachabilityManager (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    afManagerContainer              = [[NSMutableArray alloc] init];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) _ShareManager
{
    static  TDNetworkReachabilityManager  * manager = nil;
    static  dispatch_once_t                 onceToken;
    
    dispatch_once( &onceToken, ^{
        
        manager                     = [[self alloc] init];
    });
    return manager;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o container data.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _InsertManager:(AFNetworkReachabilityManager *)afManager
{
    if ( nil == afManager )
    {
        return NO;
    }
    
    [afManagerContainer             addObject: afManager];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _RemoveManager:(AFNetworkReachabilityManager *)afManager
{
    if ( nil == afManager )
    {
        return NO;
    }
    
    [afManagerContainer             removeObject: afManager];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) _KeepingManager:(AFNetworkReachabilityManager *)afManager
{
    if ( nil == afManager )
    {
        return NO;
    }
    
    TDNetworkReachabilityManager  * managerSelf;
    
    managerSelf                     = [TDNetworkReachabilityManager _ShareManager];
    if ( nil == managerSelf )
    {
        return NO;
    }
    [managerSelf                    _InsertManager: afManager];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) _ReleaseManager:(AFNetworkReachabilityManager *)afManager
{
    if ( nil == afManager )
    {
        return NO;
    }
    
    TDNetworkReachabilityManager  * managerSelf;
    
    managerSelf                     = [TDNetworkReachabilityManager _ShareManager];
    if ( nil == managerSelf )
    {
        return NO;
    }
    [managerSelf                    _RemoveManager: afManager];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for check procedure of network reachable.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) _CheckReachabilityStatus:(AFNetworkReachabilityManager *)afManager withStatusBlock:(void (^)(AFNetworkReachabilityStatus status))statusBlock
{
    if ( ( nil == afManager ) || ( nil == statusBlock ) )
    {
        return NO;
    }
    
    __weak __typeof(afManager)      blockManager;
    __weak __typeof(statusBlock)    blockStatusBlock;
    
    blockManager                    = afManager;
    blockStatusBlock                = statusBlock;
    [TDNetworkReachabilityManager   _KeepingManager: afManager];            //  when ARC & nothing to keep the allocated memory, so must keep it.
    [afManager                      startMonitoring];
    [afManager                      setReachabilityStatusChangeBlock: ^(AFNetworkReachabilityStatus status)
     {
         if ( nil != blockStatusBlock )
         {
             blockStatusBlock( status );
         }
         [blockManager                  stopMonitoring];
         [TDNetworkReachabilityManager  _ReleaseManager: blockManager];     // release the keeping.
     }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) _CheckReachabilityStatus:(AFNetworkReachabilityManager *)afManager withResultBlock:(void (^)(BOOL isReachable))reachableBlock
{
    if ( ( nil == afManager ) || ( nil == reachableBlock ) )
    {
        return NO;
    }
    
    __weak __typeof(afManager)      blockManager;
    __weak __typeof(reachableBlock) blockReachableBlock;
    
    blockManager                    = afManager;
    blockReachableBlock             = reachableBlock;
    [TDNetworkReachabilityManager   _KeepingManager: afManager];            //  when ARC & nothing to keep the allocated memory, so must keep it.
    [afManager                      startMonitoring];
    [afManager                      setReachabilityStatusChangeBlock: ^(AFNetworkReachabilityStatus status)
     {
         BOOL                       reachable;
         
         reachable                  = ( ( AFNetworkReachabilityStatusReachableViaWWAN <= status ) ? YES : NO );
         if ( nil != blockReachableBlock )
         {
             blockReachableBlock( reachable );
         }
         [blockManager                  stopMonitoring];
         [TDNetworkReachabilityManager  _ReleaseManager: blockManager];     // release the keeping.
     }];
    
    return YES;
    
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDNetworkReachabilityManager

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != afManagerContainer )
    {
        [afManagerContainer         removeAllObjects];
        //[afManagerContainer         release];
        afManagerContainer          = nil;
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the  object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) shareManager
{
    return [TDNetworkReachabilityManager _ShareManager];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for check network reachable.
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatus:(void (^)(AFNetworkReachabilityStatus status))statusBlock
{
    __weak AFNetworkReachabilityStatusBlock blockStatusBlock;
    
    blockStatusBlock                = statusBlock;
    [[AFNetworkReachabilityManager  sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager  sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if ( nil != blockStatusBlock )
         {
             blockStatusBlock( status );
         }
         [[AFNetworkReachabilityManager      sharedManager] stopMonitoring];
     }];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkNetworkReachabilityStatus:(void (^)(BOOL isReachable))reachableBlock;
{
    if ( nil == reachableBlock )
    {
        return NO;
    }
    
    [[AFNetworkReachabilityManager  sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager  sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if ( AFNetworkReachabilityStatusReachableViaWWAN <= status )
         {
             reachableBlock( YES );
         }
         else
         {
             reachableBlock( NO );
         }
         [[AFNetworkReachabilityManager      sharedManager] stopMonitoring];
     }];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatusForDomain:(NSString *)domain status:(void (^)(AFNetworkReachabilityStatus status))statusBlock
{
    if ( nil == domain )
    {
        return NO;
    }
    
    AFNetworkReachabilityManager  * manager;
    
    manager                         = [AFNetworkReachabilityManager managerForDomain: domain];
    if ( nil == manager )
    {
        return NO;
    }
    return [TDNetworkReachabilityManager _CheckReachabilityStatus: manager withStatusBlock: statusBlock];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatusForDomain:(NSString *)domain result:(void (^)(BOOL isReachable))reachableBlock;
{
    if ( ( nil == domain ) || ( nil == reachableBlock ) )
    {
        return NO;
    }
    
    AFNetworkReachabilityManager  * manager;
    
    manager                         = [AFNetworkReachabilityManager managerForDomain: domain];
    if ( nil == manager )
    {
        return NO;
    }
    return [TDNetworkReachabilityManager _CheckReachabilityStatus: manager withResultBlock: reachableBlock];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatusForAddress:(NSString *)address with:(NSUInteger)port status:(void (^)(AFNetworkReachabilityStatus status))statusBlock;
{
    if ( nil == address )
    {
        return NO;
    }
    
    struct sockaddr_in              ipAddress;
    
    memset( &ipAddress, 0, sizeof( ipAddress ) );
    ipAddress.sin_len               = sizeof( ipAddress );
    ipAddress.sin_family            = AF_INET;
    ipAddress.sin_port              = htons( (unsigned short)port );
    inet_pton(AF_INET, [address UTF8String], &ipAddress.sin_addr);
    
    
    AFNetworkReachabilityManager  * manager;
    
    manager                         = [AFNetworkReachabilityManager managerForAddress: &ipAddress];
    if ( nil == manager )
    {
        return NO;
    }
    return [TDNetworkReachabilityManager _CheckReachabilityStatus: manager withStatusBlock: statusBlock];
}

//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatusForAddress:(NSString *)address with:(NSUInteger)port result:(void (^)(BOOL isReachable))reachableBlock
{
    if ( nil == address )
    {
        return NO;
    }
    
    struct sockaddr_in              ipAddress;
    
    memset( &ipAddress, 0, sizeof( ipAddress ) );
    ipAddress.sin_len               = sizeof( ipAddress );
    ipAddress.sin_family            = AF_INET;
    ipAddress.sin_port              = htons( (unsigned short)port );
    inet_pton( AF_INET, [address UTF8String], &ipAddress.sin_addr );
    
    
    AFNetworkReachabilityManager  * manager;
    
    manager                         = [AFNetworkReachabilityManager managerForAddress: &ipAddress];
    if ( nil == manager )
    {
        return NO;
    }
    return [TDNetworkReachabilityManager _CheckReachabilityStatus: manager withResultBlock: reachableBlock];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------










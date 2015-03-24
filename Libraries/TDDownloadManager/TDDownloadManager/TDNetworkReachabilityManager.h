//
//  TDNetworkReachabilityManager.h
//  TDDownloadManager
//
//  Created by Robin Hsu on 2015/3/10.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark type define.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief a block section be executed when check network reachability is completed.
 *  a block section be executed when check network reachability is completed, the parameter will return reachable status.
 *
 *  @param isReachable (YES|NO)     a boolean value, a network is reachable then the value is YES, otherwise it's NO.
 *
 *  @return void                    nothing.
 */
typedef     void (^ReachableStatusBlock)(BOOL isReachable);


//  ------------------------------------------------------------------------------------------------
/**
 *  the Network Reachability Manager provide simple method for check device's network status is reachable or not.
 *  Because build this object base on AFNetworkReachabilityManager, so ...
 *  It should not be used to prevent a user from initiating a network request, as it's possible that an initial request may be required to establish reachability. ( this line copy from AFNetworkReachabilityManager. ^^" )
 */
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDDownloadManager
@interface TDNetworkReachabilityManager : NSObject

//  ------------------------------------------------------------------------------------------------
/**
 *  * Below these method's parameter is 'statusBlock', that mean :
 *    a block object to be executed when the network availability of the `baseURL` host changes.. This block has no return value and takes a single argument which represents the various reachability states from the device to the `baseURL`. ( this line copy from AFNetworkReachabilityManager, too. ^^" )
 */

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check network reachable.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check device's network is reachable or not, which represents the various reachability states.
 *  check device's network is reachable or not, which represents the various reachability states, and get the network reachability status from callback block.
 *
 *  @param statusBlock              a status block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
//  ------------------------------------------------------------------------------------------------
+ ( BOOL ) checkReachabilityStatus:(void (^)(AFNetworkReachabilityStatus status))statusBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check device's network is reachable or not.
 *  check device's network is reachable or not, and get the network is reachable or not from callback block.
 *
 *  @param reachableBlock           a reachable block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) checkNetworkReachabilityStatus:(ReachableStatusBlock)reachableBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check network is reachable or not from the device to the 'domain', which represents the various reachability states.
 *  check network is reachable or not from the device to the 'domain', which represents the various reachability states, and get the network reachability status from callback block.
 *
 *  @param domain                   a be checked's domain name.
 *  @param statusBlock              a status block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) checkReachabilityStatusForDomain:(NSString *)domain status:(void (^)(AFNetworkReachabilityStatus status))statusBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check network is reachable or not from the device to the 'domain'.
 *  check network is reachable or not from the device to the 'domain'.
 *
 *  @param domain                   a be checked's domain name.
 *  @param reachableBlock           a reachable block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) checkReachabilityStatusForDomain:(NSString *)domain result:(ReachableStatusBlock)reachableBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check network is reachable or not from the device to the 'address', which represents the various reachability states.
 *  check network is reachable or not from the device to the 'address', which represents the various reachability states, and get the network reachability status from callback block.
 *
 *  @param address                  a ip address of socket.
 *  @param port                     a port of socket.
 *  @param statusBlock              a status block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) checkReachabilityStatusForAddress:(NSString *)address with:(NSUInteger)port status:(void (^)(AFNetworkReachabilityStatus status))statusBlock;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check network is reachable or not from the device to the 'address'.
 *  check network is reachable or not from the device to the 'address'.
 *
 *  @param address                  a ip address of socket.
 *  @param port                     a port of socket.
 *  @param reachableBlock           a reachable block section to be executed when check finish.
 *
 *  @return YES|NO                  method success or failure.
 */
+ ( BOOL ) checkReachabilityStatusForAddress:(NSString *)address with:(NSUInteger)port result:(ReachableStatusBlock)reachableBlock;


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


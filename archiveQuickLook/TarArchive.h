//
//  TarArchive.h
//  zipQuickLook
//
//  Created by Ricky Nelson on 1/13/11.
//  Copyright 2011 Lark Software, LLC. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "FileHandleCategory.h"


@interface TarArchive : NSObject {

}
-(NSString *) dump:(NSURL *)theUrl;

@end

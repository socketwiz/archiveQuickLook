//
//  ZipArchive.m
//  zipQuickLook
//
//  Created by Ricky Nelson on 1/13/11.
//  Copyright 2011 Lark Software, LLC. All rights reserved.
//

#import "ZipArchive.h"


@implementation ZipArchive
-(NSString *) dump:(NSURL *)theUrl
{
	NSMutableString *zipHtml = [[NSMutableString alloc] init];
	NSTask *zipInfo = [[NSTask alloc] init];
	[zipInfo setLaunchPath:@"/usr/bin/zipinfo"];
	
	NSArray *zipArgs = [NSArray arrayWithObjects:@"-2", @"-h", @"-z", @"-t", [theUrl path], nil];
	[zipInfo setArguments:zipArgs];
	
	NSPipe *zipPipe = [NSPipe pipe];
	[zipInfo setStandardOutput:zipPipe];
	
	NSFileHandle *zipHandle = [zipPipe fileHandleForReading];
	
	[zipInfo launch];
	
	NSString *zipFiles = [[NSString alloc] init];
	NSData *zipData = [zipHandle availableDataOrError];
	while ([zipData length] > 0) {
		zipFiles = [zipFiles stringByAppendingString: [[NSString alloc] initWithData:zipData 
																			 encoding:NSUTF8StringEncoding]];
		zipData = [zipHandle availableDataOrError];
	}

	for (NSString *line in [zipFiles componentsSeparatedByString:@"\n"]) {
		[zipHtml appendFormat:@"<span style='font-family: monospace;'>%@</span><br>", line];
	}

	return zipHtml;
}
@end

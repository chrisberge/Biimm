//
//  XMLParserInfos.h
//  Biimm
//
//  Created by Christophe Bergé on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Infos.h"
#import "BiimmAppDelegate.h"

@class BiimmAppDelegate, Infos;

@interface XMLParserInfos : NSObject{
    NSMutableString *currentElementValue;
	Infos *infos;
	BiimmAppDelegate *appDelegate;
}

- (XMLParserInfos *) initXMLParser;

@end

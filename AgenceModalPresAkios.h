//
//  AgenceModalPresAkios.h
//  Biimm
//
//  Created by Christophe Bergé on 21/12/12.
//
//

#import <UIKit/UIKit.h>

@protocol AgenceModalPresAkiosDelegate;

@interface AgenceModalPresAkios : UIViewController

@property (nonatomic, assign) id <AgenceModalPresAkiosDelegate> delegate;

@end

@protocol AgenceModalPresAkiosDelegate
- (void)agenceModalPresAkiosDidFinish:(AgenceModalPresAkios *)controller;

@end
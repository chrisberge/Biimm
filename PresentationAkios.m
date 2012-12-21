//
//  PresentationAkios.m
//  Biimm
//
//  Created by Christophe Bergé on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PresentationAkios.h"

@implementation PresentationAkios

@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //COULEUR DE FOND
    UIImage *fondImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                 [directory stringByAppendingPathComponent:@"background.png"]]];
    
    UIColor *fond;
    
    if (fondImage != nil) {
        fond = [[UIColor alloc] initWithPatternImage:fondImage];
    }
    else{
        fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    }
    
    self.view.backgroundColor = fond;
    [fond release];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImage *enTeteImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                   [directory stringByAppendingPathComponent:@"header.png"]]];
    
    if (enTeteImage == nil) {
        enTeteImage = [UIImage imageNamed:@"header.png"];
    }
    
    UIImageView *enTete = [[UIImageView alloc] initWithImage:enTeteImage];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 6;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(done:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    /*--- TEXT VIEW ---*/
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 80, 250, 300)];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    
    NSError *error = nil;
    NSString *fullPath;
    NSString *texte;
    
    fullPath = [[NSBundle mainBundle] pathForResource:@"presentation-akios" ofType:@"txt"];
    texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    
    textView.text = texte;
    
    [self.view addSubview:textView];
    /*--- TEXT VIEW ---*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)done:(id)sender
{
    [self.delegate presentationAkiosDidFinish:self];
}

@end

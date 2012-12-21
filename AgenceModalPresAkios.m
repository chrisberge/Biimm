//
//  AgenceModalPresAkios.m
//  Biimm
//
//  Created by Christophe Bergé on 21/12/12.
//
//

#import "AgenceModalPresAkios.h"

@interface AgenceModalPresAkios ()

@end

@implementation AgenceModalPresAkios

@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender
{
    [self.delegate agenceModalPresAkiosDidFinish:self];
}

@end

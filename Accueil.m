//
//  Accueil.m
//  Biimm
//
//  Created by Christophe Bergé on 23/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Accueil.h"


@implementation Accueil

@synthesize myTableViewController;
@synthesize rechercheCarte;
@synthesize whichView;
@synthesize tableauAnnonces1;
@synthesize tableauVilles;
@synthesize tableauInfos;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void) updateImages{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
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
    
    //BACKGROUND
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
    
    //FOOTER
    //BIENS
    UIImage *footerBiensImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                   [directory stringByAppendingPathComponent:@"footer_biens.png"]]];
    if (footerBiensImage != nil) {
        [appDelegate.tableNavController.tabBarItem setImage:footerBiensImage];
    }
    
    //FAVORIS
    UIImage *footerFavorisImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                        [directory stringByAppendingPathComponent:@"footer_favoris.png"]]];
    if (footerFavorisImage != nil) {
        [appDelegate.tableNavController.tabBarItem setImage:footerFavorisImage];
    }
    
    //AGENCE
    UIImage *footerAgenceImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                          [directory stringByAppendingPathComponent:@"footer_agence.png"]]];
    if (footerAgenceImage != nil) {
        [appDelegate.tableNavController.tabBarItem setImage:footerAgenceImage];
    }
    
    //CONTACT
    UIImage *footerContactImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:
                                                         [directory stringByAppendingPathComponent:@"footer_contact.png"]]];
    if (footerContactImage != nil) {
        [appDelegate.tableNavController.tabBarItem setImage:footerContactImage];
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(coverFlowAccueil:) name:@"coverFlowAccueil" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonceReady:) name:@"afficheAnnonceReady" object: nil];
    
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    
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
    
    //BANDEAU ACCUEIL
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-accueil.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    myTableViewController = [[RootViewController alloc] init];
	
	UIButton *boutonRecherche = [UIButton buttonWithType:UIButtonTypeCustom];
	//UIButton *boutonCarte = [UIButton buttonWithType:UIButtonTypeCustom];
	
	
	boutonRecherche.tag = 1;
	//boutonCarte.tag = 2;
	
	
	[boutonRecherche setFrame:CGRectMake(20, 115, 280, 46)];
	//[boutonCarte setFrame:CGRectMake(20, 85, 280, 46)];
		
	[boutonRecherche setUserInteractionEnabled:YES];
	//[boutonCarte setUserInteractionEnabled:YES];
    
    boutonRecherche.showsTouchWhenHighlighted = NO;
    //boutonCarte.showsTouchWhenHighlighted = NO;
    
	[boutonRecherche addTarget:self action:@selector(buttonPushed:) 
	 forControlEvents:UIControlEventTouchUpInside];
	/*[boutonCarte addTarget:self action:@selector(buttonPushed:) 
	 forControlEvents:UIControlEventTouchUpInside];*/
		
	UIImage *image = [self getImage:@"recherche-multicriteres"];
	[boutonRecherche setImage:image forState:UIControlStateNormal];
	
	//image = [self getImage:@"recherche-sur-la-carte"];
	//[boutonCarte setImage:image forState:UIControlStateNormal];
	
	[self.view addSubview:boutonRecherche];
	//[self.view addSubview:boutonCarte];
	
    /*--- BOUTON REFRESH POUR LES INFOS AGENCE ---*/
    UIButton *boutonRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    
    boutonRefresh.tag = 3;
	
	[boutonRefresh setFrame:CGRectMake(270, 75, 30, 30)];
	
	[boutonRefresh setUserInteractionEnabled:YES];
	
    boutonRefresh.showsTouchWhenHighlighted = NO;
    
	[boutonRefresh addTarget:self action:@selector(buttonPushed:)
              forControlEvents:UIControlEventTouchUpInside];
	
	image = [self getImage:@"refresh"];
	[boutonRefresh setImage:image forState:UIControlStateNormal];
	
	[self.view addSubview:boutonRefresh];
    /*--- BOUTON REFRESH POUR LES INFOS AGENCE ---*/
    
    /*--- BIENS RECENTS  + VILLES + INFOS AGENCE ---*/
    
    //REQUETE HTTP POUR AVOIR LES BIENS RECENTS + VILLES + INFOS AGENCE
    isConnectionErrorPrinted = NO;
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    tableauVilles = [[NSMutableArray alloc] init];
    tableauInfos = [[NSMutableArray alloc] init];
    
    appDelegate = (BiimmAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.whichView = @"accueil";
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    [self makeRequest];
    
    //IMAGE NOS BIENS A LA VENTE
    UIImageView *nosBiens = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coverflow-background.png"]];
    [nosBiens setFrame:CGRectMake(0, 210, 320, 180)];
    
    [self.view addSubview:nosBiens];
    [nosBiens release];
    
    /*--- BIENS RECENTS  + VILLES + INFOS AGENCE ---*/
    
    /*--- REALISATION AKIOS ---*/
    //LABEL
    /*UILabel *realisation = [[UILabel alloc] init];
    [realisation  setFrame:CGRectMake(100, 355, 300, 80)];
    realisation.text = @"Réalisation AKIOS.FR";
    realisation.textAlignment = UITextAlignmentCenter;
    realisation.font = [UIFont fontWithName:@"Arial" size:12];
    realisation.textColor = [UIColor colorWithRed:(104.0/255.0) green:(94.0/255.0) blue:(67.0/255.0) alpha:1.0];
    realisation.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:realisation];*/
    //LABEL
    /*--- REALISATION AKIOS ---*/
    
	[self.view setUserInteractionEnabled:YES];
    
	[super viewDidLoad];
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];
    [self.navigationController.view addSubview:pvc.view];
    
    [pool release];
    
}

-(UIImage *) getImage:(NSString *)cheminImage{
	UIImage *image = [UIImage imageWithContentsOfFile:
					  [[NSBundle mainBundle] pathForResource:
					   cheminImage ofType:@"png"]];
	
	return image;
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
		case 1:
            appDelegate.whichView = @"multicriteres";
            
            [self.navigationController pushViewController:myTableViewController animated:YES];
            break;
		case 2:
            appDelegate.whichView = @"carte";
            
            rechercheCarte = [[RechercheCarte2 alloc] init];
            rechercheCarte.title = @"Recherche sur la carte";
            [self.navigationController pushViewController:rechercheCarte animated:YES];
            [rechercheCarte release];
            break;
        case 3:
            [self makeRequestInfosAgence];
            break;
		default:
			break;
	}
}

- (void) coverFlowAccueil:(NSNotification *)notify{
    NSNumber *num = [notify object];
    
    annonceSelected = [tableauAnnonces1 objectAtIndex:[num intValue]];
    
    appDelegate.annonceAccueil = annonceSelected;
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    
	AfficheAnnonceControllerAccueil *afficheAnnonceController = [[AfficheAnnonceControllerAccueil alloc] init];
	[self.navigationController pushViewController:afficheAnnonceController animated:YES];
	[afficheAnnonceController release];
    afficheAnnonceController = nil;
    
}

- (void) afficheAnnonceReady:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonce" object: annonceSelected];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Accueil"];
    [myOpenFlowView centerOnSelectedCover:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [pvc.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [myTableViewController release];
    [rechercheCarte release];
    [myOpenFlowView release];
    [tableauAnnonces1 release];
    [tableauVilles release];
    [tableauInfos release];
    [networkQueue release];
    [pvc release];
    [super dealloc];
}

- (void)makeRequest{
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- REQUETE COVERFLOW ---*/
    
    NSString *bodyString = [NSString stringWithFormat:@"%@?part=%@&id_agence=%@&coverflow=YES",
                            appDelegate.url_serveur,
                            appDelegate.partenaire,
                            appDelegate.id_agence];
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"biens recents" forKey:@"name"]];
    [networkQueue addOperation:request];
    /*--- REQUETE COVERFLOW ---*/
    
    /*--- REQUETE VILLES ET CODES POSTAUX ---*/
    
    /*bodyString = [NSString stringWithFormat:@"%@?part=%@&id_agence=%@&villes=YES",
                  appDelegate.url_serveur,
                  appDelegate.partenaire,
                  appDelegate.id_agence];
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"villes" forKey:@"name"]];
    [networkQueue addOperation:request];*/
    /*--- REQUETE VILLES ET CODES POSTAUX ---*/
    
    [networkQueue go];
    
    /*--- REQUETE MISE A JOUR INFOS AGENCE ---*/
    [self makeRequestInfosAgence];
     /*--- REQUETE MISE A JOUR INFOS AGENCE ---*/
}

- (void)makeRequestInfosAgence{
    /*--- REQUETE MISE A JOUR INFOS AGENCE ---*/
    
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSMutableDictionary *dicDateMaj;
    
    dicDateMaj = [NSMutableDictionary dictionaryWithContentsOfFile:
                  [directory stringByAppendingPathComponent:@"date_maj.plist"]];
    
    NSString *date_maj_appli;
    
    if (dicDateMaj != nil) {
        date_maj_appli = [dicDateMaj valueForKey:@"date_maj"];
    }
    else {
        date_maj_appli = @"1970-01-01";
        
        dicDateMaj = [NSMutableDictionary dictionary];
        [dicDateMaj setValue:date_maj_appli forKey:@"date_maj"];
        [dicDateMaj writeToFile:[directory stringByAppendingPathComponent:@"date_maj.plist"] atomically:YES];
    }
    
    //NSLog(@"DATE MAJ AVANT: %@\n", date_maj_appli);
    
    NSString *escapedDate = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)date_maj_appli, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
    
    NSString *bodyString = [NSString stringWithFormat:@"http://wpc1066.amenworld.com/infos_agences.php?nom_appli=%@&date_maj_appli=%@&infos=YES",
                  appDelegate.nom_appli,
                  escapedDate];
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"infos_agence" forKey:@"name"]];
    [networkQueue addOperation:request];
    /*--- REQUETE MISE A JOUR INFOS AGENCE ---*/
    
    [networkQueue go];
}

- (void)requestVillesDone:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    
    NSLog(@"(Villes)dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@"(Villes)REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<villes></villes>"].length != 0) {
            //AUCUNE ANNONCES
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucune ville ni code postal dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucune ville trouvée."
                                       code:1 userInfo:userInfo];
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParserVilles *parser = [[XMLParserVilles alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
            {
                NSLog(@"No Errors on XML parsing.");
            }
            else
            {
                NSLog(@"Error on XML parsing!!!");
            }
            
            //CORE DATA
            NSManagedObjectContext *context = appDelegate.managedObjectContext;
            
            for (Ville *uneVille in tableauVilles) {
                //NSLog(@"Ville Acc: %@", uneVille);
                if (uneVille.nom != nil && uneVille.cp != nil) {
                    //NSLog(@"nom: %@", uneVille.nom);
                    //NSLog(@"cp: %@", uneVille.cp);
                
                    NSManagedObject *codesPostauxInfo = [NSEntityDescription
                                                         insertNewObjectForEntityForName:@"Codes" 
                                                         inManagedObjectContext:context];
                    
                    [codesPostauxInfo setValue:[uneVille.cp stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:@"code"];
                    [codesPostauxInfo setValue:uneVille.nom forKey:@"commune"];
                    
                    /*NSError *error;
                    if (![context save:&error]) {
                        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                    }*/
                }
            }
            
            [xmlParser release];
            [parser release];
        }
        [string release];
    }
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    if ([request.userInfo valueForKey:@"name"] == @"villes") {
        [self requestVillesDone:request];
        return;
    }
    
    if ([request.userInfo valueForKey:@"name"] == @"infos_agence") {
        [self requestInfosDone:request];
        return;
    }
    
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<biens></biens>"].length != 0) {
            //AUCUNE ANNONCES
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                       code:1 userInfo:userInfo];
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParser *parser = [[XMLParser alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
                NSLog(@"No Errors on XML parsing.");
            else
                NSLog(@"Error on XML parsing!!!");
            
            //COVER FLOW
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            for (Annonce *uneAnnonce in tableauAnnonces1) {
                NSString *photos = [uneAnnonce valueForKey:@"photos"];
                NSLog(@"COVERFLOW: \"%@\"",photos);
                photos = [photos stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                if ([photos length] > 0) {
                    [imagesArray addObject:[[NSMutableArray arrayWithArray:[photos componentsSeparatedByString:@","]] objectAtIndex:0]];
                }
            }
            
            
            myOpenFlowView = [[AFOpenFlowView alloc] init];
            int num = [imagesArray count];
            [myOpenFlowView setNumberOfImages:num];
            
            [myOpenFlowView setFrame:CGRectMake(10, 260, 300, 130)];
            for (int index = 0; index < num; index++){
                NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                                     [NSURL URLWithString:
                                      [NSString stringWithFormat:@"%@",
                                       [imagesArray objectAtIndex:index]]]];
                if (imageData != nil) {
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    [myOpenFlowView setImage:image forIndex:index];
                }
                [imageData release];
            }
            
            [self.view addSubview:myOpenFlowView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Accueil"];
            
            [pvc.view removeFromSuperview];
            
            [xmlParser release];
            [parser release];
        }
        [string release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    if (!isConnectionErrorPrinted) {
        alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                           message:[error localizedDescription]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        [alert release];
        isConnectionErrorPrinted = YES;
    }
    [pvc.view removeFromSuperview];
}

- (void)requestInfosDone:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    
    NSLog(@"(Infos)dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@"(Infos)REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<infos_agence></infos_agence>"].length != 0) {
            //INFOS A JOUR
            NSLog(@"Les infos agence sont à jour.");
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParserInfos *parser = [[XMLParserInfos alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
            {
                NSLog(@"No Errors on XML parsing.");
            }
            else
            {
                NSLog(@"Error on XML parsing!!!");
            }
            
            NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            //NSLog(@"tableauInfos: %@", tableauInfos);
            
            for (Infos *infosAgence in tableauInfos) {
                //SAUVEGARDER LES INFOS DANS LES FICHIERS CONF
                
                [[infosAgence valueForKey:@"coordonnees_globales"] writeToFile:
                 [directory stringByAppendingPathComponent:@"coordonnees-globales.txt"]
                                                                    atomically:YES
                                                                      encoding:NSUTF8StringEncoding
                                                                         error:&error];
                
                [[infosAgence valueForKey:@"coordonnees_postales"] writeToFile:
                 [directory stringByAppendingPathComponent:@"coordonnees-postales.txt"]
                                                                    atomically:YES
                                                                    encoding:NSUTF8StringEncoding
                                                                         error:&error];
                
                [[infosAgence valueForKey:@"email_agence"] writeToFile:
                 [directory stringByAppendingPathComponent:@"email-agence.txt"]
                                                            atomically:YES
                                                              encoding:NSUTF8StringEncoding
                                                                 error:&error];
                
                [[infosAgence valueForKey:@"fax_agence"] writeToFile:
                 [directory stringByAppendingPathComponent:@"fax-agence.txt"]
                                                          atomically:YES
                                                            encoding:NSUTF8StringEncoding
                                                               error:&error];
                
                [[infosAgence valueForKey:@"nom_appli"] writeToFile:
                 [directory stringByAppendingPathComponent:@"nom-appli.txt"]
                                                          atomically:YES
                                                            encoding:NSUTF8StringEncoding
                                                               error:&error];
                
                [[infosAgence valueForKey:@"presentation_agence"] writeToFile:[directory stringByAppendingPathComponent:@"presentation-agence.txt"]
                                                                   atomically:YES
                                                                     encoding:NSUTF8StringEncoding
                                                                        error:&error];
                
                [[infosAgence valueForKey:@"site_agence"] writeToFile:
                 [directory stringByAppendingPathComponent:@"site-agence.txt"]
                                                           atomically:YES
                                                             encoding:NSUTF8StringEncoding
                                                                error:&error];
                
                [[infosAgence valueForKey:@"telephone_agence"] writeToFile:
                 [directory stringByAppendingPathComponent:@"telephone-agence.txt"]
                                                                atomically:YES
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:&error];
                
                //IMAGES
                //HEADER
                NSString *headerImageString = [NSString stringWithFormat:@"%@%@",
                                               appDelegate.urlImages,
                                               [infosAgence valueForKey:@"header_image"]];
                
                NSURL *headerImageUrl = [NSURL URLWithString:headerImageString];
                
                NSData *headerImageData = [NSData dataWithContentsOfURL:headerImageUrl];
                
                if (headerImageData != nil) {
                    
                    [headerImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"header.png"]
                                      atomically:YES];
                }
                
                //BACKGROUND
                NSString *backgroundImageString = [NSString stringWithFormat:@"%@%@",
                                               appDelegate.urlImages,
                                               [infosAgence valueForKey:@"background_image"]];
                
                NSURL *backgroundImageUrl = [NSURL URLWithString:backgroundImageString];
                
                NSData *backgroundImageData = [NSData dataWithContentsOfURL:backgroundImageUrl];
                
                if (backgroundImageData != nil) {
                    
                    [backgroundImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"background.png"]
                                      atomically:YES];
                }
                
                //FOOTER
                //BIENS
                NSString *footerBiensImageString = [NSString stringWithFormat:@"%@%@",
                                                   appDelegate.urlImages,
                                                   [infosAgence valueForKey:@"footer_biens_image"]];
                
                NSURL *footerBiensImageUrl = [NSURL URLWithString:footerBiensImageString];
                
                NSData *footerBiensImageData = [NSData dataWithContentsOfURL:footerBiensImageUrl];
                
                if (footerBiensImageData != nil) {
                    
                    [footerBiensImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"footer_biens.png"]
                                          atomically:YES];
                }
                
                //FAVORIS
                NSString *footerFavorisImageString = [NSString stringWithFormat:@"%@%@",
                                                    appDelegate.urlImages,
                                                    [infosAgence valueForKey:@"footer_favoris_image"]];
                
                NSURL *footerFavorisImageUrl = [NSURL URLWithString:footerFavorisImageString];
                
                NSData *footerFavorisImageData = [NSData dataWithContentsOfURL:footerFavorisImageUrl];
                
                if (footerFavorisImageData != nil) {
                    
                    [footerFavorisImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"footer_favoris.png"]
                                           atomically:YES];
                }
                
                //AGENCE
                NSString *footerAgenceImageString = [NSString stringWithFormat:@"%@%@",
                                                      appDelegate.urlImages,
                                                      [infosAgence valueForKey:@"footer_agence_image"]];
                
                NSURL *footerAgenceImageUrl = [NSURL URLWithString:footerAgenceImageString];
                
                NSData *footerAgenceImageData = [NSData dataWithContentsOfURL:footerAgenceImageUrl];
                
                if (footerAgenceImageData != nil) {
                    
                    [footerAgenceImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"footer_agence.png"]
                                             atomically:YES];
                }
                
                //CONTACT
                NSString *footerContactImageString = [NSString stringWithFormat:@"%@%@",
                                                     appDelegate.urlImages,
                                                     [infosAgence valueForKey:@"footer_contact_image"]];
                
                NSURL *footerContactImageUrl = [NSURL URLWithString:footerContactImageString];
                
                NSData *footerContactImageData = [NSData dataWithContentsOfURL:footerContactImageUrl];
                
                if (footerContactImageData != nil) {
                    
                    [footerContactImageData writeToFile:
                     [directory stringByAppendingPathComponent:@"footer_contact.png"]
                                            atomically:YES];
                }
                
                [self updateImages];
            }
            
            [xmlParser release];
            [parser release];
            
            //SAUVEGARDE LA DATE DE MAJ
            NSDate *now = [[NSDate alloc] init];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            NSMutableDictionary *dictDateMaj = [NSMutableDictionary dictionary];
            
            [dictDateMaj setValue:[format stringFromDate:now] forKey:@"date_maj"];
            
            [dictDateMaj writeToFile:[directory stringByAppendingPathComponent:@"date_maj.plist"] atomically:YES];
            
            [now release];
            [format release];
            
            //NSLog(@"DATE MAJ APRES: %@\n", appDelegate.date_maj_appli);

        }
        [string release];
    }
}

@end

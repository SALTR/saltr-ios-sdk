    //
//  SLTViewController.m
//  SaltrTestApp
//
//  Created by employee on 2/28/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    SLTSaltr* saltr;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    saltr = [[SLTSaltr alloc] initSaltrWithClientKey:@"618385" deviceId:@"device_id_ios" andCacheEnabled:YES];
    saltr.saltrRequestDelegate = self;
    
    [saltr importLevelsFromPath:nil];
    
    NSMutableDictionary* scoresDictionary = [[NSMutableDictionary alloc] init];
    [scoresDictionary setObject:[NSNumber numberWithInt:10] forKey:@"collecting"];
    [scoresDictionary setObject:[NSNumber numberWithInt:20] forKey:@"moveBonus"];

    [saltr defineFeatureWithToken:@"SCORES" properties:scoresDictionary andRequired:NO];
    
    NSMutableDictionary* backgroundPropertiesDictionary = [[NSMutableDictionary alloc] init];
    [backgroundPropertiesDictionary setObject:@"#cccccc" forKey:@"bgColor"];
    
    [saltr defineFeatureWithToken:@"BACKGROUND_COLOR" properties:backgroundPropertiesDictionary andRequired:NO];
    
    [saltr start];
    [saltr connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SaltrRequestDelegate methods

-(void) didFinishGettingAppDataRequest
{
    
}

-(void) didFailGettingAppDataRequest:(SLTStatus*)status
{
    
}

-(void) didFinishGettingLevelDataBodyWithLevelPackRequest
{
    
}

-(void) didFailGettingLevelDataBodyWithLevelPackRequest
{
    
}

-(void) didFinishGettingLevelDataRequest
{
    
}

-(void) didFailGettingLevelDataRequest:(SLTStatus*)status
{
    
}

@end

//
//  ViewController.h
//  SpotifySearch
//
//  Created by Kyrill Cousson on 18/10/2018.
//  Copyright © 2018 Kyrill Cousson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InternetInformationProtocol.h"

@interface ViewController : UIViewController <InternetInformationDelegate>


@property (nonatomic, strong) NSString  *song, *artist, *album;
@property (nonatomic, strong) NSURL     *spotifyURL;


@property (weak, nonatomic) IBOutlet UITextField *songTextField;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *albumTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *openSpotifyButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UILabel *spotifyUrlTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *spotifyUrlLabel;


- (IBAction)searchAction:(id)sender;
- (IBAction)openSpotifyAction:(id)sender;
- (IBAction)clearAction:(id)sender;

@end


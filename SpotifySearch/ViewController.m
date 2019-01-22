//
//  ViewController.m
//  SpotifySearch
//
//  Created by Kyrill Cousson on 18/10/2018.
//  Copyright © 2018 Kyrill Cousson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initValues];
    [self initUI];
}

#pragma mark - Init Methods

- (void)initValues {
    self.song = @"";
    self.artist = @"";
    self.album = @"";
    
    self.spotifyURL = nil;
}

- (void)initUI {
    self.songTextField.text = @"";
    self.artistTextField.text = @"";
    self.albumTextField.text = @"";
    
    self.spotifyUrlLabel.text = @"https://...";
    
    // Hide unnecessary UI elements when there is no data to show.
    self.openSpotifyButton.hidden = true;
    self.openSpotifyButton.enabled = false;
    self.clearButton.hidden = true;
}

#pragma mark - UI update

- (void)updateUIWithNewURL {
    self.spotifyUrlLabel.text = self.spotifyURL.absoluteString;
    self.openSpotifyButton.hidden = false;
    self.clearButton.hidden = false;
    
    // Open Spotify button should only be enabled if Spotify is installed on the device.
    self.openSpotifyButton.enabled = ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"spotify://"]]);
}

#pragma mark - InternetInformationDelegate methods

- (void)updateLink:(NSURL*)url forKey:(NSString*)key {
    if ([key isEqualToString:@"spotifyURL"]){
        self.spotifyURL = url;
        [self updateUIWithNewURL];
    }
}

- (void)handleError:(NSString*)errorMessage{
    
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [errorAlertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:errorAlertController animated:YES completion:nil];
}


#pragma mark - Button Actions

- (IBAction)searchAction:(id)sender {

    self.song = self.songTextField.text;
    self.artist = self.artistTextField.text;
    self.album = self.albumTextField.text;
    
    MusicItem *displayedItem = [[MusicItem alloc] initWithName:self.song artistName:self.artist andRegroupmentName:self.album];
    
    InternetInformationProtocol *internetInformationProtocol = [[InternetInformationProtocol alloc] initWithMusicItem:displayedItem];
    [internetInformationProtocol setDelegate:self];
    [internetInformationProtocol getInternetInformation];
}

- (IBAction)openSpotifyAction:(id)sender {
    
    // Only open the URL if Spotify is installed on the device.
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"spotify://"]]) {
        [[UIApplication sharedApplication] openURL:self.spotifyURL options:@{} completionHandler:^(BOOL success) {
            if (success)
                NSLog(@"Opened url");
            else
                NSLog(@"Could not open URL");
        }];
    }
    else
        NSLog(@"Could not open URL - Spotify is not installed");
}

// Reset data & UI.
- (IBAction)clearAction:(id)sender {
    [self initValues];
    [self initUI];
}

@end

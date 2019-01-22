# SpotifySearch

## What does this do?

This sample project includes code from the Suggested app that is used to connect to the Spotify API to search for music and return the Spotify page URL of the first result.
The URL returned is meant to be opened with the Spotify app. Therefore, opening the URL is only possible on a device with the Spotify application installed.

The view contains three textfields: song, artist, and album.
Fill at least one of the fields and tap the Search button to execute the request.

At the app launch, the app gets a token from the Spotify API.
When tapping the Search button, the app checks if it already has the token.
If it doesn't, then it gets it before performing the search request.
Otherwise, it directly performs the search request.
The response from the API is then computed to return the Spotify URL of the first result of the search.

## Setting up
1. Go into the folder containing the **SpotifySearch.xcodeproj** file, then run:
```
pod install
```

2. Open the **SpotifySearch.xcworkspace**.
3. In **SpotifySearch.m**, set `kSpotify_clientId` and `kSpotify_clientSecret` to your own clientId and clientSecret that you can get from the [Spotify API website](https://developer.spotify.com/dashboard/).


```
static NSString * const kSpotify_clientId = @"";
static NSString * const kSpotify_clientSecret = @"";
```


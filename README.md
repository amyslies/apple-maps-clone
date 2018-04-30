# Apple Maps Clone

My rendition of Apple [Maps](https://www.apple.com/ios/maps/) with minimal features for demo purposes.

<img src="./demo.gif" width="35%"/>

## Features

1) Snapping behavior of locations content to a top, middle, and bottom y offset
2) Selecting a location from the table view will zoom into the corresponding map annotation and show its details
3) Selecting a map annotation from the map will center on it and show the corresponding location's details
4) Web request to GET locations from the [GooglePlaces](https://developers.google.com/places/ios-api/) API 

## Set up

Clone the project and navigate into its directory.
```
git clone https://github.com/amyslies/apple-maps-clone.git
cd apple-maps-clone

```

Install [cocoapods](https://cocoapods.org/) if necessary, then install pods.
```
pod install
```

Open the `.xcworkspace` project in Xcode and run the app.

## ToDo

* Show location details
* Infinite scrolling for locations
* Location search
* Centering on current location
* Better user interface assets
* Write tests for math logic behind snapping behavior and more

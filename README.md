# HexLoader

[![CI Status](http://img.shields.io/travis/Kesavasankar Jawaharlal/HexLoader.svg?style=flat)](https://travis-ci.org/Kesavasankar Jawaharlal/HexLoader)
[![Version](https://img.shields.io/cocoapods/v/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)
[![License](https://img.shields.io/cocoapods/l/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)
[![Platform](https://img.shields.io/cocoapods/p/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)

This is a open source library which shows a hexagon shaped loading indictor, developed CAShapeLayer and CABasicAnimation. The library is highly customisable.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Screenshots
Dark Background with Loading Text            |  Light Background without Loading Text and no inner offset
:-------------------------:|:-------------------------:
![](https://github.com/Kesava-Jawaharlal/HexLoader/blob/master/Resources/HexLoaderDarkBackground.gif)  |  ![](https://github.com/Kesava-Jawaharlal/HexLoader/blob/master/Resources/HexLoaderLightBackground.gif)
Transparent Background     |  Dark Background without backdrop
![](https://github.com/Kesava-Jawaharlal/HexLoader/blob/master/Resources/HexLoaderTransparentBackground.gif)  |  ![](https://github.com/Kesava-Jawaharlal/HexLoader/blob/master/Resources/HexLoaderDarkBackgroundBare.gif)
Transparent Background with custom Loading Text Color  |
![](https://github.com/Kesava-Jawaharlal/HexLoader/blob/master/Resources/HexLoaderDarkBackgroundCustomTextColor.gif)  |

## Requirements

## Installation

HexLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HexLoader"
```

## Manual Installation
Just copy the files under 'HexLoader/Classes' folder to get going.

## Usage

The library has a protocol extension named 'LoadingViewPresentable', which enables any view controller to call the library easily without any boiler plate code. To start the loader, all you need to call any of the below two public functions, which were part of the protocol extension, from any of your UIViewControllers.

```swift
startLoading()
```
or call the below function to have some text beneath the indicator.
```swift
startLoading(with: "Loading...")
```

The indicator can be stopped by calling the below function
```swift
stopLoading()
```
## Configuration
The loader has an extensive list of customisations exposed through a Singleton class 'HexLoaderConfig'. Below are the params available
```swift

/**
 *  Length of each side
 */
HexagonLoaderConfig.shared.hexagonSideLength = 60

/**
 *  Inner offset for each Hexagon
 */
HexagonLoaderConfig.shared.hexagonInnerOffset = 2

/**
 *  Color of Hexagon
 */
HexagonLoaderConfig.shared.hexagonBackgroundColor = .white

/**
 *  Color of Hexagon border
 */
HexagonLoaderConfig.shared.hexagonBorderColor = white
	
/**
 *  Background Type
 */
HexagonLoaderConfig.shared.backgroundType = .transparent

/**
* Boolean to indicate if a backdrop over lay is needed to be displayed
*/
HexagonLoaderConfig.shared.displayBackdropOverlay = true

/**
 *  Backdrop Overlay Color. This will be used only if'displayBackdropOverlay' var is set to true
 */
HexagonLoaderConfig.shared.backdropOverlayColor = #colorLiteral(red: 0.4156862745, green: 0.7176470588, blue: 0.968627451, alpha: 1)

/**
 *  Backdrop Overlay Corner Radius. This will be used only if'displayBackdropOverlay' var is set to true
 */
HexagonLoaderConfig.shared.backdropOverlayCornerRadius = 10

/**
* Loading Text Font
*/
HexagonLoaderConfig.shared.loadingTextFont = UIFont.systemFont(ofSize: 17)

/**
 * Loading Text Color
 */
HexagonLoaderConfig.shared.loadingTextColor = .white

/**
 *  Animation Speed of the loader
 */
HexagonLoaderConfig.shared.animationSpeed = 1

```


## Author

Kesava Jawaharlal, kesava.jawaharlal@gmail.com

## License

HexLoader is available under the MIT license. See the LICENSE file for more info.

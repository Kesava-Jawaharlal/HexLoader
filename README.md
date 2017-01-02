# HexLoader

[![CI Status](http://img.shields.io/travis/Kesavasankar Jawaharlal/HexLoader.svg?style=flat)](https://travis-ci.org/Kesavasankar Jawaharlal/HexLoader)
[![Version](https://img.shields.io/cocoapods/v/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)
[![License](https://img.shields.io/cocoapods/l/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)
[![Platform](https://img.shields.io/cocoapods/p/HexLoader.svg?style=flat)](http://cocoapods.org/pods/HexLoader)

This is a open source library which shows a hexagon shaped loading indictor, developed CAShapeLayer and CABasicAnimation. The library is highly customisable.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HexLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HexLoader"
```

## Usage

The library has a protocol extension named 'LoadingViewPresentable', which enables any view controller to call the library easily without any boiler plate code. The indicator can be called using two public methods from any UIViewController. All you need to call any of the below two functions from any of your UIViewControllers.

```swift
startLoading()
```
or call the below function to have some text beneath the indicator.
```swift
startLoading(with: "Loading...")
```

The indicator can be stopped by calling the below 
```swift
stopLoading()
```


## Author

Kesavasankar Jawaharlal, kesava.jawaharlal@gmail.com

## License

HexLoader is available under the MIT license. See the LICENSE file for more info.

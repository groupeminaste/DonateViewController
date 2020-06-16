# DonateViewController

[![License](https://img.shields.io/github/license/GroupeMINASTE/DonateViewController)](LICENSE)
[![Issues](https://img.shields.io/github/issues/GroupeMINASTE/DonateViewController)]()
[![Pull Requests](https://img.shields.io/github/issues-pr/GroupeMINASTE/DonateViewController)]()
[![Code Size](https://img.shields.io/github/languages/code-size/GroupeMINASTE/DonateViewController)]()
[![CodeFactor](https://www.codefactor.io/repository/github/groupeminaste/donateviewcontroller/badge)](https://www.codefactor.io/repository/github/groupeminaste/donateviewcontroller)
[![Open Source Helpers](https://www.codetriage.com/groupeminaste/donateviewcontroller/badges/users.svg)](https://www.codetriage.com/groupeminaste/donateviewcontroller)

A view controller to make donations.

## Installation

Add `https://github.com/GroupeMINASTE/DonateViewController.git` to your Swift Package configuration (or using the Xcode menu: `File` > `Swift Packages` > `Add Package Dependency`)

## Usage

First, import the package in your view controller where you want to open the DonateViewController.

```swift
// Import the package
import DonateViewController
```

Create a method to open it:

```swift
func openDonateViewController() {
    // Create the view controller
    let controller = DonateViewController()
    
    // Add donations
    controller.add(identifier: "my.app.identifier.mydonation1")
    controller.add(identifier: "my.app.identifier.mydonation2")
    // ... (add as many donations as you want)
    
    // And open your view controller: (two ways)
    
    // 1. In your navigation controller
    navigationController?.pushViewController(controller, animated: true)
    
    // 2. In a modal
    present(controller, animated: true, completion: nil)
}
```

> **WARNING**: You need to register your in app purchases on App Store Connect to make it work. The name and the price of purchases will be used.

## Donate to the developer

Feel free to make a donation to help the developer to make more great content! [Donate now](https://paypal.me/NathanFallet)

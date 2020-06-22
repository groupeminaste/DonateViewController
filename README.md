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

> ⚠️ You need to register your in app purchases in App Store Connect to make it work. The name and the price of purchases will be used.

First, import the package in your view controller where you want to open the `DonateViewController`.

```swift
// Import the package
import DonateViewController
```

Create a method to open it:

```swift
// Import the package
import DonateViewController

class MyViewController: UIViewController {

    // Some code...

    func openDonateViewController() {
        // Create the view controller
        let controller = DonateViewController()
        
        // Customize view title, header and footer (optional)
        controller.title = "Donate"
        controller.header = "Select an amount to donate:"
        controller.footer = "The donations help us to improve our projects (...)"
        
        // Add a delegate to get notified when a donation ends
        controller.delegate = self
        
        // Add donations
        controller.add(identifier: "my.app.identifier.mydonation1")
        controller.add(identifier: "my.app.identifier.mydonation2")
        // ... (add as many donations as you want)
        
        // And open your view controller: (two ways)
        
        // 1. In your navigation controller
        navigationController?.pushViewController(controller, animated: true)
        
        // 2. In a modal
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    // Some code...

}
```

Then you need to implement the `DonateViewControllerDelegate` protocol to get notified when a donation ends:

```swift
// Import the package
import DonateViewController

class MyViewController: UIViewController, DonateViewControllerDelegate { // Add the protocol to the view controller

    // Some code...
    
    // The method we just created (no changes)
    func openDonateViewController() {
        // ...
    }
    
    // Implement delegate methods
    
    func donateViewController(_ controller: DonateViewController, didDonationSucceed donation: Donation) {
        // Handle when the donation succeed
        
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationFailed donation: Donation) {
        // Handle when the donation failed
        
    }
    
    // Some code...

}
```

You can show a `UIAlertController` with a little message for exemple.

And call the `openDonateViewController()` method when you want to open the `DonateViewController`:

```swift
self.openDonateViewController()
```

This can be called when the user clicks on a `UIButton` (in the selector method) or when the user selects a table view cell.

That's all, you're ready to receive donations!

## Customize colors for theming (iOS < 13)

Before iOS 13, no dark theme was implemented in controllers. If you want to implement your custom dark theme, subclass `DonateViewController` and `DonateCell` to change the colors of the views. (background, ...)

## Donate to the developer

Feel free to make a donation to help the developer to make more great content! [Donate now](https://paypal.me/NathanFallet)

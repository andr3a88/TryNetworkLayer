//
//  Storyboards.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 13/03/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import UIKit

/// Storyboard enum. Require storyboardId equal to class name
/// Example: let vc = Storyboard.login.instantiate(LoginViewController.self)
enum Storyboard: String {
    case main = "Main"

    func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }
}

//
//  NavigationViewProtocol.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 8.09.2024.
//

import Foundation
import UIKit

protocol NavigationView {
    func present(_ viewController: UIViewController)
    func dismiss()
}

extension NavigationView where Self: UIViewController {
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}

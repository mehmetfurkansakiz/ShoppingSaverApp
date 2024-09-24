//
//  HomeContract.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 8.09.2024.
//
//

import Foundation

// MARK: View Output (Presenter -> View)

protocol PresenterToViewHomeProtocol {
    func showMessage(message: String)
}

// MARK: View Input (View -> Presenter)

protocol ViewToPresenterHomeProtocol {
    func addButtonTapped()
}

// MARK: Interactor Input (Presenter -> Interactor)

protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? { get set }

    func saveItemToList(index: Int)
}

// MARK: Interactor Output (Interactor -> Presenter)

protocol InteractorToPresenterHomeProtocol {
    func showSuccessMessage()
}

// MARK: Router Input (Presenter -> Router)

protocol PresenterToRouterHomeProtocol {
    func navigaToCreateList()
}

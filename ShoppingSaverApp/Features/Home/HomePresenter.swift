//
//  HomePresenter.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 8.09.2024.
//
//

import Foundation

final class HomePresenter: ViewToPresenterHomeProtocol {
    // MARK: Properties

    private let view: PresenterToViewHomeProtocol
    private let interactor: PresenterToInteractorHomeProtocol
    private let router: PresenterToRouterHomeProtocol

    init(interactor: PresenterToInteractorHomeProtocol, router: PresenterToRouterHomeProtocol, view: PresenterToViewHomeProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    func addButtonTapped() {
        // TODO: Add button yönlendirmesini yap
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func showSuccessMessage() {
        view.showMessage(message: "Liste başarılı bir şekilde kaydedildi.")
    }
}

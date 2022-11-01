//
//  HomePagePresenter.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation

class HomePagePresenter : ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?
    
    func showFoods() {
        homePageInteractor?.showAllFoods()
    }
}


extension HomePagePresenter : InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(foods: Array<Foods>) {
        homePageView?.sendDataToView(foods: foods)
    }
}

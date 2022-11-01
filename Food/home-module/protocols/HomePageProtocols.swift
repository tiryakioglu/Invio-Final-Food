//
//  HomePageProtocols.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation

protocol ViewToPresenterHomePageProtocol {
    var homePageInteractor:PresenterToInteractorHomePageProtocol? {get set}
    var homePageView : PresenterToViewHomePageProtocol? {get set}
    func showFoods()
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter : InteractorToPresenterHomePageProtocol? {get set}
    
    func showAllFoods()
}

protocol InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(foods : Array<Foods>)
}

protocol PresenterToViewHomePageProtocol {
    func sendDataToView(foods : Array<Foods>)
}

protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref : HomePageVC)
}

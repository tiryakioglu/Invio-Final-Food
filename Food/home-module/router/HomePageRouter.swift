//
//  HomePageRouter.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation

class HomePageRouter : PresenterToRouterHomePageProtocol {
    
    static func createModule(ref: HomePageVC) {
        let presenter = HomePagePresenter()
        ref.homePagePresenterObject = presenter
        ref.homePagePresenterObject?.homePageInteractor = HomePageInteractor()
        ref.homePagePresenterObject?.homePageView = ref
        ref.homePagePresenterObject?.homePageInteractor?.homePagePresenter = presenter
    }
    
}

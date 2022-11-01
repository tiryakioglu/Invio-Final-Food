//
//  CartRouter.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 31.10.2022.
//

import Foundation

class CartRouter : PresenterToRouterCartProtocol
{
    static func createModule(ref: CartVC) {
        let presenter = CartPresenter()
        ref.cartPresenterObject = presenter
        ref.cartPresenterObject?.cartInteractor = CartInteractor()
        ref.cartPresenterObject?.cartView = ref
        ref.cartPresenterObject?.cartInteractor?.cartPresenter = presenter
        
    }
}

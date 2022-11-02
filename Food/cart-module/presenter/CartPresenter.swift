//
//  CartPresenter.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 31.10.2022.
//

import Foundation

class CartPresenter : ViewToPresenterCartProtocol
{
    var cartInteractor: PresenterToInteractorCartProtocol?
    
    var cartView: PresenterToViewCartProtocol?
    
    func showFoodCart() {
        cartInteractor?.showCart()
    }
    func deleteFoodCart(cart: Cart, kullanici_adi: String) {
        cartInteractor?.deleteCart(cart: cart, kullanici_adi: kullanici_adi)
    }
    func allDeleteFoodCart(carts: Array<Cart>) {
        cartInteractor?.allDeleteCart(carts: carts)
    }
}

extension CartPresenter : InteractorToPresenterCartProtocol
{
    func sendDataToPresenter(cartList: Array<Cart>) {
        cartView?.sendDataToView(cartList: cartList)
    }
}

//
//  CartProtocols.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 31.10.2022.
//

import Foundation

protocol ViewToPresenterCartProtocol
{
    var cartInteractor : PresenterToInteractorCartProtocol? {get set}
    var cartView : PresenterToViewCartProtocol? {get set}
    
    func showFoodCart()
    func deleteFoodCart(cart: Cart, kullanici_adi: String)
    func allDeleteFoodCart(carts : Array<Cart>)
}

protocol PresenterToInteractorCartProtocol
{
    var cartPresenter : InteractorToPresenterCartProtocol? {get set}
    func showCart()
    func deleteCart(cart: Cart, kullanici_adi: String)
    func allDeleteCart(carts : Array<Cart>)
}

protocol InteractorToPresenterCartProtocol
{
    func sendDataToPresenter(cartList : Array<Cart>)
}

protocol PresenterToViewCartProtocol
{
    func sendDataToView(cartList : Array<Cart>)
}

protocol PresenterToRouterCartProtocol
{
    static func createModule(ref : CartVC)
}

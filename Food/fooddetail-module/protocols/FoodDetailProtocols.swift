//
//  FoodDetailProtocols.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation

protocol ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor:PresenterToInteractorFoodDetailProtocol? {get set}
    
    func addCart(yemek_adi : String, yemek_fiyat : String, yemek_resim_adi : String, yemek_siparis_adet:String, kullanici_adi:String)
}

protocol PresenterToInteractorFoodDetailProtocol {
    
    func foodAddCart(yemek_adi : String, yemek_fiyat : String, yemek_resim_adi : String, yemek_siparis_adet:String, kullanici_adi:String)
}

protocol InteractorToPresenterFoodDetailProtocol {
}

protocol PresenterToViewFoodDetailProtocol {
}

protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref : FoodDetailVC)
}

//
//  CartInteractor.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 31.10.2022.
//

import Foundation
import Alamofire

class CartInteractor : PresenterToInteractorCartProtocol
{
    
    var cartPresenter: InteractorToPresenterCartProtocol?
    
    func showCart() {
        
        let param : Parameters = ["kullanici_adi" : "ali_tiryakioglu"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: param).responseJSON{ response in
            if let data = response.data
            {
                do {
                    let answer = try JSONDecoder().decode(CartResponse.self, from: data)
                    var list = [Cart]()
                    if let answerList = answer.sepet_yemekler
                    {
                        list = answerList
                    }
                    
                    self.cartPresenter?.sendDataToPresenter(cartList: list)
                    
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func deleteCart(cart: Cart, kullanici_adi: String) {
        
        let param : Parameters = ["sepet_yemek_id" : cart.sepet_yemek_id!, "kullanici_adi" : "ali_tiryakioglu"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: param).response{ response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.showCart()
                        }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func allDeleteCart(carts : Array<Cart>)
    {
        for cartItem in carts{
            DispatchQueue.main.async { [weak self] in
                self?.deleteCart(cart: cartItem, kullanici_adi: "ali_tiryakioglu")
            }
            self.showCart()
        }
    }
    
    
}

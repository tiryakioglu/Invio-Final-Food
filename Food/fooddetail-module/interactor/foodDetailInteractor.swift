//
//  FoodDetailInteractor.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation
import Alamofire

class FoodDetailInteractor : PresenterToInteractorFoodDetailProtocol {
    func foodAddCart(yemek_adi: String, yemek_fiyat: String, yemek_resim_adi: String, yemek_siparis_adet: String, kullanici_adi: String) {
        
        let params : Parameters = ["yemek_adi" : yemek_adi, "yemek_fiyat" : yemek_fiyat, "yemek_siparis_adet" : yemek_siparis_adet, "yemek_resim_adi" : yemek_resim_adi, "kullanici_adi" : "ali_tiryakioglu"]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters : params).response{ response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

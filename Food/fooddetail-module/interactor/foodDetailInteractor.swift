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
        var foodCount = 0
        var foodId = 0
            
        let param : Parameters = ["kullanici_adi" : "ali_tiryakioglu"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: param).response { response in
            if let data = response.data
            {
                do {
                    let answer = try JSONDecoder().decode(CartResponse.self, from: data)
                    var list = [Cart]()
                    
                    if let answerList = answer.sepet_yemekler {
                        list = answerList
                        print(list.first?.yemek_adi)
                        list.forEach { foodFor in
                            if yemek_adi == foodFor.yemek_adi {
                                foodId = Int(foodFor.sepet_yemek_id!) ?? 0
                                foodCount += Int(foodFor.yemek_siparis_adet!) ?? 0
                            }
                          }
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("foodCount: \(foodCount)")
            print("foodId: \(foodId)")
            //delete
            let paramdelete : Parameters = ["sepet_yemek_id" : "\(foodId)", "kullanici_adi" : "ali_tiryakioglu"]
            
            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: paramdelete).response{ response in
                if let data = response.data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
                
            }
            //delete
            //insert
            foodCount = foodCount + (Int(yemek_siparis_adet) ?? 0)
            let yemek_siparis_adets = String(foodCount)
            let params : Parameters = ["yemek_adi" : yemek_adi, "yemek_fiyat" : yemek_fiyat, "yemek_siparis_adet" : yemek_siparis_adets, "yemek_resim_adi" : yemek_resim_adi, "kullanici_adi" : "ali_tiryakioglu"]
            AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters : params).response{ response in
                if let data = response.data {
                    do {
                        print("insert item")
                    } catch  {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

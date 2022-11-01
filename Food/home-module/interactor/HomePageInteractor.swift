//
//  HomePageInteractor.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import Foundation
import Alamofire

class HomePageInteractor : PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    
    func showAllFoods() {
            
            AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method:.get).response { response in
                
                if let data = response.data {
                    do {
                        let answer = try JSONDecoder().decode(FoodsResponse.self, from: data)
                        var list = [Foods]()
                        
                        if let answerList = answer.yemekler {
                            list = answerList
                        }
                        
                        self.homePagePresenter?.sendDataToPresenter(foods: list)
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                }
            }
            
        }
            
}

//
//  FoodDetailVC.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import UIKit
import Kingfisher

class FoodDetailVC: UIViewController {
    

    @IBOutlet weak var imageViewFoodDetail: UIImageView!
    @IBOutlet weak var labelFoodNameDetail: UILabel!
    @IBOutlet weak var labelFoodPriceDetail: UILabel!
    @IBOutlet weak var labelStepper: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    var stepperValue = 1
    var food : Foods?
    var cartFood = [Cart]()
    var cartFilter = [Cart]()
    
    var foodDetailPresenterObject : ViewToPresenterFoodDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = food{
            labelFoodNameDetail.text = f.yemek_adi
            labelFoodPriceDetail.text = "\(f.yemek_fiyat!) ₺"
            labelTotalPrice.text = "\(f.yemek_fiyat!) ₺"
            if let url = URL(string : "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)")
            {
                DispatchQueue.main.async {
                    self.imageViewFoodDetail.kf.setImage(with : url)
                }
            }
        }
        FoodDetailRouter.createModule(ref: self)
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        if stepperValue > 1 {
            stepperValue -= 1
        }
        labelStepper.text = String(stepperValue)
        
        if let f = food {
            let foodPrice = Int(f.yemek_fiyat!)
            labelTotalPrice.text = "\(foodPrice! * stepperValue) ₺"
        }
    }
    @IBAction func buttonPlus(_ sender: Any) {
        stepperValue += 1
        labelStepper.text = String(stepperValue)
        if let f = food {
            let foodPrice = Int(f.yemek_fiyat!)
            labelTotalPrice.text = "\(foodPrice! * stepperValue) ₺"
        }
    }
    

    @IBAction func buttonAddToCart(_ sender: Any) {
        if let f = food{
                    foodDetailPresenterObject?.addCart(yemek_adi: f.yemek_adi!, yemek_fiyat: f.yemek_fiyat!, yemek_resim_adi: f.yemek_resim_adi!, yemek_siparis_adet: String(stepperValue), kullanici_adi: "ali_tiryakioglu")
                    
                    let alert = UIAlertController(title: "Add To Cart", message: "\(f.yemek_adi!) added to cart!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .default){ action in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true)
                    
                }
    }
    
}

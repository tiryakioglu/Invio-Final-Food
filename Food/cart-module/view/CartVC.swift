//
//  CartVC.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import UIKit
import Lottie

class CartVC: UIViewController {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    private var animationView: LottieAnimationView?
    
    var cartFoods = [Cart]()
    var cartPresenterObject : ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lottie
          animationView = .init(name: "empty")
          animationView!.frame = view.bounds
          animationView!.contentMode = .scaleAspectFit
          animationView!.loopMode = .loop
          animationView!.animationSpeed = 0.5
          view.addSubview(animationView!)
          animationView!.play()
        //lottie
    
        cartTableView.delegate = self
        cartTableView.dataSource = self
               
        CartRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.showFoodCart()
        animationView!.play()
       }

    @IBAction func buttonDelete(_ sender: Any) {
        self.cartPresenterObject?.allDeleteFoodCart(carts: cartFoods)
        let alert = UIAlertController(title: "Basket", message: "Basket emptied", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok!", style: .default){ action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cartTableView.isHidden = true
                self.totalPrice.text = "0 ₺"
            self.lottieShowHide(lottieStatus: false)
        }
    }
    
    func lottieShowHide(lottieStatus:Bool) {
        self.animationView?.isHidden = lottieStatus
    }
}

extension CartVC : PresenterToViewCartProtocol
{
    func sendDataToView(cartList: Array<Cart>) {
        self.cartFoods = cartList
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
            var total = 0
            self.cartFoods.forEach{   cart_food in
                total = total  + (Int(cart_food.yemek_fiyat ?? "0")! * Int(cart_food.yemek_siparis_adet ?? "0")!)
                self.cartTableView.isHidden = false
                self.lottieShowHide(lottieStatus: true)
            }
            
           self.totalPrice.text = "\(total) ₺"
        }
    }
}



extension CartVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartFoods.count == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.cartTableView.isHidden = true
                    self.totalPrice.text = "0 ₺"
                self.lottieShowHide(lottieStatus: false)
            }
        }
        return cartFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartFood = cartFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.cartFoodNameLabel.text = cartFood.yemek_adi!
        cell.cartFoodPriceLabel.text = "₺\(Int(cartFood.yemek_fiyat!)!).00"
        cell.cartFoodCount.text = "\(cartFood.yemek_siparis_adet!)"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartFood.yemek_resim_adi!)")
        {
            DispatchQueue.main.async {
                cell.cartFoodImage.kf.setImage(with : url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: ""){ (contextualAction,view,bool) in
            let cart = self.cartFoods[indexPath.row]
            self.cartFoods.remove(at: indexPath.row)
            self.cartPresenterObject?.deleteFoodCart(cart: cart, kullanici_adi: "ali_tiryakioglu")
            print("indexrow \(indexPath.row)")
            tableView.reloadData()
        }
        
        deleteAction.backgroundColor = UIColor(named: "FirstColor")
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

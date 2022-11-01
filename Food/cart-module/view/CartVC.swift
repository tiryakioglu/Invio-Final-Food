//
//  CartVC.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import UIKit

class CartVC: UIViewController {

    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    var cartFoods = [Cart]()
    var cartPresenterObject : ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.delegate = self
        cartTableView.dataSource = self
               
        CartRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.showFoodCart()
       }

    @IBAction func buttonDelete(_ sender: Any) {
        self.cartPresenterObject?.allDeleteFoodCart(carts: cartFoods)
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
            self.totalPrice.text = "0 ₺"
        }
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
                
            }
           self.totalPrice.text = "\(total) ₺"
        }
    }
    
}



extension CartVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartFood = cartFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.cartFoodNameLabel.text = cartFood.yemek_adi!
        cell.cartFoodPriceLabel.text = "₺\(Int(cartFood.yemek_fiyat!)!).00"
        cell.cartFoodCount.text = "\(cartFood.yemek_siparis_adet!) adet"
        
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
            
            tableView.reloadData()
            
            
        }
        
        deleteAction.backgroundColor = UIColor(named: "SecondyColor")
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

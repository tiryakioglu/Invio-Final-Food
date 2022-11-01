//
//  HomePageVC.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 30.10.2022.
//

import UIKit
import Kingfisher

class HomePageVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    var foodList = [Foods]()
    var foodFilter = [Foods]()
    
    var homePagePresenterObject:ViewToPresenterHomePageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        HomePageRouter.createModule(ref: self)
        
        let collectionDesign = UICollectionViewFlowLayout()
        collectionDesign.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionDesign.minimumInteritemSpacing = 10
        collectionDesign.minimumLineSpacing = 20
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 30) / 2
        collectionDesign.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        
        foodCollectionView.collectionViewLayout = collectionDesign
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePagePresenterObject?.showFoods()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail" {
                let food = sender as? Foods
                let destinationVC = segue.destination as! FoodDetailVC
                destinationVC.food = food
            }
        }
    
}


extension HomePageVC : PresenterToViewHomePageProtocol {
    func sendDataToView(foods: Array<Foods>) {
        self.foodList = foods
        self.foodFilter = foods
        self.foodCollectionView.reloadData()
    }
}

extension HomePageVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodFilter[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        
        cell.labelFoodName.text = food.yemek_adi
        cell.labelFoodPrice.text = "\(food.yemek_fiyat!) ₺"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.imageViewFoodImage.kf.setImage(with: url)
            }
        }
        
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.borderColor = UIColor.systemRed.cgColor
        cell.contentView.layer.borderWidth = 1
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetail = foodFilter[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: foodDetail)
    }
}

extension HomePageVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print(searchText)
        if searchText.isEmpty {
            foodFilter = foodList
        } else {
            foodFilter =
            foodList.filter( {$0.yemek_adi!.lowercased().contains(searchText.lowercased())})
        }
            self.foodCollectionView.reloadData()
        }
    
}



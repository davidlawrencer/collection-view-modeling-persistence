//
//  ViewController.swift
//  collection-view-with-persistence
//
//  Created by David Rifkin on 10/3/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DogsViewController: UIViewController {
    
    var dogs = [Dog]() {
        didSet {
            dogsCollectionView.reloadData()
        }
    }
    
    var favorites = [Favorite]() {
        didSet {
            dogsCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        loadData()
    }
    
    private func setUpCollectionView() {
        dogsCollectionView.dataSource = self
        layout()
    }
    
    private func loadData() {
        dogs = Dog.getDogs()
        favorites = try! FavoritePersistenceHelper.manager.getFavorites()
    }
    
    private func performFavoriteAction(breed: String, id: Int) {
        let alertVC = UIAlertController(title: "Favorite \(breed)?", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //this will create a new favorite for a dog
            DispatchQueue.global(qos: .utility).async {
                do {
                    try FavoritePersistenceHelper.manager.save(newFavorite: Favorite(dogID: id))
                } catch {
                    //could not favorite, try again later
                }
                
            }
        }))
        alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)    }
}

extension DogsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dog = dogs[indexPath.row]
        guard let  cell = dogsCollectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? DogCollectionViewCell else {return UICollectionViewCell()}
        cell.breedLabel.text = ""
        cell.dogImageView.image = UIImage(named: dog.image)
        
        cell.buttonFunction = {
            self.performFavoriteAction(breed: dog.breed, id: dog.id)
        }
        
        if favorites.contains(where: { $0.dogID == dog.id }) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

        return cell
    }
}

extension DogsViewController: UICollectionViewDelegateFlowLayout {
    func layout() {
        guard let layout = self.dogsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: (self.dogsCollectionView.frame.size.width - 20) / 3, height: self.dogsCollectionView.frame.size.height / 4)
        layout.scrollDirection = .horizontal
    }
}

//
//  ViewController.swift
//  CountriesJSON
//
//  Created by Vladimir Kratinov on 2022/2/4.
//

import UIKit

class TableVC: UICollectionViewController {
    
    var countries: [Country]?
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = false
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.isNavigationBarHidden = false
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Northern Europe"
        navigationController?.navigationBar.isHidden = false
        
        performSelector(onMainThread: #selector(parseJSON), with: nil, waitUntilDone: false)
        parseJSON()
    }
    
    @objc func parseJSON() {
        guard let path = Bundle.main.path(
                forResource: "countries",
                ofType: "json"
        ) else { return }
        let url = URL(fileURLWithPath: path)

        do {
            let jsonData = try Data(contentsOf: url)
            countries = try JSONDecoder().decode([Country].self, from: jsonData)
        }
        catch {
            print(String(describing: error))
        }
    }
    
    //MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rCell", for: indexPath) as? CountryCell else {
            fatalError("Unable to dequeue CountryCell.")
        }
        
        let country = countries?[indexPath.item]
        cell.countryName.text = country?.name
        
        let image = countries?[indexPath.item].id.lowercased()
        cell.flagImage.image = UIImage(named: "\(image!)240")
        cell.flagImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.flagImage.layer.borderWidth = 2
        cell.flagImage.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = DetailVC()
        dvc.detailItem = countries?[indexPath.item]
        navigationController?.pushViewController(dvc, animated: true)
        }    
}


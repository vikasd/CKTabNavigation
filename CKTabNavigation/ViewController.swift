//
//  ViewController.swift
//  CKTabNavigation
//
//  Created by Vikas Dalvi  on 13/09/19.
//  Copyright © 2019 Vikas Dalvi . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public typealias Team = (name: String, color: String)
    
    let teams:[Team] = [("Arsenal", "#EF0107"),
                        ("Aston Villa", "#95BFE5"),
                        ("Chelsea", "#034694"),
                        ("Crystal Palace", "#1B458F"),
                        ("Everton", "#003399"),
                        ("Liverpool", "#C8102E"),
                        ("Manchester City", "#6CABDD"),
                        ("Manchester United", "#DA291C"),
                        ("Tottenham Hotspur", "#132257"),
                        ("Newcastle United", "#241F20"),
                        ("West Ham", "#7A263A")]
    
    var selectedIndex = 0
    
    public lazy var collectionView: CKTabNavigationCollectionView = {
       
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = CKTabNavigationCollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
        collectionView.backgroundView = nil
        collectionView.backgroundColor = UIColor.clear
        
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CKTabCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CKTabCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        
        self.view.addSubview(self.collectionView)
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.selectedIndex == indexPath.item {
            
            if let tabCollectionView = collectionView as? CKTabNavigationCollectionView {
                tabCollectionView.sendSubviewToBack(tabCollectionView.selectionView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CKTabCollectionViewCell.self),
                                                      for: indexPath) as! CKTabCollectionViewCell
        
        let team = self.teams[indexPath.item]
        cell.label.text = team.name
        
        if self.selectedIndex == indexPath.item {
        
            if let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath),
                let tabCollectionView = collectionView as? CKTabNavigationCollectionView {
             
                let frame = layoutAttributes.frame.insetBy(dx: 10.0, dy: 10)
                tabCollectionView.selectionView.frame = frame
                tabCollectionView.selectionView.layer.cornerRadius = frame.height * 0.5
                tabCollectionView.selectionView.backgroundColor = UIColor(hex: team.color)
                tabCollectionView.selectionView.layer.shadowColor = UIColor.black.cgColor
                tabCollectionView.selectionView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                tabCollectionView.selectionView.layer.shadowRadius = 2.0
                tabCollectionView.selectionView.layer.shadowOpacity = 1.0
                tabCollectionView.selectionView.layer.masksToBounds = false
                
                    
                cell.label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
                cell.label.textColor = UIColor.white
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.selectedIndex == indexPath.item { return }
        
        if let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath),
            let tabCollectionView = collectionView as? CKTabNavigationCollectionView {
            
            let frame = layoutAttributes.frame.insetBy(dx: 10.0, dy: 10)
            let oldFrame = tabCollectionView.selectionView.frame
            
            var tempFrame = CGRect.zero
            let width = (selectedIndex < indexPath.item) ? frame.maxX - oldFrame.minX : oldFrame.maxX - frame.minX
            let x = (selectedIndex < indexPath.item) ? oldFrame.minX : frame.minX
            
            tempFrame = CGRect(x: x, y: frame.minY, width: width, height: frame.height)
            
            tabCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            UIView.animate(withDuration: 0.25,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: {
                    
                tabCollectionView.selectionView.frame = tempFrame
                    
            }) { (_) in
                
                let color = self.teams[indexPath.item].color
                tabCollectionView.selectionView.backgroundColor = UIColor(hex: color)
                
                UIView.animate(withDuration: 0.25,
                               delay: 0.0,
                               options: .curveEaseInOut,
                               animations: {
                                tabCollectionView.selectionView.frame = frame
                }, completion: { (_) in
                    self.selectedIndex = indexPath.item
                })
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let name = self.teams[indexPath.item].name
        var width = name.width(withConstrainedHeight: 60.0, font: UIFont.systemFont(ofSize: 14.0, weight: .semibold))
        width += (2 * 20)
        return CGSize(width: width, height: 60.0)
    }
}




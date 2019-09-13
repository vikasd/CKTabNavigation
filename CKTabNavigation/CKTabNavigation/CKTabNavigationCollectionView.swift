//
//  CKTabNavigationCollectionView.swift
//  CKTabNavigation
//
//  Created by Vikas Dalvi  on 13/09/19.
//  Copyright © 2019 Vikas Dalvi . All rights reserved.
//

import UIKit

class CKTabNavigationCollectionView: UICollectionView {

    public lazy var selectionView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        
        return view
    }()
    
    init() {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        self.setupUI()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.selectionView)
    }
    
}

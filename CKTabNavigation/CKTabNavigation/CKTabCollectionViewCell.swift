//
//  CKTabCollectionViewCell.swift
//  CKTabNavigation
//
//  Created by Vikas Dalvi  on 13/09/19.
//  Copyright © 2019 Vikas Dalvi . All rights reserved.
//

import UIKit

class CKTabCollectionViewCell: UICollectionViewCell {
 
    public lazy var label: UILabel = {
       
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.backgroundView = nil
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(self.label)
        self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.0).isActive = true
    }
    
    override var isSelected: Bool {
        
        didSet {
            self.label.textColor = isSelected ? .white : .black
            self.label.font = isSelected ? UIFont.systemFont(ofSize: 14.0, weight: .semibold) : UIFont.systemFont(ofSize: 14.0)
        }
    }
}

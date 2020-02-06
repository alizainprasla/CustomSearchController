//
//  FilterScrollView.swift
//  CustomSearchController
//
//  Created by Ali Zain on 03/02/2020.
//  Copyright © 2020 Ali Zain. All rights reserved.
//

import UIKit

class FilterScrollView: UIView {
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var stackView:UIStackView!

    class func getXIB() -> FilterScrollView {
        let xib = Bundle.main.loadNibNamed(String(describing :self), owner: self, options: nil)
        let me = xib![0] as! FilterScrollView
        return me
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.subviews.forEach { (item) in
            item.isHidden = true
            UIView.animate(withDuration: 0.2, animations: {
                item.isHidden = false
                item.alpha = 1
            })
        }
    }
    

}

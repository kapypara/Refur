//
//  TextPageViewController.swift
//  Refur
//
//  Created by Yousif Isa Shamtoot on 20/04/2023.
//

import UIKit

enum TextType {
    case Privacy, Help, About
}

class TextPageViewController: UIViewController {
    
    @IBOutlet weak var pageContent: UILabel!
    
    var textType: TextType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let textType = textType else { return }
        
        switch textType {
        case .Privacy:
            pageContent.text = privacyPolicy
            
        case .Help:
            pageContent.text = helpAndFeedback
            
        case .About:
            pageContent.text = aboutUs
        }
    }
}

let privacyPolicy = """

you have no data :P

"""

let helpAndFeedback = """

no help 4U

"""

let aboutUs = """

w3 rulz

"""


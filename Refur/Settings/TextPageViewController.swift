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

At Refur, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your personal data when you use our app.

Information We Collect:
We may collect certain personal information from you when you use our app, such as your name, email address, and location data. We use this information to provide you with a personalized experience and to improve our app's functionality.

How We Use Your Information:
We use your personal data to provide you with a better experience on Refur, such as by customizing content and providing personalized recommendations.

How We Protect Your Information:
We take your privacy seriously and have implemented a variety of security measures to protect your personal information from unauthorized access or disclosure. We store your information securely and use encryption technology to protect it during transmission.

Third-Party Services:
We may use third-party services, such as Google Analytics, to help us better understand how users interact with our app. These services may collect information about your use of Refur, such as your IP address and the type of device you're using. We do not share your personal information with these third-party services.

Changes to Our Privacy Policy:
We may update this Privacy Policy from time to time. If we make any material changes to the policy, we will notify you by email or by posting a notice on Refur.

If you have any questions or concerns about our Privacy Policy, please contact us at (Refur@costumerservice.com).

"""

let helpAndFeedback = """

We're here to help! If you have any questions, comments, or feedback about our app, please don't hesitate to contact us. You can reach us through our support email (Refur@costumerservice.com) or by contacting us directly on (+973 3333 3334)

We value your feedback and use it to guide our ongoing development efforts. Your input helps us make our app even better and more user-friendly. So please, don't hesitate to get in touch with us. We're here to help you get the most out of Refur!

"""

let aboutUs = """

Welcome to Refur! We're a team of passionate thrifters who are committed to making secondhand shopping easier and more accessible for everyone. We believe that thrifting is not only a great way to save money, but also a sustainable choice that helps reduce waste and protect the environment. Our mission is to connect people who love thrift shopping with the best deals and most unique finds in their local area.

Our team is dedicated to providing a seamless experience for our users. We are constantly updating our app to improve its functionality and ensure that it meets the needs of our growing community. We also value your feedback and suggestions, so please don't hesitate to reach out to us if you have any ideas or questions.

Thank you for choosing our Refur and joining us on this exciting journey. Together, we can make thrifting more accessible and sustainable for everyone.

"""


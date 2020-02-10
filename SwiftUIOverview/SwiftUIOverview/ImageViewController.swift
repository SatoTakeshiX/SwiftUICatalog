//
//  ImageViewController.swift
//  SwiftUIOverview
//
//  Created by satoutakeshi on 2020/02/03.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "wing"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        let shadowView = UIView()
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 1
        shadowView.backgroundColor = .white

        view.addSubview(shadowView)
        view.addSubview(imageView)


        imageView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true
        imageView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1).isActive = true

        shadowView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        shadowView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        shadowView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true
        shadowView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1).isActive = true
    }
}

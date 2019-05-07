//
//  SecondViewController.swift
//  BCSTest
//
//  Created by Олег Мельник on 05/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "SecondViewController"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

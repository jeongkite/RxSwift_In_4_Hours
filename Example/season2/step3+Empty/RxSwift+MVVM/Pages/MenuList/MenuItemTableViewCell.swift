//
//  MenuItemTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var price: UILabel!
    
    var viewModel: MenuListViewModel!

    @IBAction func onIncreaseCount() {
        viewModel.increaseCount(self)   // 이런식으로 데이터를 넘겨서 업데이트 하는 방법도 있을 것.
    }

    @IBAction func onDecreaseCount() {
    }
}

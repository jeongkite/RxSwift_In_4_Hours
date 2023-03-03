//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by 양정연 on 2023/03/03.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

// ViewModel : View를 표현하기 위한 모델
struct Menu {
    var id: UUID = UUID()
    var name: String
    var price: Int
    var count: Int
}

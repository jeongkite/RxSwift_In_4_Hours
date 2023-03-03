//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 양정연 on 2023/03/03.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

import RxSwift

class MenuListViewModel {
    
    var menuObservable = PublishSubject<[Menu]>()
    
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
    }
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        let menus: [Menu] = [
            Menu(name: "튀김1", price: 100, count: 0),
            Menu(name: "튀김2", price: 300, count: 0),
            Menu(name: "튀김3", price: 500, count: 0),
            Menu(name: "튀김4", price: 200, count: 0),
            Menu(name: "튀김5", price: 300, count: 0)
        ]
        menuObservable.onNext(menus)
    }
}

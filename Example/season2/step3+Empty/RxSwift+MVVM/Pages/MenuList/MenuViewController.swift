//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    let cellId = "MenuItemTableViewCell"
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubscribe()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }
    
    func setSubscribe() {
        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MenuItemTableViewCell.self)) { index, item, cell in
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map { "\($0)" }
        // 1. 에러 발생 시, 그냥 빈문자열로 대체
            .catchErrorJustReturn("")
            .observeOn(MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
        // 2. 에러 발생, 발생하지 않은 경우 나누어 처리,
        // + Drive는 항상 메인에서 처리
            .asDriver(onErrorJustReturn: "")
            .drive(totalPrice.rx.text)
            .disposed(by: disposeBag)
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
//        viewModel.menuObservable.onNext([
//            Menu(name: "chaged", price: Int.random(in: 100...1000), count: Int.random(in: 0...3)),
//            Menu(name: "chaged", price: Int.random(in: 100...1000), count: Int.random(in: 0...3)),
//            Menu(name: "chaged", price: Int.random(in: 100...1000), count: Int.random(in: 0...3)),
//            Menu(name: "chaged", price: Int.random(in: 100...1000), count: Int.random(in: 0...3))
//        ])
        viewModel.onOrder()
    }
}

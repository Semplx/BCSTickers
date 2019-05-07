//
//  TickersController.swift
//  BCSTest
//
//  Created by Олег Мельник on 21/02/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import RxSwift

class TickersController: UIViewController {
    
    var viewModel: TickersViewModel!
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.needsUpdate = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.needsUpdate = false
    }
}

extension TickersController {
    private func setUp() {
        title = "Tickers"
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.allowsSelection = false
        addTableConstraints()
        tableView.register(TickerCell.self, forCellReuseIdentifier: TickerCell.typeName)
        
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: TickerCell.typeName,
                                                         cellType: TickerCell.self)) { _, element, cell in
                                                            self.bind(tickerItem: element, cell: cell)
        }
        .disposed(by: disposeBag)
    }
    
    private func addTableConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind(tickerItem: TickerItemViewModel, cell: TickerCell) {
        var cellViewModel: TickerCellViewModel!
        if let vm = cell.viewModel {
            cellViewModel = vm
        } else {
            cellViewModel = TickerCellViewModel()
            cell.viewModel = cellViewModel
        }
        
        cellViewModel.tickerName.onNext(tickerItem.name)
        cellViewModel.last.onNext(tickerItem.last)
        cellViewModel.highestBid.onNext(tickerItem.highestBid)
        cellViewModel.percentChange.onNext(tickerItem.percentChange)
    }
}

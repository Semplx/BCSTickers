//
//  TickerCell.swift
//  BCSTest
//
//  Created by Олег Мельник on 02/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

let countToRound = 8

class TickerCell: UITableViewCell {
    
    var viewModel: TickerCellViewModel? {
        didSet {
            disposeBag = DisposeBag()
            bindViewModel()
        }
    }
    
    private var disposeBag: DisposeBag?
    private var nameLabel: UILabel!
    private var lastLabel: UILabel!
    private var highestBidLabel: UILabel!
    private var percentChangeLabel: UILabel!
    private var lastLastValue: Double = -1
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(8)
        }
        
        highestBidLabel = UILabel()
        contentView.addSubview(highestBidLabel)
        highestBidLabel.font = UIFont.systemFont(ofSize: 15)
        highestBidLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        lastLabel = UILabel()
        contentView.addSubview(lastLabel)
        lastLabel.textAlignment = .right
        lastLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        lastLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        percentChangeLabel = UILabel()
        percentChangeLabel.textAlignment = .right
        contentView.addSubview(percentChangeLabel)
        percentChangeLabel.font = UIFont.systemFont(ofSize: 15.0)
        percentChangeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(lastLabel.snp.right)
            make.top.equalTo(highestBidLabel.snp.top)
        }
    }
    
    private func bindViewModel() {
        guard let `viewModel` = viewModel,
        let `disposeBag` = disposeBag else { return }
        viewModel.tickerName.asObservable()
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.highestBid.asObservable()
            .distinctUntilChanged()
            .do(onNext: {_ in self.blink()})
            .map { $0.stringWithDecimals(countToRound) }
            .bind(to: highestBidLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.last.asObservable()
            .distinctUntilChanged()
            .do(onNext: {_ in self.blink()})
            .map { $0.stringWithDecimals(countToRound) }
            .bind(to: lastLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.percentChange.asObservable()
            .distinctUntilChanged()
            .do(onNext: {_ in self.blink()})
            .map { value in
                let stringValue = abs(value * 100).stringWithDecimals(countToRound - 2) + "%"
                let attrString = NSMutableAttributedString(string: stringValue)
                attrString.addAttribute(NSAttributedString.Key.foregroundColor,
                                        value: value > 0 ? UIColor.green : UIColor.red,
                                        range: NSMakeRange(0, stringValue.count))
                return attrString
            }
            .bind(to: percentChangeLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    private func blink() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
            self.contentView.alpha = 1
        })
    }
}

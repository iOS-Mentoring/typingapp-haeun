//
//  CalendarView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/25/25.
//

import UIKit

final class CalendarView: UIView {
    private let weekdayHeaderView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var weekCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let viewModel = CalendarViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupWeekdayHeader(viewModel.weekdaySymbols())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .inversePrimaryEmphasis
        
        addSubview(weekdayHeaderView, autoLayout: [.top(10), .leading(10), .trailing(10), .height(12)])
        addSubview(weekCollectionView, autoLayout: [.topNext(to: weekdayHeaderView, constant: 10), .leading(10), .trailing(10), .height(60)])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 7)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setupWeekdayHeader(_ symbols: [String]) {
        weekdayHeaderView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for symbol in symbols {
            let label = UILabel()
            label.text = symbol
            label.textAlignment = .center
            label.font = .pretendard(type: .regular, size: 10)
            if symbol == "Sun" {
                label.textColor = .primaryRed
            } else {
                label.textColor = .primaryEmphasis
            }
            weekdayHeaderView.addArrangedSubview(label)
        }
    }
}

extension CalendarView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        
        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    
}

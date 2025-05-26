//
//  CalendarView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/25/25.
//

import UIKit
import Combine
import SwiftUI

enum CalendarSection: Hashable {
    case calendar
}

final class CalendarView: UIView {
    private lazy var weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<CalendarSection, CalendarDay>!
    
    private var cancellables = Set<AnyCancellable>()
    
    private let daySelectedSubject = PassthroughSubject<IndexPath, Never>()
    
    var daySelected: AnyPublisher<IndexPath, Never> {
        daySelectedSubject.eraseToAnyPublisher()
    }
    
    private var selectedIndexPath: IndexPath?
    
    init() {
        super.init(frame: .zero)
        setupUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementㅂed")
    }
    
    private func setupUI() {
        backgroundColor = .inversePrimaryEmphasis
        
        addSubview(weekCollectionView, autoLayout: [.top(0), .leading(10), .trailing(10), .height(95)])
    }
    
    func updateSelectedCell(at index: IndexPath) {
        if let previousIndexPath = selectedIndexPath,
           let previousCell = weekCollectionView.cellForItem(at: previousIndexPath) as? DayCell {
            previousCell.setSelected(false)
        }
        
        if let newCell = weekCollectionView.cellForItem(at: index) as? DayCell {
            newCell.setSelected(true)
        }
        selectedIndexPath = index
        weekCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }
}

extension CalendarView {
    private func configureCollectionView() {
        weekCollectionView.backgroundColor = .inversePrimaryEmphasis
        weekCollectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        weekCollectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: weekCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell else { return UICollectionViewCell() }
            cell.configure(with: itemIdentifier)
            if self.selectedIndexPath == indexPath {
                cell.setSelected(true)
            } else {
                cell.setSelected(false)
            }
            return cell
        })
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 7)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func applySnapshot(items: [CalendarDay], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<CalendarSection, CalendarDay>()
        snapshot.appendSections([.calendar])
        snapshot.appendItems(items, toSection: .calendar)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        daySelectedSubject.send(indexPath)
    }
}

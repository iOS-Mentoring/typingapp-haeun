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
    case header
    case calendar
}

final class CalendarView: UIView {
    private lazy var weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<CalendarSection, CalendarDay>!
    
    
    private var cancellables = Set<AnyCancellable>()
    
    private let daySelectedSubject = PassthroughSubject<Date, Never>()
    
    var daySelected: AnyPublisher<Date, Never> {
        daySelectedSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupBindings()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .inversePrimaryEmphasis
        
        addSubview(weekCollectionView, autoLayout: [.top(0), .leading(10), .trailing(10), .height(95)])
    }
    
    private func setupBindings() {
        /*viewModel.daysPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.weekCollectionView.reloadData()
                
                DispatchQueue.main.async {
                    self?.scrollToTodayWeek()
                    self?.updateSelectedCell()
                }
            }
            .store(in: &cancellables)
        
        viewModel.selectedDayPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] day in
                guard let self = self, let day = day else { return }
                self.updateSelectedCell()
            }
            .store(in: &cancellables)*/
    }
    
    private func updateSelectedCell() {
        for cell in weekCollectionView.visibleCells {
            if let dayCell = cell as? DayCell {
                dayCell.setSelected(false)
            }
        }
        
        /*if let selectedIndex = viewModel.selectedIndex(),
           let cell = weekCollectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? DayCell {
            cell.setSelected(true)
        }*/
    }
    
    private func scrollToTodayWeek() {
        /*if let todayWeekIndex = viewModel.todayWeekIndex() {
            let indexPath = IndexPath(item: todayWeekIndex, section: 0)
            weekCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }*/
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
        //viewModel.selectDay(at: indexPath.item)
    }
}

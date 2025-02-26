//
//  CalendarView.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/25/25.
//

import UIKit
import Combine

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
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let viewModel = CalendarViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
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
            heightDimension: .fractionalHeight(1.0)
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
    
    private func setupBindings() {
        viewModel.daysPublisher
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
                guard let self = self, day != nil else { return }
                self.updateSelectedCell()
                //self.delegate?.calendarView(self, didSelectDay: day)
            }
            .store(in: &cancellables)
    }
    
    private func updateSelectedCell() {
        for cell in weekCollectionView.visibleCells {
            if let dayCell = cell as? DayCell {
                dayCell.setSelected(false)
            }
        }
        
        if let selectedIndex = viewModel.selectedIndex(),
           let cell = weekCollectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? DayCell {
            cell.setSelected(true)
        }
    }
    
    private func scrollToTodayWeek() {
        if let todayWeekIndex = viewModel.todayWeekIndex() {
            let indexPath = IndexPath(item: todayWeekIndex, section: 0)
            weekCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension CalendarView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as? DayCell,
              indexPath.item < viewModel.days.count else {
            return UICollectionViewCell()
        }
        
        let day = viewModel.days[indexPath.item]
        let isSelected = viewModel.selectedIndex() == indexPath.item
        cell.configure(with: day, isSelected: isSelected)
        
        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectDay(at: indexPath.item)
    }
}

//
//  CompletePopupViewController.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/13/25.
//

import UIKit
import Combine

final class CompletePopupViewController: BaseViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    private let gradientView = UIView()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let title1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 50)
        label.textColor = .primaryEmphasis
        label.attributedText = NSAttributedString(
            string: "Good!",
            attributes: [.kern: -0.05 * 50]
        )
        return label
    }()
    
    private let title2Label: UILabel = {
        let label = UILabel()
        label.font = .pretendard(type: .medium, size: 16)
        label.textColor = .primaryEmphasis
        label.attributedText = NSAttributedString(
            string: "오늘 필사를 완료했어요",
            attributes: [.kern: -0.03 * 16]
        )
        return label
    }()
    
    private let haruImageView: UIImageView = {
        let imageView = UIImageView(image: .illustHaruWhole)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let recordView = RecordView()
    private let typoView = TypoView()
    
    private let downloadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(hexCode: "111111")
        configuration.image = .iconInverseDownload
        configuration.imagePlacement = .leading
        configuration.imagePadding = 6
        configuration.background.cornerRadius = 0
        
        let attributedString = NSAttributedString(
            string: "이미지 저장하기",
            attributes: [
                .foregroundColor: UIColor.inversePrimaryEmphasis,
                .font: UIFont.pretendard(type: .semiBold, size: 16)
            ]
        )
        configuration.attributedTitle = AttributedString(attributedString)
        
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    @objc private func downloadButtonTapped() {
        let captureFrame = CGRect(
            x: typoView.frame.minX - 20,
            y: typoView.frame.minY - 30,
            width: UIScreen.width,
            height: typoView.frame.height + 70
        )
        
        let capturedImage = viewModel.captureImage(view: view, frame: captureFrame)
        showShareSheet(with: capturedImage)
    }
    
    private let viewModel: CompleteViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CompleteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = gradientView.bounds
    }
    
    private func setupNavigation() {
        let closeButton = UIBarButtonItem(
            image: .iconClose,
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView, autoLayout: [.topSafeArea(-224), .leadingSafeArea(-354), .height(1084), .width(1084)])
        view.addSubview(gradientView, autoLayout: [.topSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .height(74)])
        gradientView.layer.addSublayer(gradientLayer)
        
        titleStackView.addArrangedSubview(title1Label)
        titleStackView.addArrangedSubview(title2Label)
        view.addSubview(titleStackView, autoLayout: [.topSafeArea(70), .leading(20)])
        
        view.addSubview(haruImageView, autoLayout: [.topSafeArea(12), .trailingSafeArea(0), .leadingSafeArea(265), .aspectRatio(14.0/11.0)])
        
        view.addSubview(recordView, autoLayout: [.topSafeArea(192), .leadingSafeArea(20), .trailingSafeArea(20), .height(88)])
        
        view.addSubview(typoView, autoLayout: [.topSafeArea(320), .leading(20), .trailing(20)])
        
        view.addSubview(downloadButton, autoLayout: [.bottom(0), .leading(0), .trailing(0), .height(70)])
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }
    
    private func showShareSheet(with image: UIImage) {
        let activityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        present(activityViewController, animated: true)
    }
}

//
//  ViewController.swift
//  EventHubApp
//
//  Created by Andrew Linkov on 18.11.2024.
//
import UIKit
import SwiftUI

protocol OnboardingViewPresenter: AnyObject {
    func didTapNext()

}

final class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: OnboardingViewPresenter?
    private var slides = [OnboardingView]()
    
    // MARK: - UI
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        return scrollView
    }()
    
    internal let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .clear
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    internal let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    internal let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Init
    init(presenter: OnboardingViewPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.delegate = self
        setupView()
        slides = createSlides()
        setUpSlidesScrollView(slides: slides)
        setupConstraints()
    }
    
    @objc private func handleNextButtonTap() {
        let nextPage = pageControl.currentPage + 1
        if nextPage < slides.count {
            let offsetX = CGFloat(nextPage) * scrollView.frame.width
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            pageControl.currentPage = nextPage
        } else {
//MARK: TODO - переход к главной странице
            presenter?.didTapNext()
        }
    }
    
    @objc private func handleSkipButtonTap() {
        let lastPage = slides.count - 1
        let offsetX = CGFloat(lastPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        pageControl.currentPage = lastPage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.layoutIfNeeded()
        scrollView.setContentOffset(.zero, animated: false)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
        
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
        
        skipButton.addTarget(self, action: #selector(handleSkipButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Methods
    func setupSlideUI(
        image: String,
        title: String?,
        description: String,
        nextButtonTitle: String,
        target: AnyObject?,
        action: Selector?
    ){}
        

        
    private func setupView() {
        [scrollView, pageControl, nextButton, skipButton].forEach(view.addSubview)
    }
    
    func createSlides() -> [OnboardingView] {
        let slide1 = OnboardingViewImpl()
        slide1.setupSlideUI(
            image: "onb1",
            title: """
                    Explore Upcoming and 
                              Nearby Events
                    """,
            description: "In publishing and graphic design, Lorem is a olaceholder text commonly",
            nextButtonTitle: "Next",
            target: self,
            action: #selector(handleNextButtonTap)
        )
       
        
        let slide2 = OnboardingViewImpl()
        slide2.setupSlideUI(
            image: "onb2",
            title: """
                    Web Have Modern Events 
                             Calendar Feature
                    """,
            description: "In publishing and graphic design, Lorem is a olaceholder text commonly",
            nextButtonTitle: "Next",
            target: self,
            action: #selector(handleNextButtonTap)
        )
        
        let slide3 = OnboardingViewImpl()
        slide3.setupSlideUI(
            image: "onb3",
            title: """
                    To Look Up More Events or 
                      Activities Nearby By Map
                    """ ,
            description: "In publishing and graphic design, Lorem is a olaceholder text commonly" ,
            nextButtonTitle: "Next",
            target: self,
            action: #selector(handleNextButtonTap)
            
        )
        
        return [slide1, slide2, slide3]
    }
    
    func setUpSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)

        for (index, slide) in slides.enumerated() {
            slide.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            slide.backgroundColor = .white
            scrollView.addSubview(slide)
        }
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        scrollView.contentOffset.y = 0
        pageControl.currentPage = Int(pageIndex)
        
        let maxHorizontalOffset = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                   y: (0.5 - percentHorizontalOffset) / 0.5)
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransform)
        } else {
            let secondTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                    y: (0.5 - percentHorizontalOffset) / 0.5)
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                   y: percentHorizontalOffset)
            
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
        }
    }
}

//MARK: - OnboardingViewController + OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func updateUI() {
        
    }
    
    
    func scrollToNextSlide() {
          let nextPage = min(pageControl.currentPage + 1, slides.count - 1)
          let offsetX = CGFloat(nextPage) * view.frame.width
          scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
          pageControl.currentPage = nextPage
      }
}

extension OnboardingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 111),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 111),
            skipButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

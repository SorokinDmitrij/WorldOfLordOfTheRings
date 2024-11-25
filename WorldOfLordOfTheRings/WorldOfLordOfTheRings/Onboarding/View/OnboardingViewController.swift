//
//  ViewController.swift
//  WorldOfLordOfTheRings
//
//  Created by mac on 22.11.2024.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private var viewModel: [OnboardingPageModel] = [
        OnboardingPageModel(
            imageName: "onboarding1",
            title: String( "Добро пожаловать!"),
            description: String( "Вас ждёт захватывающее путешествие по миру, созданному Дж. Р. Р. Толкином. Изучите персонажей, узнайте их истории и почувствуйте себя частью легенды. Исследуйте Средиземье вместе с нами!")
        ),
        OnboardingPageModel(
            imageName: "onboarding2",
            title: String( "Подробности"),
            description: String( "Каждый персонаж — это уникальная история. Мы собрали биографии, подробные описания, значимые события из их жизни и их роль в эпической битве за Кольцо Всевластия.")
        ),
        OnboardingPageModel(
            imageName: "onboarding3",
            title: String( "Любимые персонажи"),
            description: String( "У каждого из нас есть любимый герой: храбрый Арагорн, мудрый Гэндальф, верный Сэм или непредсказуемый Голлум. Добавляйте персонажей в избранное, чтобы всегда держать их под рукой.")
        ),
        OnboardingPageModel(
            imageName: "onboarding4",
            title: String( "Цитаты"),
            description: String( "Слова героев живут в веках: от вдохновляющих речей Гэндальфа до философских размышлений Голлума. Наслаждайтесь коллекцией цитат и используйте их как источник мотивации.")
        )
    ]
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pvc.dataSource = self
        pvc.delegate = self
        return pvc
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.direction = .leftToRight
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.pageIndicatorTintColor = .black
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = viewModel.count
        pageControl.addTarget(self, action: #selector(self.pageControlDidChange(_:)), for: .valueChanged)
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized:"Пропустить"), for: .normal)
        button.titleLabel?.font = .GreatVibes.regular.size(of: 20)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized:"Дальше"), for: .normal)
        button.titleLabel?.font = .GreatVibes.regular.size(of: 25)
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.alpha = 0.5
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        setup()
        setupConstreint()
        
        func setup(){
            view.addSubview(pageViewController.view)
            view.addSubview(skipButton)
            view.addSubview(pageControl)
            view.addSubview(nextButton)
        }
        func setupConstreint(){
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            skipButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -90),
                pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
                skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 280),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-100),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    private func viewController(at index: Int) -> OnboardingPageViewController? {
        guard index >= 0 && index < viewModel.count else { return nil }
        let vc = OnboardingPageViewController()
        vc.viewModel = viewModel[index]
        return vc
    }
    
    private func setupPageViewController() {
        if let initialVC = viewController(at: 0) {
            pageViewController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingPageViewController,
              let index = viewModel.firstIndex(where: { $0.title == vc.viewModel?.title }),
              index > 0 else {
            return nil
        }
        return self.viewController(at: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingPageViewController,
              let index = viewModel.firstIndex(where: { $0.title == vc.viewModel?.title }),
              index < viewModel.count - 1 else {
            return nil
        }
        return self.viewController(at: index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let currentVC = pageViewController.viewControllers?.first as? OnboardingPageViewController,
              let index = viewModel.firstIndex(where: { $0.title == currentVC.viewModel?.title }) else {
            return
        }
        pageControl.currentPage = index
        updateNextButtonTitle(for: index)
    }
    @objc private func skipButtonTapped() {
      //  router?.presentConfirmationAlert(String(localized:"Вы уверены, что хотите пропустить презентацию?"), message: nil, onConfirmation: { [weak self] in
         //       self?.endOnboarding()
          //  })
        }
        
        private func endOnboarding() {
            UserDefaults.standard.setValue(true, forKey: "hasCompletedOnboarding")
          //  router?.showMainScreen()
        }
        
        @objc private func nextButtonTapped() {
            guard let currentVC = pageViewController.viewControllers?.first as? OnboardingPageViewController,
                  let currentIndex = viewModel.firstIndex(where: { $0.title == currentVC.viewModel?.title }) else {
                return
            }
            
            let nextIndex = currentIndex + 1
            
            if nextIndex < viewModel.count, let nextVC = viewController(at: nextIndex) {
                pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: { [weak self] _ in
                    self?.pageControl.currentPage = nextIndex
                    self?.updateNextButtonTitle(for: nextIndex)
                })
            } else {
                endOnboarding()
            }
        }
        
        private func updateNextButtonTitle(for index: Int) {
            let isLastPage = index == viewModel.count - 1
            nextButton.setTitle(isLastPage ? String(localized:"Завершить") : String(localized:"Дальше"), for: .normal)
        }
        
        @objc private func pageControlDidChange(_ sender: UIPageControl) {
            let currentIndex = sender.currentPage
            if let nextVC = viewController(at: currentIndex) {
                pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: { [weak self] _ in
                    self?.pageControl.currentPage = currentIndex
                    self?.updateNextButtonTitle(for: currentIndex)
                })
            }
        }
    }


import UIKit

final class OnboardingViewController: UIViewController {

    let defaults = UserDefaults.standard
    private var nextButton = UIButton(type: .system)
    private var onboardingScrollView = UIScrollView()
    private var onboardingPageControl = UIPageControl()
    private var onboardingImageViewArray: [UIImageView] = []
    private var titleLabel = UILabel()
    private var subtitle1 = UILabel()
    private var subtitle2 = UILabel()
    
    private var keka = [Onboarding.Image.first.getImage,
                        Onboarding.Image.second.getImage,
                        Onboarding.Image.third.getImage,
                        Onboarding.Image.fourth.getImage,
                        Onboarding.Image.fifth.getImage]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
        let tabBarC = self.tabBarController?.tabBar
        tabBarC?.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        view.backgroundColor = .mDarkBlue
        onboardingPicturesScrollView()
        setupOnboardingPageControl()
        setupOnboardingImageViewArray()
        setupNextButton()
        setupLabels()
    }
    
    private func onboardingPicturesScrollView() {
        onboardingScrollView.isPagingEnabled = true
        onboardingScrollView.showsHorizontalScrollIndicator = false
        onboardingScrollView.delegate = self
        onboardingScrollView.contentSize = CGSize(
            width: Double(Int(view.bounds.width) * keka.count),
            height: 360
        )
    }
    
    private func setupOnboardingPageControl() {
        onboardingPageControl.numberOfPages = keka.count
        onboardingPageControl.currentPageIndicatorTintColor = .mLime
        onboardingPageControl.pageIndicatorTintColor = .mWhite
        onboardingPageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
    }
    
    private func setupOnboardingImageViewArray() {
        for i in 0..<keka.count {
            onboardingImageViewArray.append(UIImageView(image: keka[i]))
            onboardingImageViewArray[i].contentMode = .scaleToFill
        }
    }
    
    private func setupNextButton() {
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.titleLabel?.font = .robotoBold(ofSize: 16)
        nextButton.tintColor = .mDarkBlue
        nextButton.backgroundColor = .mLime
        nextButton.layer.cornerRadius = 4
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }

    private func setupLabels() {
        subtitle1.text = Onboarding.Subtitle1.first.getTitle
        subtitle1.textColor = .mWhite
        subtitle1.font = .montseratRegular(ofSize: 14)
        subtitle1.numberOfLines = 0
        subtitle1.textAlignment = .center
        titleLabel.text = Onboarding.Title.first.getTitle
        titleLabel.textColor = .mWhite
        titleLabel.font = .robotoBold(ofSize: 28)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        subtitle2.text = Onboarding.Subtitle2.first.getTitle
        subtitle2.textColor = .mLime
        subtitle2.font = .montseratRegular(ofSize: 10)
        subtitle2.numberOfLines = 0
        subtitle2.textAlignment = .center
    }
    
    //MARK: - Target Actions
    
    @objc private func pageControlDidChange() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func nextPage() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage + 1)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func pushViewController() {
        defaults.set("ok", forKey: "onbording")
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
//        navigationController?.pushViewController( Builder.getSignInModule(), animated: true)
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
        onboardingScrollViewsAddSubviews()
    }
    
    private func onboardingScrollViewsAddSubviews() {
        for i in 0..<onboardingImageViewArray.count {
            onboardingScrollView.addSubview(onboardingImageViewArray[i])
            onboardingImageViewArray[i].frame = CGRect(x: Int(view.bounds.width) * i, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.height))
        }
    }
    
    private func addSubViews() {
        let views: [UIView] = [onboardingScrollView, nextButton, onboardingPageControl, titleLabel, subtitle1, subtitle2]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        onboardingScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onboardingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            onboardingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            onboardingScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        onboardingPageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingPageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -104),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40 ),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        subtitle1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle1.bottomAnchor.constraint(equalTo: onboardingPageControl.topAnchor, constant: -173),
            subtitle1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            subtitle1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -52),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: subtitle1.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 53),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -74)
        ])
        
        subtitle2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle2.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            subtitle2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150),
            subtitle2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -162)
        ])
        }
    }


//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)

        switch onboardingPageControl.currentPage {
        case 0:
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = Onboarding.Subtitle1.first.getTitle
            titleLabel.text = Onboarding.Title.first.getTitle
            subtitle2.text = Onboarding.Subtitle2.first.getTitle
        case 1:
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = Onboarding.Subtitle1.second.getTitle
            titleLabel.text = Onboarding.Title.second.getTitle
            subtitle2.text = Onboarding.Subtitle2.second.getTitle
        case 2:
            subtitle1.text = Onboarding.Subtitle1.third.getTitle
            titleLabel.text = Onboarding.Title.third.getTitle
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle2.text = Onboarding.Subtitle2.third.getTitle
        case 3:
            subtitle1.text = Onboarding.Subtitle1.fourth.getTitle
            titleLabel.text = Onboarding.Title.fourth.getTitle
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle2.text = Onboarding.Subtitle2.fourth.getTitle

        case 4:
            subtitle1.text = Onboarding.Subtitle1.fifth.getTitle
            titleLabel.text = Onboarding.Title.fifth.getTitle
            subtitle2.text = Onboarding.Subtitle2.fifth.getTitle
            nextButton.setTitle("GET STARTED", for: .normal)
            nextButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        default:
            subtitle1.text = Onboarding.Subtitle1.first.getTitle
            titleLabel.text = Onboarding.Title.first.getTitle
        }
    }
}

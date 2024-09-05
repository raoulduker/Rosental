//
//  DashboardVC.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import Kingfisher
import UIKit

class DashboardVC: UIViewController {
    
    // MARK: - UI Components
    private let headerView = UIView()
    private let notificationsButton = UIButton()
    private let profileImageView = UIImageView()
    private let profileNameLabel = UILabel()
    private let addressLabel = UILabel()
    private let addressChevronImage = UIImageView()

    private let dashboardView = UIView()
    private let todayLabel = UILabel()
    private let menuItemStackView = UIStackView()
    private let bannerScrollView = UIScrollView()
    private let servicesStackView = UIStackView()
    private let servicesButton = RosentalButton(title: "Все сервисы")

    private let notificationsView = UIView()
    private let notificationLabel = UILabel()
    private let notificationImageView = UIImageView()
    
     var apiResponse: ApiResponse!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        configureHeaderView()
        configureDashboardView()
    }
    
    // MARK: - Dashboard Configuration
    private func configureDashboardView() {
        dashboardView.backgroundColor = .white
        dashboardView.layer.cornerRadius = 20
        dashboardView.applyShadow(opacity: 0.4, offset: CGSize(width: 0, height: -5), radius: 15)
        
        view.setupView(dashboardView)

        NSLayoutConstraint.activate([
            dashboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            dashboardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dashboardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dashboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        configureTodayLabel()
        configureNotificationView()
        configureMenuItems()
        configureBannerScrollView()
        configureServicesStackView()
        configureServicesButton()
    }

    // MARK: - Services Button Configuration
    private func configureServicesButton() {
        dashboardView.setupView(servicesButton)

        NSLayoutConstraint.activate([
            servicesButton.topAnchor.constraint(equalTo: servicesStackView.bottomAnchor, constant: 15),
            servicesButton.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor, constant: 15),
            servicesButton.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor, constant: -15),
            servicesButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - Services StackView Configuration
    private func configureServicesStackView() {
        servicesStackView.axis = .horizontal
        servicesStackView.distribution = .fillEqually
        servicesStackView.spacing = 15
        servicesStackView.translatesAutoresizingMaskIntoConstraints = false

        dashboardView.setupView(servicesStackView)

        for service in apiResponse.customerDashboard.services.prefix(3) {
            let serviceCard = ServiceCardView(service: service)
            servicesStackView.addArrangedSubview(serviceCard)
        }

        NSLayoutConstraint.activate([
            servicesStackView.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor, constant: 15),
            servicesStackView.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor, constant: -15),
            servicesStackView.topAnchor.constraint(equalTo: bannerScrollView.bottomAnchor, constant: 30),
            servicesStackView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }

    // MARK: - Banner ScrollView Configuration
    private func configureBannerScrollView() {
        bannerScrollView.translatesAutoresizingMaskIntoConstraints = false
        bannerScrollView.showsHorizontalScrollIndicator = false
        bannerScrollView.clipsToBounds = false
        bannerScrollView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        dashboardView.setupView(bannerScrollView)

        let bannerStackView = UIStackView()
        bannerStackView.axis = .horizontal
        bannerStackView.spacing = 15
        bannerStackView.translatesAutoresizingMaskIntoConstraints = false
        bannerStackView.clipsToBounds = false
        bannerScrollView.addSubview(bannerStackView)

        for banner in apiResponse.customerDashboard.banners {
            let bannerView = BannerView(banner: banner)
            bannerStackView.addArrangedSubview(bannerView)

            NSLayoutConstraint.activate([
                bannerView.widthAnchor.constraint(equalToConstant: view.frame.width - 50),
                bannerView.heightAnchor.constraint(equalToConstant: 70)
            ])
        }

        NSLayoutConstraint.activate([
            bannerScrollView.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor),
            bannerScrollView.widthAnchor.constraint(equalTo: dashboardView.widthAnchor),
            bannerScrollView.topAnchor.constraint(equalTo: menuItemStackView.bottomAnchor, constant: 30),
            bannerScrollView.heightAnchor.constraint(equalToConstant: 70),

            bannerStackView.leadingAnchor.constraint(equalTo: bannerScrollView.leadingAnchor),
            bannerStackView.trailingAnchor.constraint(equalTo: bannerScrollView.trailingAnchor),
            bannerStackView.topAnchor.constraint(equalTo: bannerScrollView.topAnchor),
            bannerStackView.bottomAnchor.constraint(equalTo: bannerScrollView.bottomAnchor)
        ])
    }

    // MARK: - Menu Items Configuration
    private func configureMenuItems() {
        menuItemStackView.axis = .vertical
        menuItemStackView.spacing = 27
        menuItemStackView.distribution = .fillEqually
        dashboardView.setupView(menuItemStackView)

        for menuItem in apiResponse.customerDashboard.menuItems {
            let menuItemView = MenuItemView(menuItem: menuItem)
            menuItemStackView.addArrangedSubview(menuItemView)

            NSLayoutConstraint.activate([
                menuItemView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }

        NSLayoutConstraint.activate([
            menuItemStackView.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor, constant: 15),
            menuItemStackView.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor, constant: -15),
            menuItemStackView.topAnchor.constraint(equalTo: notificationsView.bottomAnchor, constant: 30)
        ])
    }

    // MARK: - Notification Configuration
    private func configureNotificationView() {
        notificationsView.backgroundColor = .white
        notificationsView.applyShadow(opacity: 0.1, offset: CGSize(width: 0, height: 1), radius: 5)
        dashboardView.setupView(notificationsView)

        NSLayoutConstraint.activate([
            notificationsView.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor, constant: 15),
            notificationsView.trailingAnchor.constraint(equalTo: dashboardView.trailingAnchor, constant: -15),
            notificationsView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 15),
            notificationsView.heightAnchor.constraint(equalToConstant: 50)
        ])

        configureNotificationLabel()
        configureNotificationImageView()
    }

    private func configureNotificationLabel() {
        notificationLabel.text = "\(apiResponse.customerDashboard.notifications.count) сообщений от УК"
        notificationLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        notificationsView.setupView(notificationLabel)

        NSLayoutConstraint.activate([
            notificationLabel.leadingAnchor.constraint(equalTo: notificationsView.leadingAnchor, constant: 15),
            notificationLabel.centerYAnchor.constraint(equalTo: notificationsView.centerYAnchor)
        ])
    }

    private func configureNotificationImageView() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 8)
        notificationImageView.image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        notificationImageView.tintColor = .red
        notificationsView.setupView(notificationImageView)

        NSLayoutConstraint.activate([
            notificationImageView.trailingAnchor.constraint(equalTo: notificationsView.trailingAnchor, constant: -15),
            notificationImageView.centerYAnchor.constraint(equalTo: notificationsView.centerYAnchor)
        ])
    }

    // MARK: - Today Label Configuration
    private func configureTodayLabel() {
        let firstPart = "Сегодня"
        let secondPart = apiResponse.customerDashboard.date
        let fullText = "\(firstPart) \(secondPart)"

        let attributedString = NSMutableAttributedString(string: fullText)
        let secondPartRange = NSRange(location: firstPart.count + 1, length: secondPart.count)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: secondPartRange)
        todayLabel.attributedText = attributedString
        todayLabel.font = .systemFont(ofSize: 22, weight: .semibold)

        dashboardView.setupView(todayLabel)

        NSLayoutConstraint.activate([
            todayLabel.leadingAnchor.constraint(equalTo: dashboardView.leadingAnchor, constant: 15),
            todayLabel.topAnchor.constraint(equalTo: dashboardView.topAnchor, constant: 25)
        ])
    }

    // MARK: - Header View Configuration
    private func configureHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.07, green: 0.19, blue: 0.53, alpha: 1.00)
        view.setupView(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 500)
        ])

        configureNotificationsImage()
        configureProfileImage()
        configureProfileNameLabel()
        configureAddressLabel()
        configureAddressChevronImage()
    }

    private func configureNotificationsImage() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        let bellImage = UIImage(systemName: "bell", withConfiguration: largeConfig)
        notificationsButton.setImage(bellImage, for: .normal)
        notificationsButton.tintColor = .white
        headerView.setupView(notificationsButton)

        NSLayoutConstraint.activate([
            notificationsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            notificationsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    private func configureProfileImage() {
        profileImageView.kf.setImage(with: URL(string: apiResponse.myProfile.photo))
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 35 / 2
        profileImageView.layer.masksToBounds = true
        headerView.setupView(profileImageView)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            profileImageView.widthAnchor.constraint(equalToConstant: 35),
            profileImageView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    private func configureProfileNameLabel() {
        profileNameLabel.text = apiResponse.myProfile.shortName
        profileNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        profileNameLabel.textColor = .white
        headerView.setupView(profileNameLabel)

        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15)
        ])
    }

    private func configureAddressLabel() {
        addressLabel.text = apiResponse.myProfile.address
        addressLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        addressLabel.textColor = .white
        headerView.setupView(addressLabel)

        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor)
        ])
    }

    private func configureAddressChevronImage() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        addressChevronImage.image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        addressChevronImage.tintColor = .white
        headerView.setupView(addressChevronImage)

        NSLayoutConstraint.activate([
            addressChevronImage.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 5),
            addressChevronImage.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor)
        ])
    }
}

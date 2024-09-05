import UIKit

class WelcomeVC: UIViewController {
    
    // MARK: - UI Components
    private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
    private let companyNameSubLabel = UILabel()
    private let companyNameLabel = UILabel()
    private let companyNameSecondLabel = UILabel()
    private let inviteLabel = UILabel()
    private let houseImageView = UIImageView()
    private let loginButton = RosentalButton(title: "Вход")
    private let signUpButton = RosentalButton(backgroundColor: .clear, title: "Регистрация", hasOutline: true)
    private let welcomeTextLabel = UILabel()
    private let welcomeTextSubLabel = UILabel()
    
    var coordinator: AppCoordinator?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configure Views
    private func configure() {
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureCompanyNameLabel()
        configureInviteLabel()
        configureHouseImageView()
        configureButtons()
        configureWelcomeLabels()
    }

    // MARK: - Logo Image View Configuration
    private func configureLogoImageView() {
        view.setupView(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Company Name Label Configuration
    private func configureCompanyNameLabel() {
        companyNameSubLabel.text = "Управляющая компания"
        companyNameSubLabel.font = .preferredFont(forTextStyle: .caption2)
        view.setupView(companyNameSubLabel)

        companyNameLabel.text = "Розенталь"
        companyNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.setupView(companyNameLabel)

        companyNameSecondLabel.text = "Групп"
        companyNameSecondLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.setupView(companyNameSecondLabel)

        NSLayoutConstraint.activate([
            companyNameSubLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            companyNameSubLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),

            companyNameLabel.topAnchor.constraint(equalTo: companyNameSubLabel.bottomAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),

            companyNameSecondLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: -6),
            companyNameSecondLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10)
        ])
    }

    // MARK: - Invite Label Configuration
    private func configureInviteLabel() {
        inviteLabel.text = "Пригласить управлять своим домом"
        inviteLabel.textColor = .systemBlue
        inviteLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        view.setupView(inviteLabel)

        NSLayoutConstraint.activate([
            inviteLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            inviteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - House Image View Configuration
    private func configureHouseImageView() {
        houseImageView.image = UIImage(systemName: "house")
        houseImageView.contentMode = .scaleAspectFit
        houseImageView.tintColor = .systemBlue
        view.setupView(houseImageView)

        NSLayoutConstraint.activate([
            houseImageView.trailingAnchor.constraint(equalTo: inviteLabel.leadingAnchor),
            houseImageView.heightAnchor.constraint(equalToConstant: 15),
            houseImageView.centerYAnchor.constraint(equalTo: inviteLabel.centerYAnchor)
        ])
    }

    // MARK: - Button Configuration
    private func configureButtons() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.setupView(signUpButton)
        view.setupView(loginButton)

        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: inviteLabel.topAnchor, constant: -31),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -15),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            loginButton.heightAnchor.constraint(equalTo: signUpButton.heightAnchor)
        ])
    }

    // MARK: - Welcome Labels Configuration
    private func configureWelcomeLabels() {
        welcomeTextLabel.text = "Добро\nпожаловать!"
        welcomeTextLabel.numberOfLines = 0
        welcomeTextLabel.font = .systemFont(ofSize: 42, weight: .bold)
        view.setupView(welcomeTextLabel)

        welcomeTextSubLabel.text = "Авторизуйтесь, чтобы продолжить работу"
        welcomeTextSubLabel.font = .systemFont(ofSize: 14)
        welcomeTextSubLabel.textColor = .gray
        view.setupView(welcomeTextSubLabel)

        NSLayoutConstraint.activate([
            welcomeTextSubLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -33),
            welcomeTextSubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),

            welcomeTextLabel.bottomAnchor.constraint(equalTo: welcomeTextSubLabel.topAnchor, constant: -33),
            welcomeTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
    }

    // MARK: - Button Actions
    @objc private func loginButtonTapped() {
        coordinator?.showLoginScreen()
    }
}

////
////  SearchBarViewController.swift
////  EventHubApp
////
////  Created by Andrew Linkov on 25.11.2024.
////
//
//import UIKit
//
//protocol SearchBarViewPresenter: AnyObject {
//    
//    func eventsCount() -> Int
//    func fetchNews()
//    func didTapCell(at indexPath: IndexPath)
//}
//
//class SearchBarViewController: UIViewController {
//  
//    //MARK: - Properties
//    private let presenter: SearchBarViewPresenter
//    private var selectedEvent: Event
//    private var events : [Event] = []
//
//    
//    //MARK: - Init
//    init(presenter: SearchBarViewPresenter) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - UI Components
//    private lazy var tableView: UITableView = {
//        let table = UITableView()
//        table.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.reuseID)
//        table.delegate = self
//        table.dataSource = self
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.separatorStyle = .none
//        table.rowHeight = 105
//        return table
//    }()
//    
//    private var titleLabelBig: UILabel = {
//        let label = UILabel()
//        label.text = "Bookmarks"
//        label.font = .InterSemiBold(ofSize: 16)
//        label.textColor = .black
//        label.numberOfLines = 1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private var titleLabelSmall: UILabel = {
//        let label = UILabel()
//        label.text = "Saved articles to the library"
//        label.font = .InterRegular(ofSize: 16)
//        label.textColor = .greyPrimary
//        label.numberOfLines = 1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//        
//    
//    //MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupConstraints()
//        print("News count: \(news.count)")
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        
//    }
//    //MARK: - Public Methods
//    
////    func updateEmptyViewVisibility() {
////        emptyView.isHidden = presenter.newsCount() > 0
////        }
//    
//    func setupViews() {
//        [titleLabelBig, titleLabelSmall, tableView].forEach(view.addSubview)
//    }
//    
//    private func fetchArticles() {
//        presenter.fetchNews()
//    }
//}
//
//extension SearchBarViewController {
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabelBig.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
//            titleLabelBig.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            titleLabelSmall.leadingAnchor.constraint(equalTo: titleLabelBig.leadingAnchor),
//            titleLabelSmall.topAnchor.constraint(equalTo: titleLabelBig.bottomAnchor, constant: 8),
//
//            tableView.topAnchor.constraint(equalTo: titleLabelSmall.bottomAnchor, constant: 30),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//            }
//    }
//
////MARK: - BookmarksViewController + BookmarksViewDelegate
//extension SearchBarViewController: BookmarkViewDelegate {
//    
//}
//
//extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return news.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseID, for: indexPath) as? BookmarkCell else {
//            fatalError("Unable to dequeue BookmarkCell")
//        }
//        cell.set(info: news[indexPath.row])
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.didTapCell(at: indexPath.row, with: news)
//    }
//}
//
//    // MARK: - SwiftUI Preview for UIKit View
//    struct BookmarksViewController_Preview: PreviewProvider {
//        static var previews: some View {
//            BookmarkViewWrapper1()
//                .previewLayout(.sizeThatFits)
//                .padding()
//        }
//    }
//    
//    struct BookmarkViewWrapper1: UIViewRepresentable {
//        
//        func makeUIView(context: Context) -> UIView {
//            let bookmarkViewController = SearchBarViewController(presenter: SearchBarViewPresenterImpl(networking: NewsRepository.shared, router: AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())))
//            
//            return bookmarkViewController.view
//        }
//        
//        func updateUIView(_ uiView: UIView, context: Context) {
//        }
//    }
//

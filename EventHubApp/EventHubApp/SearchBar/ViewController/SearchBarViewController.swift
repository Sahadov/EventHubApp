//
//  SearchBarViewController.swift
//  EventHubApp
//
//protocol SearchBarViewPresenter: AnyObject {
//    
//    func eventsCount() -> Int
//    func fetchEvents()
//    func didTapCell(at indexPath: IndexPath)
//}
//
//class SearchBarViewController: UIViewController {
//  
//    //MARK: - Properties
//    private let presenter: SearchBarViewPresenter
//    private var selectedEvent: Event
//    private var events : [Event] = ["onb1"]
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
//        table.register(SearchBarCell.self, forCellReuseIdentifier: SearchBarCell.reuseID)
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
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
//        label.numberOfLines = 1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private var titleLabelSmall: UILabel = {
//        let label = UILabel()
//        label.text = "Saved articles to the library"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
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
//        presenter.fetchEvents()
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
//        return events.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarCell.reuseID, for: indexPath) as? SearchBarCell else {
//            fatalError("Unable to dequeue BookmarkCell")
//        }
//        cell.set(info: events[indexPath.row])
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.didTapCell(at: indexPath.row, with: events)
//    }
//}
//

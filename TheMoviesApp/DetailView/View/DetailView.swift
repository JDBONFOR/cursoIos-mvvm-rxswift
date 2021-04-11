import UIKit
import RxSwift

class DetailView: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Vars
    private var viewModel = DetailViewViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - Vars
    var movieId: String?
    
    // MARK: - Navigator
    private var detailViewNavigator = DetailRouter()
    
    init(movieId: String) {
        self.movieId = movieId
        
        super.init(nibName: String(describing: DetailView.self), bundle: Bundle(for: DetailView.self))        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Register Cell
        tableView.register(UINib(nibName: "HeaderTitleCell", bundle: nil), forCellReuseIdentifier: "HeaderTitleCell")
        tableView.register(UINib(nibName: "MovieImageCell", bundle: nil), forCellReuseIdentifier: "MovieImageCell")
        tableView.register(UINib(nibName: "DataSectionCell", bundle: nil), forCellReuseIdentifier: "DataSectionCell")
        
        getDataAndShowDetailMovie()
        
        viewModel.bind(view: self, router: detailViewNavigator)
    }

}

// MARK: - Private Methods
extension DetailView {
    
    func getDataAndShowDetailMovie() {
        guard let movieId = movieId else { return }
        
        return viewModel.getDetailMovie(movieId: movieId)
            .subscribe(onNext: { movie in
                self.viewModel.setupUI(movie: movie)
            },
            onError: { error in
                print("Ha ocurrido un error \(error)")
            },
            onCompleted: {
                
            }).disposed(by: disposeBag)
    }
    
}

// MARK: - Extensions
extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.headerTitleCell.count
        } else if section == 1 {
            return viewModel.movieImageCell.count
        } else {
            return viewModel.dataCell.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleCell", for: indexPath) as? HeaderTitleCell else { return UITableViewCell() }
            let data = viewModel.headerTitleCell[indexPath.row]
            
            cell.setupCell(HeaderTitleCellViewModel(title: data.title))
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieImageCell", for: indexPath) as? MovieImageCell else { return UITableViewCell() }
            let data = viewModel.movieImageCell[indexPath.row]
            
            cell.setupCell(MovieImageCellViewModel(posterPath: data.posterPath))
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataSectionCell", for: indexPath) as? DataSectionCell else { return UITableViewCell() }
            let data = viewModel.dataCell[indexPath.row]
            
            cell.setupCell(DataSectionCellViewModel(title: data.title, description: data.description))
            return cell
            
        }
    }
    
    
}

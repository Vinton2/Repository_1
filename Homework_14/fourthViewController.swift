
import UIKit
import RealmSwift

class des: Object{
    @objc dynamic var descriptions = ""
}
class temp: Object{
    @objc dynamic var temperatures = ""
}

class fourthViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let Delegate = CategoriesLoader()
        Delegate.delegate = self
        Delegate.degreesDelegate = self
        Delegate.loadCategories2()
    }
}


extension fourthViewController: DescriptionLoaderDelegate{
    func loaded(categories: [String]) {
        for i in categories{
            try! realm.write{
                let task = des()
                task.descriptions = i
                realm.add(task)
            }
        }
        tableView.reloadData()
        print(categories)
    }
}

extension fourthViewController: DegreesLoaderDelegate{
    func degrees(degree: [String]) {
        for i in degree{
            try! realm.write{
                let task = temp()
                task.temperatures = i
                realm.add(task)
            }
        }
        tableView.reloadData()
        print(degree)
    }
}

extension fourthViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! firstTableViewCell
        let firstItems = self.realm.objects(des.self)
        let firstItem = firstItems[indexPath.row]
        let secondItems = self.realm.objects(temp.self)
        let secondItem = secondItems[indexPath.row]
        cell.descriptionLabel.text = firstItem.descriptions
        cell.degreeLabel.text = secondItem.temperatures
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = realm.objects(des.self)
        if items.count != 0{
            return 8
        }
        return 0
    }
}


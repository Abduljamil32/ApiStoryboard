import UIKit
import CoreLocation
import MapKit


class HomeViewController: UIViewController {

    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var FollowersCount: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    @IBOutlet weak var LoginView: UILabel!
    @IBOutlet weak var BioView: UILabel!
    @IBOutlet weak var Repos: UILabel!
    @IBOutlet weak var Location: UILabel!
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AllElements()
    }
    
    func AllElements(){
        getInfoFromServer { user in
            DispatchQueue.main.async { [self] in
                self.UserImageView.loadUrl(url: URL(string: user.avatar_url)!)
                self.UserImageView.layer.masksToBounds = true
                self.UserImageView.layer.cornerRadius = self.UserImageView.bounds.width / 3.5
                self.title = "@\(user.name)"
                self.FollowersCount.text = String(user.followers)
                self.FollowingCount.text = String(user.following)
                self.LoginView.text = user.login
                self.BioView.text = user.bio
                self.Repos.text = String(user.public_repos)
                self.Location.text = user.location
                self.getLocation(address: user.location) { location in
                    let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    Map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
                }
            }
        }
    }
    
    func getLocation(address: String, completion: ((CLLocation)->Void)? = nil){

            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
                }
                let result = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                completion?(result)
            }
    }
    
    func getInfoFromServer (completion: ((User)->Void)? = nil){
        
        guard let url = URL(string: "https://api.github.com/users/Abduljamil32") else {return}
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }else{
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("ERROR: Couldn't read response object")
                    return
                }
                guard response.statusCode == 200 else {
                    print("ERROR: Server responded status \(response.statusCode)")
                    return
                }

                let decoder = JSONDecoder()
                
                let usr = try! decoder.decode(User.self, from: data)
                
                completion?(usr)

            }
            
        }
        .resume()
    }
}

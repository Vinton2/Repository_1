import Foundation
import Alamofire

protocol DescriptionLoaderDelegate{
    func loaded(categories:[String])
}

protocol DegreesLoaderDelegate{
    func degrees(degree:[String])
}

struct DailyDescription: Decodable{
    let daily : [Course]?
}

struct Course: Decodable{
    let temp: Temp
    let weather:[Description]?
}

struct Temp: Decodable{
    let day: Float
}

struct Description: Decodable{
    let description: String
}

class CategoriesLoader{
    var delegate : DescriptionLoaderDelegate?
    var degreesDelegate : DegreesLoaderDelegate?
    let url = "https://api.openweathermap.org/data/2.5/onecall?lat=55.7522200&lon=37.6155600&exclude=hourly,current,minutely,alerts&appid=426f8cb9958dcf26b3b923abd7c7bc3f"
    var dayTemp: [String] = []
    var daydescription: [String] = []
    
    
    func loadCategories2(){
        AF.request(url).responseData { response in
            if let objects = response.value{
                do{
                    let dailydescription = try JSONDecoder().decode(DailyDescription.self, from: objects)
                    if let day = dailydescription.daily{
                        for d in day{
                            if let weath = d.weather{
                                for des in weath{
                                    self.daydescription.append(des.description)
                                }
                            }
                            let temp = d.temp
                            let celsiusDegrees = (String(format: "%.0f", temp.day - 273.15))
                            self.dayTemp.append("\(celsiusDegrees)°C")
                        }
                        }
                }
                catch let error{
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async{
                    self.delegate?.loaded(categories: self.daydescription)
                    self.degreesDelegate?.degrees(degree: self.dayTemp)
                }
            }
        }
    }
}

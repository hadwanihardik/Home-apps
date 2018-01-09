//
//  BoxOfficeViewController.swift
//  FandangoTest
//
//  Created by Hardik on 12/14/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
class BoxOfficeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,CustomLayoutDelegate {
   
    let reuseIdentifier = "MovieCell"
    let hAd = "HorizontalAdCollectionViewCell"
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!


    @IBOutlet weak var movieCollection: UICollectionView!
    var moviesData = [MovieDetails] ()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.readJson()

        self.cache = NSCache()
        session = URLSession.shared
        
        let ad1 = MovieDetails()
        ad1.height = 50
        ad1.width = movieCollection.frame.size.width

        let ad2 = MovieDetails()
        ad2.height = 460
        ad2.width = Utils.cellWidth

       
        

        if let layout = movieCollection?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
            movieCollection?.contentInset = UIEdgeInsets(top: 10, left: CGFloat(Utils.insets), bottom: 10, right: CGFloat(Utils.insets))

        }

       
       
        self.moviesData.insert(ad1, at: Utils.ad1Position)
        self.moviesData.insert(ad2, at: Utils.ad2Position)

        movieCollection.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        movieCollection.register(UINib(nibName: "HorizontalAdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: hAd)
        // Do any additional setup after loading the view.
    }
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "movies_fandangolatam", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    let dictionaryData:[String:Any] = object["data"] as! [String : Any]
                    let dataArray = dictionaryData["popularity"] as! [[String:Any]]
                    var index = 0
                    for data in dataArray
                    {
                        index =  index + 1
                        let movieDetail = MovieDetails()
                        movieDetail.name = (data["name"]  is NSNull) ? "" : data["name"] as! String
                        
                        let posterData:[String:Any] = (data["posterImage"]  is NSNull) ? ["":""] : data["posterImage"] as! [String : Any]
                      
                        movieDetail.posterImage = (posterData["url"]  is NSNull) ? "" : posterData["url"] as! String

                        if let tomatoRating = data["tomatoRating"] as? [String : Any]
                        {
                            let tomatoIconImage:[String:Any] = (tomatoRating["iconImage"]  is NSNull) ? ["":""] : tomatoRating["iconImage"]  as! [String : Any]
                            movieDetail.tomatoRating.iconImage = (tomatoIconImage["url"]  is NSNull) ? "" : tomatoIconImage["url"] as! String
                            movieDetail.tomatoRating.tomatometer = (tomatoRating["tomatometer"]  is NSNull) ? "" : String(describing:tomatoRating["tomatometer"]!)
                            movieDetail.tomatoRating.state = (tomatoRating["state"]  is NSNull) ? "" : tomatoRating["state"] as! String

                            movieDetail.tomatoRating.ratingCount = (tomatoRating["ratingCount"]  is NSNull) ? "" : String(describing:tomatoRating["ratingCount"]!)
                        }
                        
                        if let userRating = data["userRating"] as? [String : Any]
                        {
                            let userIconImage:[String:Any] = (userRating["iconImage"]  is NSNull) ? ["":""] : userRating["iconImage"]  as! [String : Any]
                            movieDetail.userRating.iconImage = (userIconImage["url"]  is NSNull) ? "" : userIconImage["url"] as! String
                            movieDetail.userRating.dtlWtsScore = (userRating["dtlWtsScore"] is NSNull) ? "" : String(describing:userRating["dtlWtsScore"]!)
                            movieDetail.userRating.dtlLikedScore = (userRating["dtlLikedScore"]  is NSNull) ? "" : String(describing:userRating["dtlLikedScore"]!)

                            movieDetail.userRating.state = (userRating["state"]  is NSNull) ? "" : userRating["state"] as! String
                            
                            movieDetail.userRating.ratingCount = (userRating["ratingCount"]  is NSNull) ? "" : String(describing:userRating["ratingCount"]!)
                          
                        }
                        
                        moviesData.append(movieDetail)

                    }

                    
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    //3
     func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == Utils.ad1Position || indexPath.row == Utils.ad2Position)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hAd, for: indexPath) as! HorizontalAdCollectionViewCell
            // Configure the cell
            
            return cell
        }
        else
        {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
            
//                cell.configureCell(moviedata: moviesData[indexPath.row])
            let moviedataDetails = moviesData[indexPath.row]
            cell.movieName.text = moviedataDetails.name
            cell.imvPosterImage.image = #imageLiteral(resourceName: "box_photo")
            if(moviedataDetails.tomatoRating.tomatometer != "")
            {
                cell.tomatoRating.text = moviedataDetails.tomatoRating.tomatometer! + "%"
                
            }
            
            if(moviedataDetails.userRating.dtlWtsScore == "")
            {
                cell.userRating.text = moviedataDetails.userRating.dtlLikedScore! + "%"
            }
            else
            {
                cell.userRating.text = moviedataDetails.userRating.dtlWtsScore + "%"
            }
            
            if let urlOFImage = moviedataDetails.posterImage
            {
                
                let mainurl = URL(string: (urlOFImage.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))!)
                
                if let url = mainurl
                {
                    cell.loader.startAnimating()

                    if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
                       
                        cell.loader.stopAnimating()
                        cell.imvPosterImage.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
                    }else{
                        task = session.downloadTask(with:url, completionHandler: { (location, response, error) -> Void in
                            if let data = try? Data(contentsOf: url){
                                DispatchQueue.main.async(execute: { () -> Void in
                                    if let updateCell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                                        let img:UIImage! = UIImage(data: data)
                                        updateCell.imvPosterImage?.image = img
                                        self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                                        cell.loader.stopAnimating()

                                    }
                                })
                            }
                        })
                        task.resume()
                    }
                }
                else
                {
                    cell.loader.stopAnimating()

                    cell.imvPosterImage.image = #imageLiteral(resourceName: "box_photo")
                }
            }
            else
            {
                cell.imvPosterImage.image = #imageLiteral(resourceName: "box_photo")
                cell.loader.stopAnimating()

            }
            
            if(moviedataDetails.tomatoRating.ratingCount == "" &&  moviedataDetails.userRating.dtlWtsScore == "")
            {
                cell.lblNoRatings.isHidden = false
            }
            else
            {
                cell.lblNoRatings.isHidden = true
                
                if let urlOfTomatoImage = moviedataDetails.tomatoRating.iconImage
                {
                    let mainurl = URL(string: (urlOfTomatoImage.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))!)
                    if mainurl != nil
                    {
                        if let url = mainurl
                        {
                            if (self.cache.object(forKey: urlOfTomatoImage as AnyObject) != nil){
                                
                                cell.tomatoIcon.image = self.cache.object(forKey: urlOfTomatoImage as AnyObject) as? UIImage//object(forKey: (urlOfTomatoImage as AnyObject) as! UIImage  //as? UIImage
                            }else{
                                task = session.downloadTask(with:url, completionHandler: { (location, response, error) -> Void in
                                    if let data = try? Data(contentsOf: url){
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            if let updateCell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                                                let img:UIImage! = UIImage(data: data)
                                                updateCell.tomatoIcon?.image = img
                                                self.cache.setObject(img, forKey: urlOfTomatoImage as AnyObject)
                                                
                                            }
                                        })
                                    }
                                })
                                task.resume()
                            }
                        }
                    }
                }
                if let urlOfUserImage = moviedataDetails.userRating.iconImage
                {
                    let mainurl = URL(string: (urlOfUserImage.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))!)
                    if mainurl != nil
                    {
                        if let url = mainurl
                        {
                            if (self.cache.object(forKey: urlOfUserImage as AnyObject) != nil){
                                
                                cell.userIcon.image = self.cache.object(forKey: urlOfUserImage as AnyObject) as? UIImage//object(forKey: (urlOfTomatoImage as AnyObject) as! UIImage  //as? UIImage
                            }else{
                                task = session.downloadTask(with:url, completionHandler: { (location, response, error) -> Void in
                                    if let data = try? Data(contentsOf: url){
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            if let updateCell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                                                let img:UIImage! = UIImage(data: data)
                                                updateCell.userIcon?.image = img
                                                self.cache.setObject(img, forKey: urlOfUserImage as AnyObject)
                                                
                                            }
                                        })
                                    }
                                })
                                task.resume()
                            }
                        }
                    }
                    
                }
            }

            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
        return CGSize(width: moviesData[indexPath.row].width, height: moviesData[indexPath.row].height)

    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(moviesData[indexPath.row])
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


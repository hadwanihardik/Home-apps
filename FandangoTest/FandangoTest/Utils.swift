//
//  Utils.swift
//  FandangoTest
//
//  Created by Hardik on 12/14/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit



class Utils: NSObject {
    
    static var appBaseColor = UIColor.init(colorLiteralRed: 45/255.9, green: 114/255.0, blue: 175/255.0, alpha: 1)
    static var cellWidth : CGFloat = (Display.typeIsLike == .iphone7plus) ? 135 :  140 ;
    static var ad1Position = (Display.typeIsLike == .iphone6) ? 4 : 3 ;
    static var ad2Position = (Display.typeIsLike == .iphone7plus) ? 6  : 6;
    static var insets = (Display.typeIsLike == .iphone7plus) ? 0  : 10;

}
let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
    
}


public enum DisplayType {
    case unknown
    case iphone4
    case iphone5
    case iphone6
    case iphone6plus
    static let iphone7 = iphone6
    static let iphone7plus = iphone6plus
    case iphoneX
}

public final class Display {
    class var width:CGFloat { return UIScreen.main.bounds.size.width }
    class var height:CGFloat { return UIScreen.main.bounds.size.height }
    class var maxLength:CGFloat { return max(width, height) }
    class var minLength:CGFloat { return min(width, height) }
    class var zoomed:Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var retina:Bool { return UIScreen.main.scale >= 2.0 }
    class var phone:Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    class var pad:Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    class var carplay:Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
    class var tv:Bool { return UIDevice.current.userInterfaceIdiom == .tv }
    class var typeIsLike:DisplayType {
        if phone && maxLength < 568 {
            return .iphone4
        }
        else if phone && maxLength == 568 {
            return .iphone5
        }
        else if phone && maxLength == 667 {
            return .iphone6
        }
        else if phone && maxLength == 736 {
            return .iphone6plus
        }
        else if phone && maxLength == 812 {
            return .iphoneX
        }
        return .unknown
    }
}



class MovieDetails: NSObject {
    
    var name : String!
    var posterImage: String!
    var tomatoRating: TomatoRatings!
    var userRating: UserRating!
    var height: CGFloat!
    var width: CGFloat!
    override init() {
        name = ""
        posterImage = ""
        height = 220
        width = Utils.cellWidth//(Display.typeIsLike == .iphone7plus) ? 140 :  140
        tomatoRating = TomatoRatings()
        userRating = UserRating()
    }
}
class TomatoRatings: NSObject {
    
    var iconImage : String!
    var state: String!
    var tomatometer: String!
    var ratingCount: String!
    override init() {
        iconImage = ""
        state = ""
        tomatometer = ""
        ratingCount = ""
    }
}
class UserRating: NSObject {
    
    var iconImage : String!
    var state: String!
    var dtlLikedScore: String!
    var dtlWtsScore: String!
    var ratingCount: String!
    
    override init() {
        iconImage = ""
        state = ""
        dtlLikedScore = ""
        dtlWtsScore = ""
        ratingCount = ""
    }
}
 

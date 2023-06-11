import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.italicSystemFont(ofSize: size)
    }
    
    static func montseratMedium(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Medium", size: size)
    }
    
    static func montseratRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Regular", size: size)
    }
    
    static func montseratSemiBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-SemiBold", size: size)
    }
    
    static func robotoBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Roboto-Bold", size: size)
    }
    
    static func robotoMedium(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Roboto-Medium", size: size)
    }
    
    static func robotoRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Roboto-Regular", size: size)
    }
}

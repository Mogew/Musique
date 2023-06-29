import UIKit

struct ProfileSection {
    let title: String
    let options: [ProfileModel]
}

struct ProfileModel {
    let text: String
    let image: UIImage
    let rightImage: UIImage?
    let toggleIsHidden: Bool
}

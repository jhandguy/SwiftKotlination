import UIKit

extension UIImage {
    func resize(width: Int, height: Int, _ completion: (UIImage) -> Void) {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        draw(in: rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            completion(image)
        }
        
        UIGraphicsEndImageContext()
    }
}

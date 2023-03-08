//
//  UIView+Extension.swift
//  YoutubeClone
//
//  Created by mert can çifter on 16.02.2023.
//

import UIKit

extension UIImage {

    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

}


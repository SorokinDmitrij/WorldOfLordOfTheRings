//
//  UIFont+Extensions.swift
//  WorldOfLordOfTheRings
//
//  Created by mac on 22.11.2024.
//

import UIKit
extension UIFont {
    enum Edu {
        enum bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Edu.bold, size: size)!
            }
        }
        enum semibold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Edu.semiBold, size: size)!
            }
        }
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Edu.medium, size: size)!
            }
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Edu.regular, size: size)!
            }
        }
    }
    enum Sevillana {
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Edu.regular, size: size)!
            }
        }
    }
}
private extension UIFont {
    enum Constans {
        enum Sevillana {
            static let regular = "Sevillana-Regular"
        }
        enum Edu {
            static let bold = "EduAUVICWANTArrows-Bold"
            static let semiBold = "EduAUVICWANTArrows-SemiBold"
            static let medium = "EduAUVICWANTArrows-Medium"
            static let regular = "EduAUVICWANTArrows-Regular"
        }
    }
}

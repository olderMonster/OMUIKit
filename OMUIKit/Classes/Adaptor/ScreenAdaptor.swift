//
//  Fit.swift
//  TimeLine
//
//  Created by 印聪 on 2023/2/20.
//

import UIKit

public extension CGFloat {
    var fit: CGFloat { self * ScreenAdaptor.ratio }
}

public extension Int {
    var fit: CGFloat { CGFloat(self) * ScreenAdaptor.ratio }
}


public struct ScreenAdaptor {
    private(set) static var ratio = UIScreen.main.bounds.width / 375.0
    static func setup(width: CGFloat) {
        guard width > 0 else { return }
        ratio = UIScreen.main.bounds.width / width
    }
}

//
//  Traiangle.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import SwiftUI

/// 三角のShape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct TraiangleView_Previews: PreviewProvider {
    static var previews: some View {
        Triangle()
            .fill(Color.red)
            //.stroke(Color.red,lineWidth: 10)
            .frame(width: 100, height: 100)
    }
}

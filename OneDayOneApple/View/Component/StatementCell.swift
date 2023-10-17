//
//  StatementCell.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import SwiftUI

struct StatementCell: View {
    let dataManager = DataManager()
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(dataManager.convertAttributedString(from: text))
            /// 요렇게 쓰면 더 읽기 편할 거 같아요
            /// .padding(.vertical, 5)
            /// .padding(.horizontal, 20)
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(1)
                .opacity(0.1)
        }
    }
}

struct StatementCell_Previews: PreviewProvider {
    static var previews: some View {
        StatementCell(text: "The values that operators affect are *operands*. In the expression `1 + 2`, the `+` symbol is an infix operator and its two operands are the values `1` and `2`.")
    }
}

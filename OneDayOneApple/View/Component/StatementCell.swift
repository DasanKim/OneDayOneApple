//
//  StatementCell.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import SwiftUI

struct StatementCell: View {
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(5)
                .opacity(0.4)
        }
    }
}

struct StatementCell_Previews: PreviewProvider {
    static var previews: some View {
        StatementCell(text: "contentasdfasdfasdfasfdasdfajskldjfhaskljdfhklasjdfhlkajsdfklasjdfhklasjfh")
    }
}

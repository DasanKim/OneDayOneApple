//
//  HeaderView.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subTitle: String?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 0))
                    
                    Spacer()
                }
                HStack {
                    Text(subTitle ?? "")
                        .foregroundColor(.gray)
                        .font(.title2)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                    Spacer()
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Today One Apple", subTitle: "SubTitle")
    }
}

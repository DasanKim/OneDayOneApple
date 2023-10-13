//
//  ContentView.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/13.
//

import SwiftUI

struct DataDummy {
    static let markdownText: String = "# Access Control"
}

//노랑: Color(red: 254/255, green: 175/255, blue: 115/255)
//빨강: Color(red: 214/255, green: 78/255, blue: 83/255)
//초록: Color(red: 0/255, green: 106/255, blue: 85/255)
//아주 연한 초록: Color(red: 231/255, green: 238/255, blue: 231/255)

struct ContentView: View {
    let openAIService = OpenAIService(baseURL: Constants.OpenAIBaseURL, endpoint: Constants.OpenAIEndpoint)
    var text: String = "Access control 를 한국어로 번역해줘."
    @State var translatedText: String = ""
    @State var translatedTextList = [String]()
    @State var isTranslate: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 231/255, green: 238/255, blue: 231/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 2) {
                Rectangle()
                    .fill(Color(red: 0/255, green: 106/255, blue: 85/255))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 50)
                    .overlay {
                        Text("Today Apple🍎")
                            .bold()
                            .foregroundColor(.white)
                            .padding(8)
                    }
                Text("Access Control")
                    .font(.title)
                    .padding(5)
                List {
                    Text(
"""
 *Access control* restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
"""
                    )
                    .onTapGesture {
                        translate()
                        isTranslate.toggle()
                    }
                    if isTranslate {
//                        Text(
//"""
//*액세스 제어*는 다른 소스 파일 및 모듈의 코드에서 코드의 일부에 대한 액세스를 제한합니다. 이 기능을 사용하면 코드의 구현 세부 정보를 숨기고 해당 코드에 액세스하고 사용할 수 있는 우선 인터페이스를 지정할 수 있습니다.
//"""
//                        )
                        Text(translatedText)
                        .animation(.easeIn(duration: 1))
                    }
                }
                .listStyle(.inset)
            }
            .task {
                
            }
        }
    }
    
    func translate() {
        openAIService.sendMessage(message: text) { result in
            switch result {
            case .success(let response):
//                DispatchQueue.main.async {
//                    translatedText = response.choices.first?.text ?? ""
//                }
                translatedText = response.choices.first?.text ?? ""
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SectionView.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import SwiftUI

struct SectionView: View {
    let openAIService = OpenAIService(baseURL: Constants.OpenAIBaseURL, endpoint: Constants.OpenAIEndpoint)
    var text: String = """
 *Access control* restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
"""
    @State var translatedText: String = ""
    @State var translatedTextList = [String]()
    @State var isTranslate: Bool = false
    @Binding var section: Section
    
    var body: some View {
        VStack {
            HeaderView(subTitle: section.title)
                .frame(height: 150)
            
            ScrollView {
                VStack(spacing: 0) {
                    StatementCell(text: text)
                        .onTapGesture {
                            translate()
                            isTranslate.toggle()
                        }
                    if isTranslate {
                        StatementCell(text: "번역됨")
                        //StatementCell(text: translatedText)
                    }
                    Button("COMPLETE!") {
                        section.isComplete = true
                    }
                }
            }
        }
    }
    
    func translate() {
        openAIService.sendMessage(message: text) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    translatedText = response.choices.first?.text ?? ""
                }
                //translatedText = response.choices.first?.text ?? ""
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: .constant(Section(title: "Title", isComplete: true)))
    }
}

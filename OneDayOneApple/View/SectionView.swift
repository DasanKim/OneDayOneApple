//
//  SectionView.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import SwiftUI

struct SectionView: View {
    @Environment(\.dismiss) private var dismiss
    let openAIService = OpenAIService(baseURL: Constants.openAIBaseURL, endpoint: Constants.openAIEndpoint)
    let chapterTitle: String
    @Binding var section: Section
    
    var body: some View {
        VStack {
            HeaderView(title: chapterTitle, subTitle: section.title)
                .frame(height: 150)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach($section.paragraphs, id: \.id) { $paragraph in
                        StatementCell(text: paragraph.text)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    translate(paragraph: paragraph)
                                    paragraph.translatedTextShowing.toggle()
                                }
                            }
                        if paragraph.translatedTextShowing {
                            StatementCell(text: paragraph.translatedText ?? "")
                        }
                    }
                    
                    if section.title != "Overview" {
                        Button("COMPLETE !") {
                            section.isComplete.toggle()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
        }
    }
    
    func translate(paragraph: Paragraph) {
        guard let index = section.paragraphs.firstIndex(where: {$0.id == paragraph.id}) else {
            return
        }
        
        openAIService.sendMessage(message: paragraph.text) { result in
            switch result {
            case .success(let response):
                var responseText = response.choices.first?.text ?? ""
                if responseText.hasPrefix("\n") {
                    responseText = responseText.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
                }
                section.paragraphs[index].translatedText = responseText
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(chapterTitle: "ChapterTitle", section: .constant(DataManager().fetchChapters()[1].sections[1]))
    }
}

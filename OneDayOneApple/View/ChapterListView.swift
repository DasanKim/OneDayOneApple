//
//  ChapterListView.swift
//  OneDayOneApple
//
//  Created by Daasn on 2023/10/14.
//

import SwiftUI

struct ChapterListView: View {
    /// SwiftUI에서 @State가 어떻게 동작하는지 알고 계실까요?
    /// struct임에도 불구하고, 프로퍼티가 변경되었을 때 어떻게 메모리를 유지하고 있는지
    /// 언제 let을 쓰고 언제 @State var를 쓰는지
    /// @ObservedObject와 같은 아이들을 썼을 때랑 차이점
    /// 뷰가 언제 rerendering되는지
    /// 
    /// 등등 나올 수 있는 질문이 산더미입니다
    @State var chapters: [Chapter] = DataManager().fetchChapters()
    @State var selectedSection: Section = Section(title: "", paragraphs: [], isComplete: false)
    
    var body: some View {
        /// 네비게이션 뷰 + 네비게이션 링크에는 OS버그가 상당히 많아서 deprecated된거로 알고있는데,
        /// iOS15를 타겟으로 잡으신 이유
        /// 버그가 있을 때 어떻게 해결할 수 있을지
        /// NavigationStack은 사용해봤는지
        NavigationView {
            VStack {
                HeaderView(title: "Today One Apple", subTitle: nil)
                    .frame(height: 150)
                /// 인덴트가 너무 깊어용
                /// 
                /// private var list: some View { ... }
                /// struct SubView: View { ... }
                /// 이런 식으로 뷰를 최대한 쪼개주세요
                /// 
                /// 이렇게 했을 때 얻는 장단점도 공부해주세요
                /// eg. explicit identity, structural identity, 뷰의 디펜던시가 변경됐을 때 어떻게 다시 그리는지
                /// 
                /// List vs ScrollView+VStack vs Grid
                List {
                    ForEach($chapters, id: \.id) { $chapter in
                        DisclosureGroup {
                            NavigationLink {
                                SectionView(chapterTitle: chapter.title, section: $chapter.overview)
                            } label: {
                                Label("Overview", systemImage: "doc.plaintext")
                            }
                            ForEach($chapter.sections, id: \.id) { $section in
                                NavigationLink {
                                    SectionView(chapterTitle: chapter.title, section: $selectedSection)
                                        .onAppear {
                                            selectedSection = section
                                        }
                                        .onDisappear {
                                            /// 요 API도 deprecated되었어요
                                            withAnimation {
                                                updateSection(section.id)
                                            }
                                        }
                                } label: {
                                    Label(section.title, systemImage: section.isComplete ? "checkmark.circle.fill" : "circle")
                                }
                            }
                        } label: {
                            Label(chapter.title, systemImage: chapter.isComplete ? "seal.fill" : "seal")
                                .contentShape(Rectangle())
                        }
                    }
                }
                .listStyle(.inset)
            }
        }
    }
    
    func updateSection(_ id: UUID) {
        var chapterIndex = 0
        for chapter in chapters {
            if let index = chapter.sections.firstIndex(where: {$0.id == id}) {
                chapters[chapterIndex].sections[index].isComplete = selectedSection.isComplete
            }
            chapterIndex += 1
        }
    }
}

struct ChapterListView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListView()
    }
}

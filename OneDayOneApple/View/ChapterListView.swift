//
//  ChapterListView.swift
//  OneDayOneApple
//
//  Created by Daasn on 2023/10/14.
//

import SwiftUI

struct ChapterListView: View {
    @State var chapters: [Chapter] = DataManager().fetchMarkdownFile()
    @State var selectedSection: Section = Section(title: "", paragraphs: [], isComplete: false)
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Today One Apple", subTitle: nil)
                    .frame(height: 150)
                List {
                    ForEach(chapters, id: \.id) { chapter in
                        DisclosureGroup {
                            NavigationLink {
                                SectionView(chapterTitle: chapter.title, section: $selectedSection)
                                    .onAppear {
                                        selectedSection = chapter.overview
                                    }
                                    .onDisappear {
                                        withAnimation {
                                            updateSection(chapter.overview.id)
                                        }
                                    }
                            } label: {
                                Label {
                                    Text("Overview")
                                } icon: {
                                    Image(systemName: chapter.overview.isComplete ? "checkmark.circle.fill" : "circle")
                                }
                            }
                            ForEach(chapter.sections, id: \.id) { section in
                                NavigationLink {
                                    SectionView(chapterTitle: chapter.title, section: $selectedSection)
                                        .onAppear {
                                            selectedSection = section
                                        }
                                        .onDisappear {
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

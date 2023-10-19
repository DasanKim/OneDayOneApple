# 🍎 One Day One Apple

- 프로젝트 기간: [2023년 10월 9일 ~ 10월 17일]()
- 프로젝트 개발자: [Dasan🌳](https://github.com/DasanKim)

---

## 📖 목차
- 🍀 [소개](#소개) </br>
- 💻 [실행 화면](#실행_화면) </br>
- 🛠️ [사용 기술](#사용_기술) </br>
- 🤔 [고민했던 점](#고민했던_점) </br>
- 🧨 [트러블 슈팅](#트러블_슈팅) </br>
- 📚 [참고 링크](#참고_링크) </br>
- 👩‍💻 [about Me](#about_Me) </br>

</br>

## 🍀 소개<a id="소개"></a>
- [Swift Programming Language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/) 원문을 Chat GPT가 번역해줄 수 있는 Swift 공부 지원 앱입니다.
- 주요 기능
    - Chat GTP API를 활용한 실시간 번역 제공
    - .md 파일을 문단 단위로 parsing
    - Markdown이 적용된 텍스트(Markdownosaur 외부 라이브러리 사용)

</br>

## 💻 실행 화면<a id="실행_화면"></a>

| 리스트 화면 | COMPLETE 클릭시 |
| :--------: | :--------: |
| <img src = "https://github.com/DasanKim/OneDayOneApple/assets/106504779/e096a95a-fc2c-40cc-8469-b3c794c26c37" width = "300"> | <img src = "https://github.com/DasanKim/OneDayOneApple/assets/106504779/7c8e405d-cf17-433e-a96f-287fcaf2f282"  width = "300"> |

| 문단 단위 번역 | 번역을 막아둔 heading와 code block |
| :--------: | :--------: |
| <img src = "https://github.com/DasanKim/OneDayOneApple/assets/106504779/495b7643-f6e8-46bf-8691-fc1a2fb7dae4" width = "300"> | <img src = "https://github.com/DasanKim/OneDayOneApple/assets/106504779/75a06d4c-6bbc-4f68-a23d-5b680a58980f"  width = "300"> |

</br>

## 🛠️ 사용 기술<a id="사용_기술"></a>
|분류|기술스택|
|:--:|:--:|
|사용 API|Chat GPT(OpenAI) API|
|UI|SwiftUI|
|Architecture|~~MVVM~~|
|Concurrency|DispatchQueue|
|Dependency Manager|SPM|

</br>

## 🤔 고민했던 점<a id="고민했던_점"></a>
### 1️⃣ Swift Programming Language 데이터 가져오기
1. 🔹 크롤링
    - `크롤링(crawling)`: 웹 페이지를 그대로 가져와서 거기서 HTML/CSS등을 파싱하고, 필요한 데이터만 추출하는 기법
    - Swift Soup를 사용하여 [Swift Programming Language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/) 웹페이지를 크롤링하려고 하였으나, 필요한 데이터가 html이 아닌 html 요소가 잘게 parsing된 json으로 되어 있어 다른 방법을 모색하였습니다.
2. 🔹 .md 파일 Parsing
    - https://github.com/apple/swift-book 에서 위의 내용을 .md(Markdown)파일로 제공하고 있다는 것을 알게되었습니다.
    - 이에 크롤링 대신 .md파일을 파싱하는 것으로 데이터를 추출하기로 하였습니다.

### 2️⃣ Markdown으로 작성된 텍스트 출력
- 🔹 SwiftUI 3.0부터 **Markdown 지원**
    - [WWDC2021](https://developer.apple.com/videos/play/wwdc2021/10018/)에서 SwiftUI의 새로운 기능으로 `Markdown 지원`이 발표되었습니다.(iOS 15 이상) 
    - Swift 기반 AttributedString을 기반으로 구축된 Markdown을 SwiftUI에서 사용할 수 있다는 사실을 알고, 위에서 파싱한 텍스트는 이미 Markdown 문법으로 작성되어 있으므로 바로 적용해보았습니다.
    - SwiftUI Markdown는 아래를 지원합니다.
        - Bold
        - Italic
        - Strikethrough
        - Inline code
        - Link

    <details>
        <summary> 예시보기 </summary>

    |<img src="https://hackmd.io/_uploads/HJIg7nCZp.png" width="600">|
    |:--:|
    |<img src="https://hackmd.io/_uploads/ByydX2RWp.png" width="600">|
    
    </details>

- 🔹 현재 SwiftUI Markdown의 **한계**
    - 하지만 아래에서 볼 수 있듯이 아직 모든 Markdown이 적용되지 않아, Blockquotes, List 등의 적용이 필요했던 저로써는 SwiftUI Markdown만으로는 원하는 결과물을 얻을 수 없었습니다.

    <details>
        <summary> 예시보기 </summary>

    |<img src="https://hackmd.io/_uploads/Bk3-V3Cba.png" width="600">|
    |:--:|
    |<img src="https://hackmd.io/_uploads/BysGNnCZ6.png" width="600">|
    
    </details>



- 🔹 이에 더 많은 Markdown 문법을 지원해주는 **외부 라이브러리 [Markdownosaur](https://github.com/christianselig/Markdownosaur)를 설치**하여 위 한계를 극복하였습니다.

### 3️⃣ Chat GPT API Model 선택
- Chat GPT API(OpenAI API)는 기능과 가격대에 따라 `다양한 Model`를 제공합니다.
- OpenAI API 홈페이지의 [Playground](https://platform.openai.com/playground)에서 몇몇 모델을 테스트해본 후, 번역 결과가 괜찮았던 모델들을 아래와 같이 추려보았습니다.
    1. GPT-3.5의 text-davinci-003
        - 번역 결과가 괜찮으나, shotdown data 날짜가 2024년 1월 4일임
    2. GPT-3.5의 gpt-3.5-turbo-instruct
        - text-davinci-003와 유사한 기능을 제공하면서 상대적으로 가격이 저렴함
    3. GPT-3.5의 gpt-3.5-turbo
    4. GPT-4.0의 gpt-4
        - 3, 4번은 최신 버전이고 번역 결과가 더 좋았지만, 그만큼 비용이 더 발생
- 🔹 Chat GPT API는 user와 assistant가 주고받는 token에 따라 가격이 측정되기 때문에, 비용을 생각하지 않을 수 없었습니다. 따라서 가격이 저렴하면서 성능이 괜찮은 "gpt-3.5-turbo-instruct"를 선택하여 프로젝트를 진행하였습니다.

</br>

## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>

### 1️⃣ Chat GPT API 
🚨 **문제점** <br>
1. 해당 Model url로 Request를 POST하여도 Chat GPT의 응답이 없는 문제가 발생하였습니다.
2. Chat GPT의 응답이 잘려서 오는 문제가 발생하였습니다.

💡 **해결방법** <br>
1. OpenAI 홈페이지에서 결제할 수 있는 `카드를 등록`하였더니 API가 정상적으로 응답을 하였습니다.
2. Requset 시, Body에 `max_tokens` 값을 따로 설정하지 않으면 `16으로 기본값이 설정`되어 있기 때문에 발생하는 문제였습니다. 따라서 max_tokens의 값을 400으로 넉넉하게 잡아주었더니 더 이상 응답이 잘리지 않았습니다.
    <img src="https://github.com/DasanKim/OneDayOneApple/assets/106504779/d9dd41dd-ac49-4a4d-a421-a82a136abd34">

<br>


## 📚 참고 링크<a id="참고_링크"></a>
- [OpenAI: API reference](https://platform.openai.com/docs/api-reference/completions/create)
- [🍏WWDC: What's new in SwiftUI](https://developer.apple.com/videos/play/wwdc2021/10018/)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Apple Swift-Markdown](https://github.com/apple/swift-markdown)
- <Img src = "https://github.com/WhalesJin/ios-bank-manager/assets/124643545/d1df2d8a-6667-438d-9643-aab8a83a4754" width="20"/> [Markdownosaur](https://github.com/christianselig/Markdownosaur)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: OpenAI ChatGPT API 사용: 가격, API 발급, 사용량 보기](https://dobiho.com/64241/)
- <Img src = "https://hackmd.io/_uploads/ByTEsGUv3.png" width="20"/> [blog: SwiftUI Markdown 사용에 대한 3가지 특이점](https://phillip5094.tistory.com/22)

<br>

---

## 👩‍💻 about Me<a id="about_Me"></a>

| <Img src = "https://user-images.githubusercontent.com/106504779/253477235-ca103b42-8938-447f-9381-29d0bcf55cac.jpeg" width="100"> | 🌳Dasan🌳  | https://github.com/DasanKim |
| :--------: | :--------: | :--------: |

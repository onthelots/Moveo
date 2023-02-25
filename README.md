# Moveo 🏆

## 앱 정의(ADS)
### 앱의 소개

```
동기부여를 위한 경험 공유 SNS
```
<br>

### 주된 페르소나
```
자기계발 경험을 공유하고 다른 사람의 건강한 삶을 보며 동기부여를 받고 싶은 사람
```
<br>

### 페르소나의 특징
```
- 목표를 정해서 달성하고 싶지만 의지가 부족한 사람
- 내 활동에 대해 타인의 피드백을 받고 싶은 사람
- 자기계발 과정을 기록으로 남기고 싶은 사람
- 평소 아무 생각없이 sns에 많은 시간을 사용하지만 이 시간이 아깝다고 생각하는 사람
```
<br>

## 사용자 가이드
#### 현재 기능에 이슈로 인해 뷰가 정상적으로 출력이 안되는 경우가 있습니다. 그럴 경우 다른 뷰로 갔다가 다시 가면 정상적인 화면을 볼 수 있습니다.
<br>

![loginView](https://user-images.githubusercontent.com/111134273/208884245-54e551f7-d69a-4100-b3af-f5f9e9387658.png)
- 로그인 및 회원가입
```
- 회원가입 버튼을 눌러 회원가입 뷰로 이동할 수 있으면 프로필사진, 한줄소개, 관심있는 카테고리, 회원 정보를 입력하고 회원가입을 진행할 수 있습니다.
- 회원가입을 한 아이디로 로그인을 할 수 있습니다.
```
<br>

![mainView](https://user-images.githubusercontent.com/111134273/208884590-fec83534-5680-4246-83bd-d8654dcada08.png)
- 홈 화면
```
- 홈 화면은 일정관리 및 인증 현황을 볼 수 있는 뷰입니다.
- 일정 추가를 눌러 일정을 추가할 수 있으며, 현재에는 캘린더에 일정이 추가됩니다.
- 추후 일정을 요일 반복으로 추가할 수 있고, 사용자가 인증글을 올리면 캘린더에 인증사진이 표시될 수 있도록 기능을 추가할 예정입니다.
- 그래프를 통해 이달의 목표 및 진행상황을 한눈에 파악할 수 있도록 추가할 예정입니다.
```
<br>

![feedView](https://user-images.githubusercontent.com/111134273/208885450-e187b612-2088-4423-a885-36040a757f5d.png)
- 피드 화면
```
- 우측 상단 +버튼을 눌러서 글을 추가할 수 있습니다.
- 게시글 우측 상단 북마크 모양을 눌러 북마크된 피드를 따로 모아볼 수 있습니다(프로필뷰)
- 댓글모양을 눌러 댓글창으로 이동해서 댓글을 주고받을 수 있습니다.
- 다른 사람의 프로필사진이나 닉네임을 눌러 해당 유저의 프로필을 볼 수 있습니다.
- 추후 내가 팔로우 한 사람의 피드들만 나타나도록 변경할 예정입니다.
```
<br>

![searchView](https://user-images.githubusercontent.com/111134273/208888752-7a4b2c07-0bbc-431b-b752-f70f6f0fef67.png)
- 찾기 화면
```
- 검색창에 닉네임을 검색해 해당 유저가 적은 피드들만 볼 수 있습니다.
- 아이콘을 눌러 해당 카테고리의 글만 볼 수 있습니다(현재 아이콘만 표기되어있지만 추후 아이콘 아래에 무슨 카테고리인지 적을 예정입니다.)
- 현재에는 꼭 카테고리를 눌러 카테고리별로 보는 것만 되지만 추후 전체보기 또한 넣을 예정입니다.
- 사진을 누르면 해당 글을 쓴 유저의 피드들만 볼 수 있도록 할 예정입니다.(현재도 작동은 하지만 기능적 문제로 정확하게 해당 유저의 피드들만 나타나진 않습니다.)
```
<br>

![profileView](https://user-images.githubusercontent.com/111134273/208889006-56e23ed8-b5d1-46e1-83ca-277fb94d392a.png)
- 프로필 화면
```
- 자신의 정보들을 확인할 수 있습니다.
- 카테고리를 눌러 선택한 카테고리의 피드들만 모아볼 수 있습니다.
- Motivators를 통해 다른 사람을 팔로우할 수 있습니다.
- 북마크한 피드들만 모아볼 수 있습니다.
- 우측 상단에 햄버거 모양을 눌러 로그아웃할 수 있습니다.
- 추후 개선을 통해 어떤 사람들이 팔로우하고 팔로잉되었는지를 볼 수 있도록 할 예정입니다.
```
<br>

### 차별성
```
- 인스타그램을 타깃앱으로 하고있어 대부분의 뷰가 인스타그램과 거의 유사합니다.
- 다만 알림기능과 일정관리기능을 강화해서 주 기능으로 만들고 해당부분으로 차별성을 줄 예정입니다.
```
<br>

## 📲 실행 가이드 및 설치 방법(How to build)
### 공통
- 다음 파일은 Build를 위한 필수 파일입니다. 
- Build를 희망하실 경우, onthelots@naver.com으로 문의 부탁드립니다. 
```
GoogleService-Info.plist
```

### 설치 및 실행방법
- Firebase 활용을 위한 Target 세팅

```
Bundle ID : com.codelion.Moveo
```

- Package 설치

```
Firebase(총 4개) : FirebaseAuth, FirebaseStorage, FirebaseFirestore, FirebaseFirestoreSwift
```

```
SDWebImageSwiftUI : https://github.com/SDWebImage/SDWebImage (직접 설치)
```
<br>

## ⚙️ 개발 환경
- iOS 16.0 이상
- iPhone 14 Pro에서 최적화됨
- 가로모드 미지원, 다크모드 미지원

<br>

## 👨‍👩‍👧‍👦 참여자
#### 진준호, 이종현, 전근섭, 임재혁, 기태욱

<br>

## 🔖License(라이센스)
Moveo is available under the MIT license. See the LICENSE file for more info.

- SDWebImage(https://github.com/SDWebImage/SDWebImage)

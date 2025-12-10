# SketchApp

> PencilKit을 활용한 드로잉 앱

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-14.0+-lightgrey.svg)](https://www.apple.com/ios/)

---

## 스크린샷

| <img width="779" height="1096" alt="스크린샷 2025-12-10 오후 4 24 48" src="https://github.com/user-attachments/assets/165caf56-b1f0-4861-8908-bf8da8b90171" /> | <img width="779" height="1096" alt="스크린샷 2025-12-10 오후 4 13 01" src="https://github.com/user-attachments/assets/156c19e0-33f9-4ba3-b8f6-e2df57ef5064" /> | <img width="779" height="1096" alt="스크린샷 2025-12-10 오후 4 16 38" src="https://github.com/user-attachments/assets/c51d3155-038a-4b8d-8f54-3efd85b5cd26" /> |
| :----------------------------------: | :----------------------------------: | :----------------------------------: |

---

## 프로젝트 소개

Apple의 PencilKit 프레임워크를 학습하기 위해 제작한 간단한 드로잉 앱입니다.

**제작 기간**: 2021년 7월 10일 ~ 12일 (약 3일)
**제작 목적**: PencilKit 프레임워크 학습 및 Apple Pencil 활용 경험

---

## 주요 기능

### 드로잉 도구
- 펜 (Pen) - 선 그리기
- 마커 (Marker) - 반투명 하이라이터
- 올가미 도구 (Lasso) - 선택 및 이동
- 지우개 (Eraser) - 비트맵 지우개

### 색상 선택
8가지 색상 지원:
- Primary (커스텀 색상)
- Blue, Red, Orange, Green, Purple, Yellow, Pink

### 그림 관리
- 저장 (Save) - Core Data에 드로잉 데이터 저장
- 불러오기 (Load) - 저장된 드로잉 목록 보기 및 불러오기
- Undo / Redo - 작업 취소 및 재실행
- 이미지 추가 (Add) - 사진 라이브러리에서 이미지 가져와 배경으로 삽입

---

## 기술 스택

### 프레임워크
- **PencilKit** - Apple의 드로잉 프레임워크
  - PKCanvasView - 드로잉 캔버스
  - PKInkingTool - 펜/마커 도구
  - PKLassoTool - 선택 도구
  - PKEraserTool - 지우개
  - PKDrawing - 드로잉 데이터 모델

- **Core Data** - 드로잉 영구 저장
  - DrawingEntity - 드로잉 데이터 및 저장 시간

- **PhotosUI** - 사진 라이브러리 접근
  - PHPickerViewController - 이미지 선택

### 라이브러리
- **SnapKit 5.0** - AutoLayout DSL

### 아키텍처
- **UIKit 기반**
- **MVC 패턴**
- 코드 기반 UI 구성

---

## 프로젝트 구조

```
SketchApp/
├── View/
│   ├── SketchViewController.swift    # 메인 드로잉 화면
│   ├── DrawingListViewController.swift  # 저장된 드로잉 목록
│   ├── DrawingCell.swift              # 드로잉 썸네일 셀
│   └── ToolButton.swift               # 툴바 버튼
├── Model/
│   ├── DrawingModel.swift             # 드로잉 데이터 모델
│   └── CoreDataManager.swift          # Core Data CRUD
├── ColorType.swift                    # 색상 타입 Enum
├── Loadable.swift                     # 드로잉 로드 프로토콜
├── DrawingEntity+CoreData.swift       # Core Data Entity
└── AppDelegate.swift
```

---

## 주요 구현 사항

### 1. PencilKit 도구 설정

```swift
var pen = PKInkingTool(.pen, color: ColorType.primary.color, width: 5)
var marker = PKInkingTool(.marker, color: ColorType.primary.color, width: 20)
var lasso = PKLassoTool()
var eraser = PKEraserTool(.bitmap)
```

### 2. Core Data 저장 및 로드

**저장:**
```swift
let drawingData = canvasView.drawing.dataRepresentation()
CoreDataManager.shared.save(withData: drawingData)
```

**불러오기:**
```swift
let drawings = CoreDataManager.shared.load()
let drawing = try? PKDrawing(data: drawingData)
canvasView.drawing = drawing
```

### 3. Undo/Redo 구현

```swift
canvasView.undoManager?.undo()
canvasView.undoManager?.redo()
```

### 4. 이미지 배경 삽입

PHPickerViewController를 통해 선택한 이미지를 캔버스 배경으로 추가

---

## 학습 내용

이 프로젝트를 통해 다음을 학습했습니다:

- PencilKit 프레임워크의 기본 사용법
- PKCanvasView와 다양한 드로잉 도구 활용
- PKDrawing의 직렬화(Serialization) 및 역직렬화
- Apple Pencil 입력 처리
- UndoManager를 활용한 Undo/Redo 구현
- Core Data를 이용한 바이너리 데이터 저장
- PHPickerViewController를 통한 사진 라이브러리 접근

---

## 실행 방법

### 요구 사항
- Xcode 12.0+
- iOS 14.0+
- Swift 5.0+
- CocoaPods

### 설치 및 실행

```bash
# 1. 저장소 클론
git clone https://github.com/MunokKim/SketchApp.git

# 2. 프로젝트 디렉토리 이동
cd SketchApp

# 3. CocoaPods 의존성 설치
pod install

# 4. Workspace 열기
open SketchApp.xcworkspace

# 5. Xcode에서 실행 (⌘ + R)
```

**권장**: Apple Pencil을 지원하는 iPad에서 실행하면 최적의 경험을 할 수 있습니다.

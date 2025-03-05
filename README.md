# 프로젝트명

https://github.com/user-attachments/assets/e04cd4de-c501-41fe-80f3-6f2223649a34

iOS 마스터 6기 2조 팀과 멤버들을 소개하는 앱입니다.

## 목차

- 소개
- 기능
- 스크린샷
- 기술 스택
- 구성 요소

## 소개

MemberCardApp은 팀과 팀원 정보를 관리할 수 있는 애플리케이션입니다. 사용자는 회원의 이름, 프로필 이미지, 설명을 등록하고 수정할 수 있으며, 팀원 목록을 실시간으로 확인할 수 있습니다.

이 앱은 Supabase를 활용하여 팀원 데이터를 저장하고 관리하며, 이미지 업로더 기능을 통해 사용자가 갤러리에서 사진을 선택하고 Supabase 스토리지에 업로드할 수 있습니다.

앱의 핵심 기능은 팀원 목록 조회, 추가, 수정, 삭제이며, MVVM 패턴을 적용해 깔끔한 코드 구조를 유지합니다. 싱글톤 패턴을 활용한 ImageLoader, SupabaseManager 등의 클래스를 통해 데이터 및 네트워크 관리를 효율적으로 처리합니다.

## 기능

- 메인화면
    - 팀 섹션: 팀 소개글 표시
    - 멤버 섹션
        - 멤버 셀 탭 시 각 멤버의 데이터를 상세화면에 전달하여 push
        - 마지막 멤버 셀 탭 시 새로운 멤버를 추가하는 화면으로 push
- 새 멤버 추가
    - AddView에서 이미지 선택, 이름, 소개글 작성
    - 저장 버튼 터치하면 멤버 데이터 저장하고 메인화면으로 이동
- 멤버 편집 및 삭제
    - 메인화면에서 선택한 각 멤버의 세부정보를 확인
    - 편집 버튼을 누르면 편집 화면으로 이동(push)
    - 편집 후 저장 버튼을 누르면 다시 상세화면으로 pop되고, 바뀐 정보를 화면에 표시
    - 삭제 버튼을 누르면 해당 멤버의 정보를 삭제한 후 메인화면으로 이동

## 기술 스택

- URLSession
- Compositional Layout
- Diffable Datasources
- MVVM + Repository + UseCase + 클로저 기반 데이터 바인딩
- Supabase
- UIImagePickerController

## 구성 요소

```
MemberCardApp/
	- Manager/
		- ImageLoader.swift // URL이미지를 UIImage로 변한
		- SupabaseManager.swift // Supabase 클라이언트를 초기화하고 관리하는 역할
	- Model/
		- Member.swift // 회원 정보, 회원 정보 업데이트를 위한 구조체 정의
	- Repository 
		- MemberRepository.swfit // Supabase CRUD 기능 제공
	- Support/
		- Key/
			- ignoreData.swift // Supabase API Key
		- AppDelegate.swift
		- SceneDelegate.swift
	- UseCase/
		- MemberUseCase.swift // MemberRepositroy에 대한 비즈니스 로직 담당
	- View/
		- AddEditView.swift // 사용자가 새로운 항목을 입력하거나 기존 항목을 수정할 UI 제공
		- AddEditViewController.swift // AddEditView를 관리하고 사용자 입력 처리, 데이터 저장, 업데이트 컨트롤러
		- AddMemberCell.swift // TeamCollectionView 멤버 섹션의 멤버 추가 셀
		- DetailViewController.swift // 메인화면에서 선택한 각 멤버의 세부정보 조회, 삭제
		- MainHeaderView.swift // TeamCollectionView의 각 섹션 타이틀 레이아웃
		- MainViewController.swift // 메인화면에서 팀 및 멤버 소개 데이터 바인딩
		- MemberCell.swift // TeamCollectionView 멤버 섹션의 셀
		- TeamCell.swift // TeamCollectionView 팀 섹션의 셀
		- TeamCollectionView.swift // 메인화면 레이아웃
	- ViewModel/
		- ImagePickerViewModel.swift // 갤러리에서 이미지를 선택하고, Supabase 스토리지에 업로드한 후, 업로드된 이미지의 URL을 반환
		- MemberViewModel.swift // 회원 데이터에 대한 CRUD와 UI 업데이트를 위한 콜백 호출
	- info.plist
```

## 사용 방법

- 멤버 카드를 선택하면 상세 화면 이동
- 새로운 멤버 카드를 추가하려면 마지막 카드(+) 선택
- 상세 화면에서 멤버 카드 내용 삭제, 수정 가능(이미지, 이름, 내용)

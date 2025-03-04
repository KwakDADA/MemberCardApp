//
//  MemberViewModelTests.swift
//  MemberCardApp
//
//  Created by tlswo on 3/4/25.
//

import XCTest
@testable import MemberCardApp

class MemberViewModelTests: XCTestCase {
    
    var viewModel: MemberViewModel!
    var mockUseCase: MockMemberUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockMemberUseCase()
        viewModel = MemberViewModel(useCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testFetchMembers() async {
         // Given
         let member1 = Member(id: UUID(), name: "Alice", imageURL: "url1", content: "content1")
         let member2 = Member(id: UUID(), name: "Bob", imageURL: "url2", content: "content2")
         mockUseCase.mockMembers = [member1, member2]
         
         let expectation = XCTestExpectation(description: "Fetch members")
         
         // When
         viewModel.onMembersUpdated = { members in
             XCTAssertEqual(members.count, 2)
             XCTAssertEqual(members.first?.name, "Alice")
             expectation.fulfill()
         }
         
         viewModel.fetchMembers()
         
         // Then
         await fulfillment(of: [expectation], timeout: 1.0)
     }
     
     func testAddMember() async {
         // Given
         let expectation = XCTestExpectation(description: "Add member")
         
         // When
         viewModel.onMembersUpdated = { members in
             XCTAssertEqual(members.count, 1)
             XCTAssertEqual(members.first?.name, "Charlie")
             expectation.fulfill()
         }
         
         viewModel.addMember(name: "Charlie", imageURL: "url3", content: "content3")
         
         // Then
         await fulfillment(of: [expectation], timeout: 1.0)
     }
     
     func testUpdateMember() async {
         // Given
         let member = Member(id: UUID(), name: "David", imageURL: "url4", content: "content4")
         mockUseCase.mockMembers = [member]
         
         let expectation = XCTestExpectation(description: "Update member")
         
         // When
         viewModel.onMembersUpdated = { members in
             XCTAssertEqual(members.first?.name, "UpdatedName")
             expectation.fulfill()
         }
         
         viewModel.updateMember(id: member.id, name: "UpdatedName", imageURL: nil, content: nil)
         
         // Then
         await fulfillment(of: [expectation], timeout: 1.0)
     }
     
     func testDeleteMember() async {
         // Given
         let member = Member(id: UUID(), name: "Eve", imageURL: "url5", content: "content5")
         mockUseCase.mockMembers = [member]
         
         let expectation = XCTestExpectation(description: "Delete member")
         
         // When
         viewModel.onMembersUpdated = { members in
             XCTAssertEqual(members.count, 0)
             expectation.fulfill()
         }
         
         viewModel.deleteMember(id: member.id)
         
         // Then
         await fulfillment(of: [expectation], timeout: 1.0)
     }
}

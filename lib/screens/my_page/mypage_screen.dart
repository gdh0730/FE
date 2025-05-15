import 'package:flutter/material.dart';
import 'package:heal_lo/layout.dart';
import 'package:heal_lo/screens/my_page/edit_profile_section.dart';
import 'package:heal_lo/screens/my_page/emergency_contacts_model.dart';
import 'package:heal_lo/screens/my_page/emergency_contacts_section.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/features/user/UserProfileCard.dart';
import 'package:heal_lo/widgets/features/user/sign_out_button.dart';
import 'package:heal_lo/screens/home/home.dart';

class MyPageScreen extends StatefulWidget {
  MyPageScreen({ super.key });

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  List<EmergencyContact> _contacts = [];
  EmergencyContact? _editingContact;
  String? _username;
  String? _profileImageUrl;
  bool _isLoading = true;
  bool _isEditingProfile = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // TODO: 실제 API 요청으로 대체
      await Future.delayed(const Duration(seconds: 1));

      // 더미 데이터
      setState(() {
        _username = 'katarinabluu';
        _profileImageUrl = 'https://www.kstarfashion.com/news/photo/202412/223598_150402_322.jpg';
        _contacts = [
          EmergencyContact(
            name: '119',
            phoneNumber: '119',
            backgroundColor: const Color(0xFFFACECE),
          ),
          EmergencyContact(name: '엄마', phoneNumber: '010-1234-5678'),
          EmergencyContact(name: '아빠', phoneNumber: '010-4321-8765'),
        ];
        _isLoading = false;
      });
    } catch (e) {
      print('데이터 불러오기 실패: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator()) // 로딩 중
            : Padding (
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  "My Page",
                  style: TextStyle(
                    fontFamily: 'PretendardBlack',
                    fontSize: 25,
                  ),
                ),
              ),
              // User Profile Section
              UserProfileCard(
                username: _username!,
                imageUrl: _profileImageUrl!,
                onEditPressed: () => setState(() => _isEditingProfile = true),
              ),
              const SizedBox(height: 36,),
              // 응급 연락처 Section
              // 추후 사용자 설정에 따라 연락처를 불러오는 기능 추가 예정
              _isEditingProfile
                  ? EditProfileSection(
                    initialImageUrl: _profileImageUrl!,
                    initialUsername: _username!,
                    onSave: (username, imageFile) async {
                      String uploadedUrl = _profileImageUrl!;

                      // if (imageFile != null) {
                      //   // Todo: 이미지 업로드 기능 구현
                      //   uploadedUrl = await uploadImage(imageFile);
                      // }

                      setState(() {
                        _username = username;
                        _profileImageUrl = uploadedUrl;
                        _isEditingProfile = false;
                      });
                    },
                    // TODO: 실제 API 요청으로 대체
                    // onSave: (username, imageUrl) async {
                    //   try {
                    //     await updateUserProfile(username, imageUrl);
                    //     // TODO: 프로필 수정 기능 구현
                    //     setState(() {
                    //       _username = username;
                    //       _profileImageUrl = imageUrl;
                    //       _isEditingProfile = false;
                    //     });
                    //   } catch (e) {
                    //     print("업데이트 실패: $e");
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("프로필 업데이트 실패")),
                    //     );
                    //   }
                    // },
                    onCancel: () {
                      setState(() => _isEditingProfile = false);
                    },
                  )
                  : EmergencySection(
                    contacts: _contacts,
                    onAddContact: () {
                      // TODO: 연락처 추가 기능 구현
                    },
                    onEdit: (contact) {
                      // TODO: 연락처 수정 기능 구현
                      setState(() {
                        _editingContact = contact;
                        });
                    },
                    onDelete: (contact) {
                      // TODO: 연락처 삭제 기능 구현
                    },
                  ),
              SignOutBtn(
                onSignOut: () async {
                  // TODO : 로그아웃 기능 구현
                  MainLayout.of(context)?.changeTab(2);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
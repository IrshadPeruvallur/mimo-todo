import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_todo/authentication/controller/auth_controller.dart';
import 'package:memo_todo/authentication/view/login_screen.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/features/task/controller/category_controller.dart';
import 'package:memo_todo/features/task/view/category_list.dart';
import 'package:memo_todo/features/user/controller/user_controller.dart';
import 'package:memo_todo/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryController>(context, listen: false).fetchCategories();
      Provider.of<UserController>(context, listen: false).getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Consumer<UserController>(builder: (context, value, child) {
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 18.0,
                backgroundImage: value.profileUrl == null
                    ? null
                    : NetworkImage(value.profileUrl!),
              ),
              const SizedBox(width: 10),
              CustomText(text: value.user?.fullname ?? ''),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        shape: const BeveledRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Consumer<UserController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => value.pickImage(),
                      child: CircleAvatar(
                        backgroundColor: secondaryColor,
                        radius: 30.0,
                        backgroundImage: value.profileUrl == null
                            ? null
                            : NetworkImage(value.profileUrl!),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          value.isEdit
                              ? Flexible(
                                  child: TextField(
                                    controller: value.nameContoller,
                                    decoration:
                                        const InputDecoration(hintText: 'Name'),
                                  ),
                                )
                              : CustomText(
                                  text: value.user?.fullname ?? '',
                                  size: 16,
                                  overflow: true,
                                  fontWeight: FontWeight.bold),
                          IconButton(
                              onPressed: () async {
                                if (value.isEdit) {
                                  await value.uploadProfileImage();
                                  await value.updateUser();
                                } else {
                                  value.isEditName();
                                }
                              },
                              icon: Icon(value.isEdit
                                  ? Icons.check
                                  : Icons.edit_outlined))
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const CustomText(text: 'Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const CustomText(text: 'General Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const CustomText(text: 'Account Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const CustomText(text: 'About'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const CustomText(text: 'Logout'),
              onTap: () {
                Provider.of<AuthController>(context, listen: false)
                    .logoutUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomText(
                text: 'Version 1.0.0',
                size: 13,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage(
                        'assets/images/image.png',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Believe you can and you're halfway there.",
                            style: GoogleFonts.lora(
                              fontStyle: FontStyle.italic,
                              fontSize: 16.0,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "—Theodore Roosevelt",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.lora(
                                fontStyle: FontStyle.italic,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: CategoryList(size: size)),
          ],
        ),
      ),
    );
  }
}

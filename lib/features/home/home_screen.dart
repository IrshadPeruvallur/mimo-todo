import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_todo/constants/colors.dart';
import 'package:memo_todo/features/task/view/category_list.dart';
import 'package:memo_todo/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Open the drawer when profile picture is tapped
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                radius: 18.0,
                // backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with your profile pic
              ),
            ),
            SizedBox(width: 10),
            CustomText(text: 'Title'), // Replace with your desired title
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    // backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with your profile pic
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'User Name',
                            size: 16,
                            overflow: true,
                            fontWeight:
                                FontWeight.bold), // Replace with user's name
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: CustomText(text: 'Notifications'),
              onTap: () {
                // Navigate to notifications page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: CustomText(text: 'General Settings'),
              onTap: () {
                // Navigate to general settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: CustomText(text: 'Account Settings'),
              onTap: () {
                // Navigate to account settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: CustomText(text: 'About'),
              onTap: () {
                // Navigate to about page
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                    CircleAvatar(
                      radius: 30.0,
                      // backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with your profile pic
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        'This is an inspirational quote.',
                        style: GoogleFonts.lora(
                          fontStyle: FontStyle.italic,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: CategoryList(size: size)),
          ],
        ),
      ),
    );
  }
}

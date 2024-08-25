import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/screens/main_screens/bookmark_screen.dart';
import 'package:news_app/screens/main_screens/discover_screen.dart';
import 'package:news_app/screens/main_screens/home_screen.dart';
import 'package:news_app/screens/main_screens/profile_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomeScreen(),
    const DiscoverScreen(),
    const BookmarkScreen(),
    const ProfileScreen()
  ];

  int selectedIndex = 0;

  void _updateIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: GNav(
        selectedIndex: selectedIndex,
        onTabChange: _updateIndex,
        activeColor: theme.info,
        gap: 10,
        color: theme.accent2,
        tabs: const [
          GButton(
            icon: Icons.home, // Home icon
            text: 'Home',
          ),
          GButton(
            icon: Icons.explore, // Discover icon
            text: 'Discover',
          ),
          GButton(
            icon: Icons.bookmark, // Bookmark icon
            text: 'Bookmarks',
          ),
          GButton(
            icon: Icons.person, // Profile icon
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}

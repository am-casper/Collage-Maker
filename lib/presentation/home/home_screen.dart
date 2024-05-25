import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furrl/presentation/home/components/home_app_bar.dart';
import 'package:furrl/presentation/home/components/story_tile.dart';
import 'package:furrl/presentation/view_frame/view_frame_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: const HomeAppBar().build(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromRGBO(126, 89, 231, 1),
        unselectedItemColor: Color.fromARGB(255, 91, 93, 95),
        onTap: (value){
          if (value==3) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewFrameScreen()));
          }
        },
        items:  [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset('assets/icons/tribe.svg'),
            label: 'Tribe',
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset('assets/icons/category.svg'),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg'),
            label: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              color: const Color(0xFF7E59E7),
              child: Text(
                "Free Delivery Above INR 499",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        StoryTile(title: "Best Sellers", image: "story1"),
                        StoryTile(title: "Home", image: "story2"),
                        StoryTile(title: "Apparel", image: "story3"),
                        StoryTile(title: "Accesories", image: "story4"),
                        StoryTile(title: "Best Sellers", image: "story1"),
                        StoryTile(title: "Home", image: "story2"),
                        StoryTile(title: "Apparel", image: "story3"),
                        StoryTile(title: "Accesories", image: "story4"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              // width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("#DailyEthnics",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF7E59E7))),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "•",
                              style: TextStyle(
                                  color: Color(0xFFCBD5E1), fontSize: 30),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7E59E7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/frame.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.5)
                                    ],
                                  ),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.68,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 16,
                              child: Image.asset(
                                "assets/images/expert.png",
                                height: 24,
                                width: 87,
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 12,
                              child: Row(
                                children: [
                                  Image.asset("assets/images/pfp2.png"),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wade Warren",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "IG: 1m followers",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFFCECECE)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 16,
                              bottom: 12,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4B5563),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/share.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4B5563),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/wishlist.svg',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: const Color(0xFFCECECE).withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Embrace cultural elegance with my daily ethnics collection",
                              style: GoogleFonts.montserrat(
                                  height: 1.3 ,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF001718)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

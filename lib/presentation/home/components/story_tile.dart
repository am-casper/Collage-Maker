import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryTile extends StatelessWidget {
  final String title;
  final String image;

  const StoryTile({super.key, required this.title, required this.image});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset("assets/story/$image.png"),
          const SizedBox(height: 4),
          Text(title,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF001718),
              ))
        ],
      ),
    );
  }
}

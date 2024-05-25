import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget furrlAppBar(String title, BuildContext context) {
  return AppBar(
    shape: const Border(bottom: BorderSide(color: Colors.black12, width: 1)),
    automaticallyImplyLeading: false,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    titleSpacing: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset('assets/icons/bookmark.svg'),
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset('assets/icons/bag.svg'),
            ],
          )
        ],
      ),
    ),
  );
}

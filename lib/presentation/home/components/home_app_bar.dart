import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Furrl',
              style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF7E59E7))),
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
              Stack(children: [
                SvgPicture.asset('assets/icons/bag.svg'),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7E59E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: const Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ]),
            ],
          )
        ],
      ),
    );
  }
}

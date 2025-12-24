import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _navItem({
    required int index,
    required Widget icon,
    required bool isActive,
    bool isCenter = false,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: 60,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (isCenter)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF004AAD),
                  shape: BoxShape.circle,
                ),
                child: Center(child: icon),
              )
            else
              icon,

            if (isActive)
              Positioned(
                top: isCenter ? -0 : -0,
                child: Assets.icons.activeDot.image(
                  width: 9.12,
                  height: 9.12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(bottom: 8),
        color: const Color(0xFF1C1C1E),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _navItem(
                index: 0,
                isActive: currentIndex == 0,
                icon: currentIndex == 0
                    ? Assets.icons.activeHome.image(width: 30, height: 30)
                    : Assets.icons.inActiveHome.image(width: 30, height: 30),
              ),
            ),

            Expanded(
              child: _navItem(
                index: 1,
                isActive: currentIndex == 1,
                icon: currentIndex == 1
                    ? Assets.icons.activeLike.image(width: 30, height: 30)
                    : Assets.icons.inActiveLike.image(width: 30, height: 30),
              ),
            ),

            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -24),
                child: _navItem(
                  index: 2,
                  isCenter: true,
                  isActive: currentIndex == 2,
                  icon: Assets.icons.inActiveAddVideo.image(
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),

            Expanded(
              child: _navItem(
                index: 3,
                isActive: currentIndex == 3,
                icon: currentIndex == 3
                    ? Assets.icons.activeWinner.image(width: 30, height: 30)
                    : Assets.icons.inActiveAddWinner.image(width: 30, height: 30),
              ),
            ),

            Expanded(
              child: _navItem(
                index: 4,
                isActive: currentIndex == 4,
                icon: currentIndex == 4
                    ? Assets.icons.activeProfile.image(width: 30, height: 30)
                    : Assets.icons.inActiveProfile.image(width: 30, height: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

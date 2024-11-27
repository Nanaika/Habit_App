import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/bottom_bar_index_bloc.dart';
import '../theme.dart';
import '../utils/const.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    this.onTap,
    required this.imagePath,
    required this.index,
  });

  final void Function()? onTap;
  final String imagePath;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarIndexBloc, int>(
      builder: (context, state) {
        final color = switch(index) {
          0 => blue,
          1 => red,
          2 => violet,
          3 => green,
          int() => throw UnimplementedError(),
        };

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index == state ? color : getColor(context).surfaceTint,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                imagePath,
                colorFilter: index == state
                    ? ColorFilter.mode(getColor(context).surfaceTint, BlendMode.srcIn)
                    : ColorFilter.mode(getColor(context).onPrimary, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}

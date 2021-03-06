import 'package:dashboard/constants/global.dart';
import 'package:dashboard/controllers/menu_controller.dart';
import 'package:dashboard/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import 'search.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              splashRadius: defaultPadding + 8,
              icon: const Icon(Icons.menu),
              onPressed: context.read<MenuController>().controlMenu,
            ),
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultPadding / 2,
            ),
            child: SearchField(),
          ),
        ),
        const ProfileCard()
      ],
    );
  }
}

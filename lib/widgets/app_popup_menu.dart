import 'package:flutter/material.dart';
import 'package:resto_page/utils/extension.dart';

import '../models/home_tab_model.dart';

class PopupMenu {
  const PopupMenu({required this.popUpList});

  final List<PopUpList> popUpList;

  PopupMenuButton<String> createPopup() {
    return PopupMenuButton(
      color: Colors.white,
      icon: const Icon(Icons.arrow_drop_down,color: Colors.black,),
      onSelected: (value) {
        popUpList.firstWhere((e) => e.title == value).onTap!();
      },

      itemBuilder: (context) => popUpList
          .map((item) => PopupMenuItem(
        value: item.title,
        child: Row(
          children: [
            item.title
                .appTextStyle400(fontSize: 16, fontColor: Colors.black)
          ],
        ),
      ))
          .toList(),
    );
  }
}
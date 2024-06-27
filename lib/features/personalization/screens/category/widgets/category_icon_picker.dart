import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/personalization/controllers/category/icon_picker_controller.dart';


class CategoryIconPickerPage extends StatelessWidget {
  const CategoryIconPickerPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final iconController = Get.put(IconPickerController());
    final map = paisaIconMap.entries.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(result: iconController.selectedIcon.value);
          },
          icon: const Icon(Icons.close),
        ),
        title: Text('Choose Icon'), // Replace with your localized text
        actions: [
          // TextButton(
          //   onPressed: () async {
          //     final resultIcon = await paisaIconPicker(
          //       context: context,
          //       defaultIcon: iconController.selectedIcon.value,
          //     );
          //     if (resultIcon != null) {
          //       iconController.updateSelectedIcon(resultIcon);
          //     }
          //   },
          //   child: Text('More'), // Replace with your localized text
          // ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Get.back(result: iconController.selectedIcon.value);
            },
            child: Text('Done'), // Replace with your localized text
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: map.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final iconData = map[index];
          return Obx(() {
            final isSelected = iconController.selectedIcon.value ==
                iconData
                    .value[0]; // Assuming the first element is the selected one
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    visualDensity: const VisualDensity(vertical: -3),
                    title: Text(
                      iconData.key,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: iconData.value.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                    ),
                    itemBuilder: (context, idx) {
                      final bool isSelected =
                          iconController.selectedIcon.value ==
                              iconData.value[idx];
                      
                        return GestureDetector(
                          onTap: () {
                            iconController
                                .updateSelectedIcon(iconData.value[idx]);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: isSelected ? 2 : 0,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Icon(
                              iconData.value[idx],
                              size: 30,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                        );
                     
                    },
                  ),
                ],
              ), 
            );
          });
        },
      ),
    );
  }
}

final paisaIconMap = {
  'Animal': [
    MdiIcons.butterfly,
    MdiIcons.cat,
    MdiIcons.cow,
    MdiIcons.dog,
    MdiIcons.dogSide,
    MdiIcons.duck,
    MdiIcons.fish,
    MdiIcons.horse,
    MdiIcons.owl,
    MdiIcons.panda,
    MdiIcons.pig,
    MdiIcons.sheep,
    MdiIcons.rabbit,
    MdiIcons.snail,
    MdiIcons.snake,
    MdiIcons.spider,
    MdiIcons.tortoise,
    MdiIcons.turtle,
    MdiIcons.turkey,
  ],
  'Brands': [
    MdiIcons.android,
    MdiIcons.angular,
    MdiIcons.apple,
    MdiIcons.atlassian,
    MdiIcons.aws,
    MdiIcons.bitbucket,
    MdiIcons.bitcoin,
    MdiIcons.blenderSoftware,
    MdiIcons.bootstrap,
    MdiIcons.codepen,
    MdiIcons.devTo,
    MdiIcons.deviantart,
    MdiIcons.docker,
    MdiIcons.dropbox,
    MdiIcons.evernote,
    MdiIcons.facebook,
    MdiIcons.firebase,
    MdiIcons.firefox,
    MdiIcons.github,
    MdiIcons.gitlab,
    MdiIcons.gmail,
    MdiIcons.google,
    MdiIcons.googleAds,
    MdiIcons.googleDrive,
    MdiIcons.googlePlay,
    MdiIcons.hulu,
    MdiIcons.instagram,
    MdiIcons.jira,
    MdiIcons.kickstarter,
    MdiIcons.languageSwift,
    MdiIcons.linkedin,
    MdiIcons.microsoft,
    MdiIcons.microsoftAzure,
    MdiIcons.nintendoSwitch,
    MdiIcons.onepassword,
    MdiIcons.pandora,
    MdiIcons.patreon,
    MdiIcons.pinterest,
    MdiIcons.qqchat,
    MdiIcons.reddit,
    MdiIcons.skype,
    MdiIcons.snapchat,
    MdiIcons.soundcloud,
    MdiIcons.spotify,
    MdiIcons.steam,
    MdiIcons.wechat,
    MdiIcons.whatsapp,
    MdiIcons.wikipedia,
    MdiIcons.wordpress,
    MdiIcons.youtube,
  ],
  'Computer': [
    MdiIcons.album,
    MdiIcons.audioVideo,
    MdiIcons.earbuds,
    MdiIcons.headphones,
    MdiIcons.musicNote,
    MdiIcons.speaker,
    MdiIcons.printer,
    MdiIcons.radio,
    MdiIcons.wifi,
    MdiIcons.bluetooth,
    MdiIcons.phone,
    MdiIcons.laptop,
    MdiIcons.desktopClassic,
    MdiIcons.televisionSpeaker,
    MdiIcons.videoVintage,
    MdiIcons.film,
    MdiIcons.camcorder,
    MdiIcons.video,
    MdiIcons.webcam,
    MdiIcons.camera,
  ],
  'Food': [
    MdiIcons.carrot,
    MdiIcons.chiliMild,
    MdiIcons.corn,
    MdiIcons.egg,
    MdiIcons.foodApple,
    MdiIcons.fruitGrapes,
    MdiIcons.fruitCherries,
  ],
  'Health': [
    MdiIcons.pillMultiple,
    MdiIcons.needle,
    MdiIcons.motherNurse,
    MdiIcons.truckPlus,
    MdiIcons.medication,
    MdiIcons.hospitalBuilding,
    MdiIcons.emoticonSick,
  ],
  'Shopping': [
    MdiIcons.basket,
    MdiIcons.cart,
    MdiIcons.cash,
    MdiIcons.creditCard,
    MdiIcons.sale,
    MdiIcons.shopping,
    MdiIcons.store,
    MdiIcons.cashRegister,
    MdiIcons.cartVariant,
  ],
  'Transportation': [
    MdiIcons.airplane,
    MdiIcons.car,
    MdiIcons.ferry,
    MdiIcons.taxi,
    MdiIcons.tram,
    MdiIcons.train,
    MdiIcons.bus,
  ],
  'Other': [
    MdiIcons.circle,
    MdiIcons.circleHalf,
    MdiIcons.heart,
    MdiIcons.hexagon,
    MdiIcons.decagram,
    MdiIcons.shape,
    MdiIcons.hexagonMultiple,
    MdiIcons.triangle,
    MdiIcons.shapePlus,
  ],
};

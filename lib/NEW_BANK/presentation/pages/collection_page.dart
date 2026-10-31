import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/collection_widget.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   final collectionController = Provider.of<CollectionController>(
  //     context,
  //     listen: false,
  //   );
  //   collectionController.accountList.clear();
  // }

  @override
  Widget build(BuildContext context) {
    final collectionController = Provider.of<CollectionController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + h * 0.03,
            leading: IconButton(
              onPressed: () {
                collectionController.accNoController.clear();
                collectionController.accountList.clear();
                context.go(AppPages.dashboard);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
            ),
            backgroundColor: AppColors.maincolor,
            title: Text(
              "Collection",
              style: GoogleFonts.poppins(
                fontSize: w * 0.05,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                w * 0.04,
                h * 0.04,
                w * 0.04,
                h * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            hintText: "Search Member/ Name / A/c No",
                            controller: collectionController.accNoController,
                            onChanged: (value) {
                              collectionController.filterByMemberNo(value);
                            },
                            //inputType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: w * 0.04),
                        Expanded(
                          child: Consumer<CollectionController>(
                            builder:
                                (context, value, child) =>
                                    collectionController.accountState.status ==
                                            Status.LOADING
                                        ? Center(
                                          child:
                                              LoadingAnimationWidget.threeArchedCircle(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                                size: h * 0.04,
                                              ),
                                        )
                                        : CustomGradientButton(
                                          title: "Search",
                                          onPressed: () {
                                            final memberNo =
                                                collectionController
                                                    .accNoController
                                                    .text
                                                    .trim();
                                            if (memberNo.isEmpty) {
                                              bottomMsg(
                                                context,
                                                "Failed",
                                                "Please enter Member No",
                                                false,
                                              );
                                            } else {
                                              collectionController
                                                  .filterByMemberNo(memberNo);
                                            }
                                          },
                                        ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.03),

                  CollectionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isRed = false}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ":",
            style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isRed ? AppColors.red : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}

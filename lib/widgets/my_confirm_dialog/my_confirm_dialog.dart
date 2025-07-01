import 'package:flutter/material.dart';
import 'package:work_order_app/core/consts_and_enums/consts/color_hex.dart';
import 'package:work_order_app/core/consts_and_enums/consts/sizes.dart';
import 'package:work_order_app/core/utils/media_query_helpers.dart';

Future myConfirmDialog(
    BuildContext context, {
      String? basicContentString,
      String? title,
      String? positiveButtonText,
      String? negativeButtonText,
      Function? positiveButtonCallback,
      Function? negativeButtonCallback,
      Widget? customContent,
      Function()? dismissedDialogCallback,
    }) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? "Confirm",
          ),
        ],
      ),
      content: customContent ?? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            basicContentString ?? ""
            // "$content",
            // style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
            ,
            softWrap: true, textAlign: TextAlign.justify,
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(sizeNormal),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  child: ElevatedButton(
                    onPressed: () {
                      if (negativeButtonCallback != null) {
                        negativeButtonCallback();
                        Navigator.of(context).pop();

                      } else {
                        // context.router.pop();
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeNormal)),
                      backgroundColor: Color(primaryDarkColor),
                      side: BorderSide(color: Color(primaryDarkColor)),
                    ),
                    child: Text(negativeButtonText ?? "No",
                      style: TextStyle(color: Colors.white),

                    ),
                  ),
                ),
              ),
              const SizedBox(width: sizeMedium),
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeNormal)),
                      backgroundColor: Color(primaryColor),
                      side: BorderSide(color: Color(primaryColor)),
                    ),
                    onPressed: () {
                      positiveButtonCallback!();
                      // Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(positiveButtonText ?? "Yes",
                      style: TextStyle(color: Colors.white),

                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  ).then((value) => dismissedDialogCallback != null ? dismissedDialogCallback() : null);
}

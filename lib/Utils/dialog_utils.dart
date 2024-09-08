import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';

class DialogUtils {
  static showLoading(
      {required BuildContext context,
      required String loadingMessage,
      bool isDismissible = false}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(
                  color: AppTheme.yellowColor, strokeWidth: 5),
              const SizedBox(
                width: 10,
              ),
              Text(loadingMessage,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.blackColor, fontWeight: FontWeight.bold))
            ],
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessage(
      {required BuildContext context,
      String? title,
      bool isDismissible = true,
      required String content,
      String? posActions,
      Function(BuildContext)? posFunction,
      String? negActions,
      Function(BuildContext)? negFunction}) {
    List<Widget> actions = [];

    if (posActions != null) {
      actions.add(TextButton(
          onPressed: () {
            if (posFunction != null) {
              posFunction.call(context);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            posActions,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: AppTheme.yellowColor),
          )));
    }

    if (negActions != null) {
      actions.add(TextButton(
          onPressed: () {
            if (negFunction != null) {
              negFunction.call(context);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            negActions,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: AppTheme.yellowColor),
          )));
    }

    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 0,
          title: title != null
              ? Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.blackColor, fontWeight: FontWeight.bold),
                )
              : null,
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppTheme.blackColor),
          ),
          actions: actions.isEmpty ? null : actions,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:list_system/controllers/translate.dart';
/*
 * Component to show success dialog and redirect with a routes especifict
 * @author  SGV - 20230814
 * @version 1.0 - 20230814 - initial release
 * @return  <component> showDialog 
 */
class SuccessDialog extends StatefulWidget {
  const SuccessDialog({super.key});
  @override
  State<StatefulWidget> createState() => SuccessDialogState();
}

class SuccessDialogState extends State<SuccessDialog> with SingleTickerProviderStateMixin {
  Animation<double>? scaleAnimation;
  AnimationController? controller;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.easeOutCirc);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward().then((_) {
      Future.delayed( const Duration(milliseconds: 700)).then((_) {
        if(!_mounted){
          controller!.reverse().then((_) {
            Navigator.of(context).pop();
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    _mounted = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                    size: 24.0,
                  ),
                  Text('OK'.allInCaps + '!',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
 * Show success dialog e redirect a route defined
 * @author  SGV - 20230814
 * @version 1.0 - 20230814 - initial release
 * @param   <BuildContext> context
 * @param   <String> routerName => route to redirect show dialog
 * @return  <component> showDialog 
 */
Future<void> showMessageForUser(BuildContext context, String routeName) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog();
      });
  Navigator.popAndPushNamed(context, routeName);
}

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vagas/model/CvModel.dart';

class ContainerTextWidget extends StatelessWidget {
  const ContainerTextWidget({
    Key? key,
    this.text,
    required this.type,
    required this.isList,
    this.cv,
  }) : super(key: key);

  final String? text;
  final CvModel? cv;
  final String type;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 26,
            ),
          ),
          if (!isList)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Text(
                      text!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
          if (isList)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String txt in cv!.experiencias)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "- " + txt,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}

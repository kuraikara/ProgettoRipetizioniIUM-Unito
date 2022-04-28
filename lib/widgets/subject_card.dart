import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/pages/subject_page.dart';

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final int subjectId;
  final Color subjectColor;


  SubjectCard({
    required this.subjectName,
    required this.subjectColor,
    required this.subjectId,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical:5.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectPage(id: subjectId, nome: subjectName),));
          },
            
          child: Container(
            decoration: BoxDecoration(
              color: subjectColor,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 100.0,
            padding: const EdgeInsets.all(12),
            //color: subjectColor ,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Center(
                    child: Text(subjectName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 50, color: Color.fromARGB(144, 0, 0, 0))
              ],
            )
          ),
        ),
      
    );
  }
}
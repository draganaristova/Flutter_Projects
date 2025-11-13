import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam_model.dart';

class DetailsPage extends StatelessWidget{
  final Exam exam;
  const DetailsPage({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final bool passed = exam.date.isBefore(DateTime.now());
    final dateFormatted = DateFormat('dd/MM/yyyy').format(exam.date);
    final timeFormatted = DateFormat('HH:mm').format(exam.date);
    return Scaffold(
      appBar: AppBar(
        title: Text("Детали за предметот", style: TextStyle(fontWeight: FontWeight.bold, fontSize:20), maxLines: 2,),
      ),
      body: Container(
            child: Padding(
            padding: EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Expanded(
                       child: Text(exam.name,
                         style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                      ),
                     ),
                  ]
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18),
                    SizedBox(width: 10, height: 15),
                    Expanded(
                      child: Text('Датум:',
                        style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                        child: Text(
                            dateFormatted,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Време:',
                        style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        timeFormatted,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.room, size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Просторија:',
                        style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        exam.rooms.join(", "),
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        passed ? Icons.circle_outlined : Icons.timer_outlined,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _remainingTime(exam.date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                )

              ],
            ),
          ),
        ),
    );
  }
}
String _remainingTime(DateTime date){
  final now = DateTime.now();
  final difference = date.difference(now);
  if(difference.isNegative){
    return 'Испитот е поминат.';
  }
  else{
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    return 'Преостанато време: $days ден/a, $hours час/а';
  }
}
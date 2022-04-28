import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class Course{
  int id;
  String nome;

  Course(this.id, this.nome);

  static Future<List<Course>> fetchCourses() async{
    String url = 'http://10.0.2.2:8080/Prenotazioni0_war';
    List<Course> courses = [];
  
    //fetching courses
    final response = await Requests.get(url + '/getData?operation=getCoursesWithTeaching');

    //TODO:check response status
    dynamic data = response.json();
    
    for(int i=0;i<data.length;i++){
      courses.add(new Course(data[i]['id'], data[i]['nome']));
    }
    return courses;
  }
}
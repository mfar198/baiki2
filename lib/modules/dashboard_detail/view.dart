import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//pages
import 'package:baiki2/model/list/model.dart';
import 'package:baiki2/modules/navBar/appBar.dart';
import 'package:baiki2/style/themeData.dart';
import 'package:baiki2/route/app_router.dart';
import 'package:baiki2/modules/dashboard/bloc/dashboard_bloc.dart';

@RoutePage()
class DetailScreen extends StatefulWidget {
  final Data selectedItem;
  const DetailScreen({required this.selectedItem, Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Data selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 60,
        backgroundColor: Color.fromRGBO(251, 31, 38, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(selectedItem.id.toString() ?? '', style: GoogleFonts.poppins(
          color: Colors.white, fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
    );
  }
}

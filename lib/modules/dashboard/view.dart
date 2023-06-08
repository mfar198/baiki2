import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

//pages
import 'package:baiki2/model/list/model.dart';
import 'package:baiki2/modules/navBar/appBar.dart';
import 'package:baiki2/style/themeData.dart';
import 'package:baiki2/route/app_router.dart';
import 'package:baiki2/modules/dashboard/bloc/dashboard_bloc.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final ListBloc _listBloc = ListBloc();
  final _appRouter = AppRouter();
  final _controller = TextEditingController();

  @override
  void initState() {
    _listBloc.add(GetListList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: NavBarScreen(),
          endDrawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('data'),
                ],
              ),
            ),
          ),
          body: _buildListList(),
        );
  }

  Widget _buildListList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _listBloc,
        child: BlocListener<ListBloc, ListState>(
          listener: (context, state) {
            if (state is ListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                )
              );
            }
          },
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              if (state is ListInitial) {
                return _buildLoading();
              } else if (state is ListLoading) {
                return _buildLoading();
              } else if (state is ListLoaded) {
                return _buildCombinedCard(context, state.listModel);
                //return _buildCard(context, state.listModel);
              } else if (state is ListError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCombinedCard(BuildContext context, ListModel listModel){
    return Column(
      children: [
        _buildStatiCard(),
        const SizedBox(height: 0,),
        Expanded(child: SingleChildScrollView(child: _buildCard(context, listModel))),
      ],
    );
  }

  Widget _buildStatiCard(){
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Get help from ", style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text("your nearest", style: GoogleFonts.poppins(
                color: Colors.red, fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("mobile repair shop", style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(12)),
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: ()=> _controller.clear(),
              ),
              prefixIcon: Icon(Icons.search),
              filled: false,
              hintText: 'Search',
              contentPadding: EdgeInsets.only(
                top: 14,
                right: 16,
                bottom: 0,
                left: 16,
              ),
              border: UnderlineInputBorder(),
            ),
            onFieldSubmitted: (input) {
              setState(() {
                //future = fetchData(searchQuery: input);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, ListModel model) {
    final dataList = model.data!;
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 1),
      child: Column(
        children: dataList.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(item.avatar ?? ''),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                      "${item.firstName} ${item.lastName}".toUpperCase()),
                                ),
                                SizedBox(
                                  width: 60,
                                  child:
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(child: Icon(Icons.add_location_outlined,size: 14),),
                                        TextSpan(
                                          text: "${item.id?? ''}",
                                          style: TextStyle(color: Color(0xff868597)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 100,
                              child: Text(
                                item.email ?? 'No Data Found',
                                style: const TextStyle(color: Color(0xff868597)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              if (index != dataList.length - 1) const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }


  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

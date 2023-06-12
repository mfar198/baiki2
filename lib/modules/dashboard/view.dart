import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:baiki2/modules/dashboard_detail/view.dart';
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

  Widget _buildCombinedCard(BuildContext context, ListModel listModel) {
    return Column(
      children: [
        _buildStatiCard(),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCard(context, listModel.data![index]);
              },
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildStatiCard(){
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 10),
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
          const Padding(padding: EdgeInsets.all(10)),
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
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: ()=> setState(() {
                  //future = fetchData(searchQuery: null);
                }),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(255, 255, 255, 1),
                  shadowColor: Colors.grey,
                  elevation: 1,
                  minimumSize: Size(140, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "All",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: ()=> setState(() {
                  //future = fetchData(searchQuery: 'Amanz');
                }),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(251, 31, 38, 1),
                  shadowColor: Colors.grey,
                  elevation: 1,
                  minimumSize: Size(140, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Nearest",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, ListModel model) {
    final dataList = model.data!;
    return GestureDetector(
      onTap: () {
        // Handle the tap event here, e.g., navigate to the next page
        // using Navigator.push()
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreen(selectedItem: item);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 10),
        child: Column(
          //children: dataList.asMap().entries.map((entry) {
          children: dataList.map((item) {
            //final index = entry.key;
            //final item = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
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
                                    width: 70,
                                    child: Text(
                                        "${item.firstName} ${item.lastName}".toUpperCase()),
                                  ),
                                  SizedBox(
                                    width: 30,
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
                                //height: 100,
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
                //if (index != dataList.length - 1) const SizedBox(height: 20),
                if (item != dataList.last) const SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }


  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

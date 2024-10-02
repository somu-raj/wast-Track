import 'package:flutter/material.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 19),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 19),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search  anything ....',
                          hintStyle: TextStyle(fontSize: 12)),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColor.green),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}

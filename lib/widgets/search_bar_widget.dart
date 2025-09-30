import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.hintText = "Search",
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {}); // rebuild for icon update
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          widget.controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.close, color: AppColors.primary),
            onPressed: () {
              widget.controller.clear();
              widget.onChanged("");
              setState(() {});
            },
          )
              : Icon(Icons.search, color: AppColors.primary),
        ],
      ),
    );
  }
}

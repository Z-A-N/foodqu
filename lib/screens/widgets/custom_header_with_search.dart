import 'package:flutter/material.dart';

class CustomHeaderWithSearch extends StatefulWidget {
  final String title;
  final bool showBackButton;
  final Function(String)? onSearch;
  final VoidCallback? onSearchCancelled;

  const CustomHeaderWithSearch({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onSearch,
    this.onSearchCancelled,
  });

  @override
  State<CustomHeaderWithSearch> createState() => _CustomHeaderWithSearchState();
}

class _CustomHeaderWithSearchState extends State<CustomHeaderWithSearch> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchCancelled?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bagian kiri: logo atau back
          Align(
            alignment: Alignment.centerLeft,
            child: widget.showBackButton
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : Image.asset('assets/images/Logo_foodqu.png', height: 32),
          ),

          // Bagian tengah: judul atau search bar
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSearching
                ? Container(
                    key: const ValueKey('search'),
                    height: 40,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 48,
                    ), // biar gak nabrak kiri/kanan
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: widget.onSearch,
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: _toggleSearch,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  )
                : Text(
                    widget.title,
                    key: const ValueKey('title'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),

          // Bagian kanan: ikon notifikasi dan pencarian
          if (!_isSearching)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_rounded, color: Colors.white),
                    onPressed: _toggleSearch,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

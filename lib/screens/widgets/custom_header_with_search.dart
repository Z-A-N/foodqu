import 'dart:async';
import 'package:flutter/material.dart';
import '../notification/notification_page.dart';

class CustomHeaderWithSearch extends StatefulWidget {
  final String title;
  final bool showBackButton;
  final Function(String)? onSearch;
  final VoidCallback? onSearchCancelled;
  final bool showNotificationIcon;

  const CustomHeaderWithSearch({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onSearch,
    this.onSearchCancelled,
    this.showNotificationIcon = true,
  });

  @override
  State<CustomHeaderWithSearch> createState() => _CustomHeaderWithSearchState();
}

class _CustomHeaderWithSearchState extends State<CustomHeaderWithSearch> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchCancelled?.call();
      }
    });
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onSearch?.call(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildLeftWidget(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSearching ? _buildSearchField() : _buildTitleText(),
          ),
          if (!_isSearching) _buildRightActions(),
        ],
      ),
    );
  }

  Widget _buildLeftWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: widget.showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : Image.asset(
              'assets/images/Logo_foodqu.png',
              height: 40,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.fastfood, color: Colors.white, size: 30),
            ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      widget.title,
      key: const ValueKey('title'),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      key: const ValueKey('search'),
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 48),
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
        onChanged: _onSearchChanged,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Cari...',
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: _toggleSearch,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildRightActions() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showNotificationIcon)
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white),
            onPressed: _toggleSearch,
          ),
        ],
      ),
    );
  }
}

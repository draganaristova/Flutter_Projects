import 'package:displaying_recipes/models/category.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/category_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category> _category = [];
  List<Category> _filteredCategory = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = '';

  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              final recipe = await ApiService().loadRandomRecipe();
              Navigator.pushNamed(context, "/details", arguments: recipe);
            },
            icon: Icon(Icons.shuffle, color: Colors.black),
            label: Text(
              'Random',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search categories by name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _filterCategories(value);
                    },
                  ),
                ),
                Expanded(
                  child: _filteredCategory.isEmpty && _searchQuery.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_off,
                                size: 66,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'No Category Found',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: _isSearching
                                    ? null
                                    : () async {
                                        await _searchCategoryByName(
                                          _searchQuery,
                                        );
                                      },
                                child: _isSearching
                                    ? const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Search in Api'),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CategoryGrid(category: _filteredCategory),
                        ),
                ),
              ],
            ),
    );
  }

  Future<void> _loadCategory() async {
    try {
      final categoryList = await _apiService.loadCategory();
      setState(() {
        _category = categoryList;
        _filteredCategory = categoryList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _category = [];
        _filteredCategory = [];
      });
    }
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategory = _category;
      } else {
        _filteredCategory = _category
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Future<void> _searchCategoryByName(String name) async {
    if (name.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    final category = await _apiService.searchCategoryByName(name);

    setState(() {
      _isSearching = false;
      if (category != null) {
        _filteredCategory = [category];
      } else {
        _filteredCategory = [];
      }
    });
  }
}

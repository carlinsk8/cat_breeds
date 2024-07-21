
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../shared/view_state.dart';
import '../../../settings/presentation/providers/setting_provider.dart';
import '../../domain/entities/breed.dart';
import '../../domain/entities/image_breed.dart';
import '../providers/breeds_provider.dart';
import '../widgets/title_cat_breeds.dart';
import 'detail_breed_page.dart';

class BreedsPage extends StatefulWidget {

  static const id = 'breeds_page';
  
  static Future<T?> pushNavigate<T extends Object?>(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      id,
      (route) => false,
    );
  }
  const BreedsPage({super.key});

  @override
  State<BreedsPage> createState() => _BreedsPageState();
}

class _BreedsPageState extends State<BreedsPage> {

  final List<Breed> _listBreed = [
  ];
  List<ImageBreed> _listImageBreed = [];
  int page = 0;
  final ScrollController _scrollController = ScrollController();
  Breed _selectedBreed = Breed(
    id: '0', 
    name: 'All',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<BreedsProvider>();
      await provider.getListBreed();
      await provider.getListImagesBreeds();
      setState(() {
        _listBreed.add(_selectedBreed);
        _listBreed.insertAll(1, provider.listBreed);
        
      });
      _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _nextDataPage();
      }
    });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BreedsProvider>(context);
    _listImageBreed = provider.listImageBreed;
    return ModalProgressHUD(
      inAsyncCall: provider.state is Loading,
      child: Scaffold(
        appBar: AppBar(
          title: const TitleCatBreeds(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Breeds',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 20,
                  ),
                  ..._listBreed.map((breed) => _itemBreed(breed)),
                ],
              
              ),
            ),
            Expanded(
              child: _listImages(_listImageBreed,provider),
            )
          ],
        ),
      ),
    );
  }

  
  Widget _listImages(List<ImageBreed> images, BreedsProvider provider) {
    if (provider.state is Loaded && images.isEmpty) {
      return const Center(child: Text('Beeds not found'));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: images.length,
        cacheExtent:200,
        itemBuilder: (context, index) {
          final size = getRandomSize();
          return InkWell(
            onTap: () {
              DetailBreedPage.pushNavigate(context, DetailBreedPageParams(imageBreed: images[index]));
            },
            child: Hero(
              tag: images[index].id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  maxHeightDiskCache: 200,
                  key: PageStorageKey(images[index].id), // Añadir la clave de almacenamiento de página
                  imageUrl: images[index].url,
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _itemBreed(Breed breed) {
    final isDark = context.watch<SettingProvider>().isDarkMode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBreed =breed;
          final provider = context.read<BreedsProvider>();
          page = 0;
          provider.getListImagesBreeds(breed.id=='0'?null:breed.id);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: _selectedBreed==breed?const Color(0xffffbc7a): Colors.grey[isDark?600:200],
        ),
        child: Text(
          breed.name,
          style: TextStyle(
            fontSize: _selectedBreed==breed?16:14,
            color: _selectedBreed==breed?Colors.white: Colors.black,
          ),
        )
      ),
    );
  }

Size getRandomSize() {
    final random = Random();
    final width = 50 + random.nextInt(50);
    final height = 100 + random.nextInt(100);
    return Size(width.toDouble(), height.toDouble());
  }
  
  Future<void> _nextDataPage() async {
    final provider = context.read<BreedsProvider>();
    if(provider.state is Loading) return;
    page = page+1;
    
    final res = await provider.getListImagesBreeds(_selectedBreed.id=='0'?null:_selectedBreed.id, page);
    if(res == 0) return;
    _scrollController.animateTo(
        _scrollController.offset + 10.0,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
  }
  
}
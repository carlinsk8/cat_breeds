import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/view_state.dart';
import '../../domain/entities/breed.dart';
import '../../domain/entities/image_breed.dart';
import '../providers/breeds_provider.dart';

class DetailBreedPageParams {
  final ImageBreed imageBreed;

  DetailBreedPageParams({required this.imageBreed});
}

class DetailBreedPage extends StatefulWidget {
  static const id = 'detail_breed_page';
  final DetailBreedPageParams params;

  static Future<T?> pushNavigate<T extends Object?>(
      BuildContext context, DetailBreedPageParams params) {
    return Navigator.pushNamed(context, id, arguments: params);
  }

  const DetailBreedPage({super.key, required this.params});

  @override
  State<DetailBreedPage> createState() => _DetailBreedPageState();
}

class _DetailBreedPageState extends State<DetailBreedPage> {
  
  Breed? _breed;

  TextStyle get kStyleUnderline => const TextStyle(
    color: Color.fromARGB(255, 171, 127, 83),
    fontSize: 16,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationColor: Color.fromARGB(255, 171, 127, 83),
  );

  @override
  void initState() {
    _breed = widget.params.imageBreed.breed.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BreedsProvider>();
    return ModalProgressHUD(
      inAsyncCall: provider.state is Loading,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.params.imageBreed.id,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(bottom: Radius.circular(50)),
                      child: CachedNetworkImage(
                        imageUrl: widget.params.imageBreed.url,
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 70,
                      child: const Icon(
                        Icons.wallet_membership_rounded,
                        size: 100,
                        color: Color(0xffffbc7a),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _breed?.name ?? '',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(_breed?.description ?? '', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      const Text('Temperament:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(_breed?.temperament ?? '', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Dog Friendly:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text('${_breed?.dogFriendly ?? ''}', style: const TextStyle(fontSize: 16)),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Child Friendly:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text('${_breed?.childFriendly ?? ''}', style: const TextStyle(fontSize: 16)),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                      _buildTextButton(
                        text: 'More information click here',
                        url: _breed?.cfaUrl,
                      ),
                      _buildTextButton(
                        text: 'Vetstreet click here',
                        url: _breed?.vetstreetUrl,
                      ),
                      _buildTextButton(
                        text: 'vcahospitals click here',
                        url: _breed?.vcahospitalsUrl,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton({required String text, String? url}) {
    return TextButton(
      onPressed: () {
        if (url != null) {
          _launchUrl(url);
        }
      },
      child: Text(
        text,
        style: kStyleUnderline,
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await canLaunchUrl(url)) {
      throw Exception('Could not launch $url');
    }
    await launchUrl(url);
  }
}
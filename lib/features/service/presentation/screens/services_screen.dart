import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  Position? _currentPosition;
  List<Map<String, dynamic>> _nearbyPlaces = [];
  String? _selectedServiceType;
  bool _isLoading = false;
  double _searchRadius = 80.0;
  bool _isDrawerOpen = false;
  String? _selectedPlacePhone;
  double? _selectedPlaceRating;

  // Filtreleme değişkenleri
  bool _isOpen = false;
  double _minRating = 0.0;
  String _sortBy = 'distance';
  bool _showFilters = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Acil',
      'icon': Icons.emergency,
      'color': Colors.red,
      'description': 'Acil durum hizmetleri',
      'services': [
        {
          'name': 'Hastane',
          'icon': Icons.local_hospital,
          'searchQuery': 'hastane acil servis sağlık merkezi',
          'description': '24 saat hizmet veren sağlık merkezleri',
        },
        {
          'name': 'Eczane',
          'icon': Icons.local_pharmacy,
          'searchQuery': 'nöbetçi eczane',
          'description': 'Açık eczaneler',
        },
        {
          'name': 'Polis',
          'icon': Icons.local_police,
          'searchQuery': 'polis karakolu emniyet',
          'description': 'Emniyet birimleri',
        },
        {
          'name': 'İtfaiye',
          'icon': Icons.fire_truck,
          'searchQuery': 'itfaiye istasyonu',
          'description': 'İtfaiye istasyonları',
        },
        {
          'name': 'Veteriner',
          'icon': Icons.pets,
          'searchQuery': 'acil veteriner kliniği',
          'description': 'Acil veteriner klinikleri',
        },
      ],
    },
    {
      'name': 'Araç',
      'icon': Icons.directions_car,
      'color': Colors.blue,
      'description': 'Araç bakım ve servis noktaları',
      'services': [
        {
          'name': 'TÜVTÜRK',
          'icon': Icons.car_repair,
          'searchQuery': 'tüvtürk araç muayene istasyonu',
          'description': 'Araç muayene istasyonları',
        },
        {
          'name': 'Oto Sanayi',
          'icon': Icons.precision_manufacturing,
          'searchQuery': 'sanayi',
          'description': 'Sanayi siteleri',
        },
        {
          'name': 'Lastikçi',
          'icon': Icons.tire_repair,
          'searchQuery': 'lastikçi',
          'description': 'Lastik servisleri',
        },
        {
          'name': 'Oto Servis',
          'icon': Icons.build,
          'searchQuery': 'oto tamirci',
          'description': 'Yetkili servisler',
        },
        {
          'name': 'Oto Yıkama',
          'icon': Icons.local_car_wash,
          'searchQuery': 'oto yıkama',
          'description': 'Araç yıkama',
        },
        {
          'name': 'Benzin',
          'icon': Icons.local_gas_station,
          'searchQuery': 'akaryakıt',
          'description': 'Akaryakıt istasyonları',
        },
        {
          'name': 'Oto Elektrik',
          'icon': Icons.electrical_services,
          'searchQuery': 'oto elektrikçi',
          'description': 'Elektrik servisleri',
        },
        {
          'name': 'Kaporta',
          'icon': Icons.car_crash,
          'searchQuery': 'oto kaporta',
          'description': 'Kaporta ve boya',
        },
      ],
    },
    {
      'name': 'Market',
      'icon': Icons.shopping_cart,
      'color': Colors.green,
      'description': 'Alışveriş noktaları',
      'services': [
        {
          'name': 'Market',
          'icon': Icons.local_grocery_store,
          'searchQuery': 'market OR süpermarket OR BİM OR A101 OR ŞOK OR Migros OR CarrefourSA OR tekel OR bakkal',
          'types': [
            'grocery_or_supermarket',
            'supermarket',
            'convenience_store',
            'store',
            'food'
          ],
          'radius': 20000, // 5km yarıçap
          'language': 'tr', // Türkçe sonuçlar için
          'openNow': true, // Şu anda açık olanlar
          'description': 'Tüm Marketler',
        },
        {
          'name': 'Manav',
          'icon': Icons.shopping_basket,
          'searchQuery': 'manav',
          'description': 'Manav & Şarküteri',
        },
        {
          'name': 'Fırın',
          'icon': Icons.bakery_dining,
          'searchQuery': 'fırın',
          'description': 'Fırın & Pastane',
        },
        {
          'name': 'Kasap',
          'icon': Icons.restaurant_menu,
          'searchQuery': 'kasap',
          'description': 'Et & Tavuk',
        },
        {
          'name': 'Balıkçı',
          'icon': Icons.set_meal,
          'searchQuery': 'balıkçı',
          'description': 'Balık marketleri',
        },
        {
          'name': 'Aktar',
          'icon': Icons.eco,
          'searchQuery': 'aktar',
          'description': 'Baharat & Kuruyemiş',
        },
      ],
    },
    {
      'name': 'Yemek',
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'description': 'Yeme & İçme mekanları',
      'services': [
        {
          'name': 'Restoran',
          'icon': Icons.restaurant,
          'searchQuery': 'restoran',
          'description': 'Restoranlar',
        },
        {
          'name': 'Cafe',
          'icon': Icons.local_cafe,
          'searchQuery': 'cafe',
          'description': 'Kafeler',
        },
        {
          'name': 'Fast Food',
          'icon': Icons.fastfood,
          'searchQuery': 'fast food',
          'description': 'Hızlı yemek',
        },
        {
          'name': 'Tatlıcı',
          'icon': Icons.icecream,
          'searchQuery': 'tatlıcı',
          'description': 'Tatlı & Dondurma',
        },
        {
          'name': 'Kahvaltı',
          'icon': Icons.free_breakfast,
          'searchQuery': 'kahvaltı',
          'description': 'Kahvaltı salonları',
        },
      ],
    },
    {
      'name': 'Sağlık',
      'icon': Icons.medical_services,
      'color': Colors.teal,
      'description': 'Sağlık hizmetleri',
      'services': [
        {
          'name': 'Diş',
          'icon': Icons.medical_services,
          'searchQuery': 'diş',
          'description': 'Diş klinikleri',
        },
        {
          'name': 'Optik',
          'icon': Icons.visibility,
          'searchQuery': 'optik ',
          'description': 'Gözlük & Lens',
        },
        {
          'name': 'Medikal',
          'icon': Icons.healing,
          'searchQuery': 'medikal ',
          'description': 'Medikal ürünler',
        },
      ],
    },
    {
      'name': 'Diğer',
      'icon': Icons.more_horiz,
      'color': Colors.purple,
      'description': 'Diğer hizmetler',
      'services': [
        {
          'name': 'ATM',
          'icon': Icons.atm,
          'searchQuery': 'atm',
          'description': 'ATM & Bankalar',
        },
        {
          'name': 'Kargo',
          'icon': Icons.local_shipping,
          'searchQuery': 'kargo',
          'description': 'Kargo şubeleri',
        },
        {
          'name': 'Kuaför',
          'icon': Icons.content_cut,
          'searchQuery': 'kuaför',
          'description': 'Güzellik salonları',
        },
        {
          'name': 'Eczane',
          'icon': Icons.local_pharmacy,
          'searchQuery': 'eczane',
          'description': 'Eczaneler',
        },
        {
          'name': 'Spor',
          'icon': Icons.fitness_center,
          'searchQuery': 'spor',
          'description': 'Spor salonları',
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchRadius = 80.0;
    _setupLocationStream();
  }

  StreamSubscription<Position>? _positionStream;

  void _setupLocationStream() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _searchNearbyPlaces();
    });

    // İlk konumu al
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );

      setState(() {
        _currentPosition = position;
      });

      await _searchNearbyPlaces();
    } catch (e) {
      print('Konum hatası: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _searchNearbyPlaces() async {
    if (_currentPosition == null || _isLoading || _selectedServiceType == null)
      return;

    setState(() {
      _isLoading = true;
      _nearbyPlaces = []; // Listeyi temizle
    });

    try {
      // API anahtarını kontrol et
      final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API anahtarı bulunamadı');
      }

      Map<String, dynamic>? selectedCategory;
      Map<String, dynamic>? selectedService;

      for (var category in _categories) {
        final services = category['services'] as List<dynamic>;
        final serviceIndex = services.indexWhere(
          (service) => service['name'] == _selectedServiceType,
        );

        if (serviceIndex != -1) {
          selectedCategory = category;
          selectedService = services[serviceIndex] as Map<String, dynamic>;
          break;
        }
      }

      // Eğer kategori veya servis bulunamazsa işlemi sonlandır
      if (selectedCategory == null || selectedService == null) return;

      final searchQuery = selectedService['searchQuery'] as String;

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${_currentPosition!.latitude},${_currentPosition!.longitude}'
        '&rankby=distance'
        '&keyword=${Uri.encodeComponent(searchQuery)}'
        '${selectedService['types'] != null ? '&type=${(selectedService['types'] as List<String>).join('|')}' : ''}'
        '&language=tr'
        '&region=tr'
        '&components=country:tr'
        '${_isOpen ? '&opennow=true' : ''}'
        '&key=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'REQUEST_DENIED') {
          throw Exception('Google Maps API faturalandırması etkinleştirilmemiş. Lütfen Google Cloud konsolundan faturalandırmayı etkinleştirin.');
        }

        if (data['status'] == 'ZERO_RESULTS') {
          setState(() {
            _nearbyPlaces = [];
          });
          if (mounted) {
            _showServiceResults(context);
          }
          return;
        }

        if (data['status'] != 'OK') {
          throw Exception(
              'API Hatası: ${data['status']} - ${data['error_message'] ?? 'Bilinmeyen hata'}');
        }

        final results = data['results'] as List;
        if (results.isEmpty) {
          if (mounted) {
            _showServiceResults(context);
          }
          return;
        }

        final places = results.map((place) {
          final location = place['geometry']['location'];
          final lat = location['lat'] as double;
          final lng = location['lng'] as double;

          final distance = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            lat,
            lng,
          );

          return {
            'name': place['name'],
            'vicinity': place['vicinity'],
            'distance': distance,
            'lat': lat,
            'lng': lng,
            'rating': place['rating'] != null
                ? (place['rating'] as num).toDouble()
                : null,
            'user_ratings_total': place['user_ratings_total'] as int?,
            'place_id': place['place_id'],
            'opening_hours': place['opening_hours'],
          };
        }).where((place) {
          final rating = place['rating'] as double?;
          return rating == null || rating >= _minRating;
        }).toList();

        // Sıralama
        places.sort((a, b) {
          if (_sortBy == 'distance') {
            return (a['distance'] as double).compareTo(b['distance'] as double);
          } else {
            final aRating = a['rating'] as double? ?? 0;
            final bRating = b['rating'] as double? ?? 0;
            if (aRating == bRating) {
              return (a['distance'] as double)
                  .compareTo(b['distance'] as double);
            }
            return bRating.compareTo(aRating);
          }
        });

        setState(() {
          _nearbyPlaces = places.take(10).toList();
        });

        if (mounted) {
          _showServiceResults(context);
        }
      }
    } catch (e) {
      print('API Hatası: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        
        String errorMessage = 'Bir hata oluştu';
        if (e.toString().contains('faturalandırma') || e.toString().contains('billing')) {
          errorMessage = 'Google Maps servislerini kullanabilmek için Google Cloud Console\'da faturalandırmayı etkinleştirmeniz gerekiyor. Detaylar için geliştiricinize başvurun.';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              label: 'Tamam',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=formatted_phone_number,rating,reviews,opening_hours,website,price_level'
      '&language=tr'
      '&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final result = data['result'];

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        if (result['formatted_phone_number'] != null) ...[
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(
                                result['formatted_phone_number'] as String),
                            trailing: IconButton(
                              icon: const Icon(Icons.call),
                              onPressed: () => _launchPhoneCall(
                                  result['formatted_phone_number'] as String),
                            ),
                          ),
                          const Divider(),
                        ],
                        if (result['website'] != null) ...[
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: Text(result['website'] as String),
                            trailing: IconButton(
                              icon: const Icon(Icons.open_in_new),
                              onPressed: () => launchUrl(
                                  Uri.parse(result['website'] as String)),
                            ),
                          ),
                          const Divider(),
                        ],
                        if (result['opening_hours']?['weekday_text'] !=
                            null) ...[
                          const ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text('Çalışma Saatleri'),
                          ),
                          ...List.generate(
                            (result['opening_hours']['weekday_text'] as List)
                                .length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Text(result['opening_hours']
                                  ['weekday_text'][index] as String),
                            ),
                          ),
                          const Divider(),
                        ],
                        if (result['price_level'] != null) ...[
                          ListTile(
                            leading: const Icon(Icons.attach_money),
                            title: Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.attach_money,
                                  size: 16,
                                  color: index < (result['price_level'] as int)
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                        if (result['reviews'] != null) ...[
                          const ListTile(
                            leading: Icon(Icons.rate_review),
                            title: Text('Değerlendirmeler'),
                          ),
                          ...(result['reviews'] as List)
                              .map((review) => Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                review['author_name'] as String,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: List.generate(
                                                  5,
                                                  (index) => Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: index <
                                                            (review['rating']
                                                                as int)
                                                        ? Colors.amber
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(review['text'] as String),
                                          const SizedBox(height: 4),
                                          Text(
                                            review['relative_time_description']
                                                as String,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Yer detayları hatası: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchNavigationUrl(String placeId, String title) async {
    if (_currentPosition == null) return;

    final url = Uri.parse(
      Platform.isIOS
          ? 'comgooglemaps://?saddr=${_currentPosition!.latitude},${_currentPosition!.longitude}'
              '&daddr=${Uri.encodeComponent(title)}'
              '&directionsmode=driving'
          : 'https://www.google.com/maps/dir/?api=1'
              '&origin=${_currentPosition!.latitude},${_currentPosition!.longitude}'
              '&destination=${Uri.encodeComponent(title)}'
              '&destination_place_id=$placeId'
              '&travelmode=driving',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final fallbackUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(title)}');

      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Navigasyon başlatılamadı'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Arama yapılamadı.'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m';
    } else {
      final km = meters / 1000;
      final minutes = (km * 2).round(); // Ortalama 30 km/saat hız varsayımı
      return '${km.toStringAsFixed(1)} km • ${minutes} dk';
    }
  }

  Widget _buildFilterBar(Color color, Color textColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _showFilters ? 80 : 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isOpen ? Icons.check_circle : Icons.circle_outlined,
                        size: 18,
                        color: _isOpen ? Colors.white : color,
                      ),
                      const SizedBox(width: 4),
                      Text('Açık'),
                    ],
                  ),
                  selected: _isOpen,
                  onSelected: (value) {
                    setState(() {
                      _isOpen = value;
                    });
                    _searchNearbyPlaces();
                  },
                  selectedColor: color,
                  checkmarkColor: Colors.white,
                  backgroundColor: color.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: _minRating > 0 ? Colors.white : Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text('${_minRating.toStringAsFixed(1)}+'),
                    ],
                  ),
                  selected: _minRating > 0,
                  onSelected: (value) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Minimum Puan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            StatefulBuilder(
                              builder: (context, setState) => Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      5,
                                      (index) => IconButton(
                                        icon: Icon(
                                          index < _minRating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _minRating = index + 1.0;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _searchNearbyPlaces();
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: color,
                                    ),
                                    child: const Text('Uygula'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  selectedColor: Colors.amber,
                  checkmarkColor: Colors.white,
                  backgroundColor: Colors.amber.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _sortBy == 'distance'
                            ? Icons.directions_car
                            : Icons.star,
                        size: 18,
                        color: color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _sortBy == 'distance' ? 'Mesafe' : 'Puan',
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  selected: false,
                  onSelected: (value) {
                    setState(() {
                      _sortBy = _sortBy == 'distance' ? 'rating' : 'distance';
                      if (_nearbyPlaces.isNotEmpty) {
                        _nearbyPlaces.sort((a, b) {
                          if (_sortBy == 'distance') {
                            return (a['distance'] as double)
                                .compareTo(b['distance'] as double);
                          } else {
                            final aRating = a['rating'] as double? ?? 0;
                            final bRating = b['rating'] as double? ?? 0;
                            return bRating.compareTo(aRating);
                          }
                        });
                      }
                    });
                  },
                  backgroundColor: color.withOpacity(0.1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceResults(BuildContext context) {
    if (!mounted || _selectedServiceType == null) return;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.grey[800];
    final subtextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    // Kategori ve servisi bul
    Map<String, dynamic>? selectedCategory;
    Map<String, dynamic>? selectedService;

    for (var category in _categories) {
      final services = category['services'] as List<dynamic>;
      final serviceIndex = services.indexWhere(
        (service) => service['name'] == _selectedServiceType,
      );

      if (serviceIndex != -1) {
        selectedCategory = category;
        selectedService = services[serviceIndex] as Map<String, dynamic>;
        break;
      }
    }

    // Eğer kategori veya servis bulunamazsa işlemi sonlandır
    if (selectedCategory == null || selectedService == null) return;

    // Önceki bottom sheet'i kapat
    Navigator.of(context).popUntil((route) => route.isFirst);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (selectedCategory?['color'] as Color)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      selectedService!['icon'] as IconData,
                      color: selectedCategory!['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedService['name'] as String,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          selectedService['description'] as String,
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isOpen = !_isOpen;
                      });
                      _searchNearbyPlaces();
                    },
                    icon: Icon(
                      _isOpen ? Icons.visibility : Icons.visibility_off,
                      color: textColor,
                    ),
                    tooltip: _isOpen
                        ? 'Tüm yerleri göster'
                        : 'Sadece açık yerleri göster',
                  ),
                ],
              ),
            ),
            Expanded(
              child: _nearbyPlaces.isEmpty && !_isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color:
                                  selectedCategory['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              selectedService['icon'] as IconData,
                              size: 48,
                              color: selectedCategory['color'] as Color,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Yakında $_selectedServiceType bulunamadı',
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Farklı bir konum veya arama yarıçapı deneyin',
                            style: TextStyle(
                              fontSize: 14,
                              color: subtextColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _nearbyPlaces.length,
                      itemBuilder: (context, index) {
                        final place = _nearbyPlaces[index];
                        final distance = place['distance'] as double;
                        final isOpen =
                            place['opening_hours']?['open_now'] as bool? ??
                                false;
                        final rating = place['rating'] as double?;
                        final userRatingsTotal =
                            place['user_ratings_total'] as int?;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isDark
                                  ? Colors.grey[700]!
                                  : Colors.grey[200]!,
                            ),
                          ),
                          child: InkWell(
                            onTap: () =>
                                _getPlaceDetails(place['place_id'] as String),
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              place['name'] as String,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                              ),
                                            ),
                                            if (place['vicinity'] != null) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                place['vicinity'] as String,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: subtextColor,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isOpen
                                                  ? Colors.green.withOpacity(
                                                      isDark ? 0.2 : 0.1)
                                                  : Colors.red.withOpacity(
                                                      isDark ? 0.2 : 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              isOpen ? 'Açık' : 'Kapalı',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: isOpen
                                                    ? isDark
                                                        ? Colors.green[400]
                                                        : Colors.green[700]
                                                    : isDark
                                                        ? Colors.red[400]
                                                        : Colors.red[700],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            _formatDistance(distance),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (rating != null &&
                                      userRatingsTotal != null) ...[
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.amber.withOpacity(
                                                isDark ? 0.2 : 0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                size: 16,
                                                color: isDark
                                                    ? Colors.amber[400]
                                                    : Colors.amber[700],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                rating.toStringAsFixed(1),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: isDark
                                                      ? Colors.amber[400]
                                                      : Colors.amber[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '($userRatingsTotal değerlendirme)',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: subtextColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton.icon(
                                          onPressed: () => _launchNavigationUrl(
                                            place['place_id'] as String,
                                            place['name'] as String,
                                          ),
                                          icon: const Icon(Icons.directions),
                                          label: const Text('Yol Tarifi'),
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                selectedCategory!['color']
                                                    as Color,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                color:
                                                    (selectedCategory['color']
                                                            as Color)
                                                        .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.grey[50];
    final surfaceColor = isDark ? Colors.grey[900] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.grey[900];

    // API bilgisini kontrol et
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final isApiConfigured = apiKey != null && apiKey.isNotEmpty;

    // Eğer API yapılandırılmadıysa veya geçersizse, farklı bir UI göster
    if (!isApiConfigured) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Google Maps API Yapılandırılmamış',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bu özelliği kullanabilmek için bir Google Maps API anahtarına ve etkin bir Google Cloud faturalandırma hesabına ihtiyacınız vardır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor?.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Ana Sayfaya Dön'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Seçili kategori null olabilir
    Map<String, dynamic>? selectedCategory;
    if (_selectedServiceType != null) {
      for (var category in _categories) {
        for (var service in category['services'] as List<dynamic>) {
          if (service['name'] == _selectedServiceType) {
            selectedCategory = category;
            break;
          }
        }
        if (selectedCategory != null) break;
      }
    }

    // Eğer selectedCategory null ise varsayılan renk kullan
    final categoryColor = selectedCategory?['color'] as Color? ?? Colors.blue;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Row(
                children: [
                  Text(
                    'Torpido',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  if (_selectedServiceType != null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showFilters = !_showFilters;
                        });
                      },
                      icon: Icon(
                        _showFilters
                            ? Icons.filter_list_off
                            : Icons.filter_list,
                        color: textColor,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: surfaceColor,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                ],
              ),
            ),

            // Filtreler
            if (_showFilters &&
                _selectedServiceType != null &&
                selectedCategory != null)
              _buildFilterBar(categoryColor, textColor!),

            // Categories
            SizedBox(
              height: 120,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedServiceType != null &&
                      category['services'].any(
                          (service) => service['name'] == _selectedServiceType);

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      color: isSelected
                          ? category['color'] as Color
                          : surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      elevation: isSelected ? 4 : 0,
                      child: InkWell(
                        onTap: () {
                          final firstService = category['services'][0];
                          setState(() {
                            _selectedServiceType =
                                firstService['name'] as String;
                            _showFilters = false;
                          });
                          _searchNearbyPlaces();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                category['icon'] as IconData,
                                color: isSelected
                                    ? Colors.white
                                    : category['color'] as Color,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category['name'] as String,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Services Grid
            if (_selectedServiceType != null && selectedCategory != null)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                          child: Row(
                            children: [
                              Text(
                                selectedCategory['name'] as String,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: categoryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${(selectedCategory['services'] as List).length} servis',
                                  style: TextStyle(
                                    color: categoryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount:
                                (selectedCategory['services'] as List).length,
                            itemBuilder: (context, index) {
                              final service = (selectedCategory?['services']
                                  as List)[index] as Map<String, dynamic>;
                              final isSelected =
                                  service['name'] == _selectedServiceType;

                              return Material(
                                color: isSelected
                                    ? categoryColor
                                    : isDark
                                        ? Colors.grey[850]
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                elevation: isSelected ? 4 : 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedServiceType =
                                          service['name'] as String;
                                    });
                                    _searchNearbyPlaces();
                                    _showServiceResults(context);
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.white.withOpacity(0.2)
                                                : categoryColor
                                                    .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            service['icon'] as IconData,
                                            size: 28,
                                            color: isSelected
                                                ? Colors.white
                                                : categoryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          service['name'] as String,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected
                                                ? Colors.white
                                                : textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
}

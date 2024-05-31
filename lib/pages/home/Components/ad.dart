import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdSense extends StatefulWidget {
  const AdSense({super.key});

  final adUnitId = "ca-app-pub-2693781689201415/1901299986";
  final adSize = const AdSize(width: 200, height: 200);

  @override
  State<AdSense> createState() => _AdSenseState();
}

class _AdSenseState extends State<AdSense> {
  late BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        // ignore: unnecessary_null_comparison
        child: _bannerAd == null ? const SizedBox() : AdWidget(ad: _bannerAd!),
      ),
    );
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}

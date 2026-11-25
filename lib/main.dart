import 'package:kisisel_motoru/kisisel_motoru.dart';
import 'package:flutter/material.dart';
import 'package:studio_core/apps/apps.dart';
import 'package:uyg_bildirim_ve_zil_sesi_paketi/uyg_bildirim_ve_zil_sesi_paketi.dart';
import 'package:uyg_canli_duvar_kagidi/uyg_canli_duvar_kagidi.dart';
import 'package:uyg_kilit_ekrani_saati/uyg_kilit_ekrani_saati.dart';
import 'package:uyg_ozgun_ikon_paketi/uyg_ozgun_ikon_paketi.dart';
import 'package:uyg_widget_paketi/uyg_widget_paketi.dart';

/// Kişiselleştirme: 5 çevrimdışı araç tek uygulamada. Her aracın verisi
/// ayrı saklanır; reklam yalnızca bir araçtan çıkarken ve en az 3 dakika
/// arayla gösterilir.
final hubConfig = AppHubConfig(
  hubId: 'merkez-kisisellestirme',
  title: kisiselHubTitle,
  tagline: kisiselHubTagline,
  icon: Icons.palette_rounded,
  style: kisiselHubStyle,
  categories: kisiselCategories,
  tools: [
    canliDuvarKagidiTool,
    widgetPaketiTool,
    ozgunIkonPaketiTool,
    bildirimVeZilSesiPaketiTool,
    kilitEkraniSaatiTool,
  ],
  featured: kisiselFeatured,
  privacyUrl: 'https://github.com/taktemurr-ops/merkez-kisisellestirme/blob/main/PRIVACY.md',
);

void main() => bootstrapAppHub(hubConfig);

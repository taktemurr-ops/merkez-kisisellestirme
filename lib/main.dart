import 'package:kisisel_motoru/kisisel_motoru.dart';
import 'package:flutter/material.dart';
import 'package:studio_core/apps/apps.dart';
import 'package:uyg_arama_flasi/uyg_arama_flasi.dart';
import 'package:uyg_bildirim_ve_zil_sesi_paketi/uyg_bildirim_ve_zil_sesi_paketi.dart';
import 'package:uyg_canli_duvar_kagidi/uyg_canli_duvar_kagidi.dart';
import 'package:uyg_dinamik_ada/uyg_dinamik_ada.dart';
import 'package:uyg_estetik_ana_ekran/uyg_estetik_ana_ekran.dart';
import 'package:uyg_her_zaman_acik_ekran/uyg_her_zaman_acik_ekran.dart';
import 'package:uyg_kenar_isiklandirma/uyg_kenar_isiklandirma.dart';
import 'package:uyg_kilit_ekrani_saati/uyg_kilit_ekrani_saati.dart';
import 'package:uyg_ozgun_ikon_paketi/uyg_ozgun_ikon_paketi.dart';
import 'package:uyg_renk_paleti_uretici/uyg_renk_paleti_uretici.dart';
import 'package:uyg_sarj_animasyonu/uyg_sarj_animasyonu.dart';
import 'package:uyg_sik_yazi_uretici/uyg_sik_yazi_uretici.dart';
import 'package:uyg_widget_paketi/uyg_widget_paketi.dart';
import 'store_flavor.dart';

/// Kişiselleştirme: 13 çevrimdışı araç tek uygulamada. Her aracın verisi
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
    renkPaletiUreticiTool,
    sikYaziUreticiTool,
    kenarIsiklandirmaTool,
    sarjAnimasyonuTool,
    dinamikAdaTool,
    herZamanAcikEkranTool,
    aramaFlasiTool,
    estetikAnaEkranTool,
  ],
  featured: kisiselFeatured,
  privacyUrl: 'https://github.com/taktemurr-ops/merkez-kisisellestirme/blob/main/PRIVACY.md',
);

void main() {
  registerStoreFlavor();
  bootstrapAppHub(hubConfig);
}

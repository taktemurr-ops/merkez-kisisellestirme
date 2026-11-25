# Kişiselleştirme · Personalize (merkez-kisisellestirme)

Kişiselleştirme ailesinin **merkez uygulaması**: 5 çevrimdışı aracı tek uygulamada toplar.
Görünüm oyun merkezlerinin onaylı tasarım dilini izler (koyu degrade zemin, "5 Uygulama",
yuvarlak arama, vurgu çerçeveli kutular). Alt gezinme: Ana Sayfa · Uygulamalar · Favoriler · Profil.

- Çatı: [studio-core](https://github.com/taktemurr-ops/studio-core) `lib/apps` · Motor: [kisisel-motoru](https://github.com/taktemurr-ops/kisisel-motoru)
- 33 dil · telefon, tablet, web · çevrimdışı
- Reklamsız / Premium satın alma; ödüllü reklam isteğe bağlı ekstralar için; geçiş reklamı yalnızca
  bir araçtan çıkarken ve en az 3 dakika arayla.
- Play politikası (PLAN.md §6): kilit ekranı değiştirilmez → "Şarj saati (ekran koruyucu)";
  ikon paketi yalnız genel kategori ikonları (appfilter/marka eşlemesi yok); zil sesi atanmaz, WAV kaydedilir.
- Bu sürümde yerel (Kotlin/Swift) kod gerektiren parçalar yok: sistem canlı duvar kağıdı (WallpaperService),
  ana ekran widget'ı (AppWidget/WidgetKit), DreamService. Ayrıntı: kisisel-motoru README.
- İzinler: yok (kamera, konum, depolama, WRITE_SETTINGS istenmez).

| Araç | Depo |
|---|---|
| Canlı Duvar Kağıdı | [uyg-canli-duvar-kagidi](https://github.com/taktemurr-ops/uyg-canli-duvar-kagidi) |
| Widget Paketi | [uyg-widget-paketi](https://github.com/taktemurr-ops/uyg-widget-paketi) |
| Özgün İkon Paketi | [uyg-ozgun-ikon-paketi](https://github.com/taktemurr-ops/uyg-ozgun-ikon-paketi) |
| Bildirim ve Zil Sesi Paketi | [uyg-bildirim-ve-zil-sesi-paketi](https://github.com/taktemurr-ops/uyg-bildirim-ve-zil-sesi-paketi) |
| Şarj Saati (Ekran Koruyucu) | [uyg-kilit-ekrani-saati](https://github.com/taktemurr-ops/uyg-kilit-ekrani-saati) |

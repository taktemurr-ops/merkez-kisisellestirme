# iOS ana ekran widget'ları (WidgetKit)

Android'de widget'lar uygulamayla birlikte gelir (kisisel-motoru eklentisi).
iOS'ta widget'lar ayrı bir **uzantı hedefi** ister ve bu hedef, Apple
Developer hesabında **App Group** açılmadan imzalanamaz. Bu yüzden kaynaklar
hazırdır, hedef isteğe bağlı eklenir.

## İçerik
- `KisiselWidgets/KisiselWidgets.swift` – 5 widget (saat, tarih, geri sayım,
  not, pil). Uygulamadaki panonun her türünün ilk kutucuğunu, aynı renklerle gösterir.
- `KisiselWidgets/<dil>.lproj/Localizable.strings` – 33 dilde widget adları
  (`proto/apps/kisisel/mkios_widget.py` üretir).
- `Info.plist`, `KisiselWidgets.entitlements`, `../Runner.entitlements` – App Group
  `group.com.gamestudio100.kisisel` (Dart: `kIosAppGroup`).

## Açmak için
1. Apple Developer → Identifiers: uygulama kimliği ve
   `<uygulama kimliği>.KisiselWidgets` için **App Groups** yeteneğini açın,
   `group.com.gamestudio100.kisisel` grubunu ikisine de ekleyin.
2. GitHub → Settings → Variables → `KISISEL_IOS_WIDGET` = `1`.
   iOS iş akışı `tool/add_ios_widget.rb` ile hedefi otomatik ekler.
   (Elle: `gem install xcodeproj && ruby tool/add_ios_widget.rb`, ya da Xcode'da
   File → New → Target → Widget Extension ve bu klasördeki dosyalar.)
3. Uygulama, widget aracı açıldığında ve pano değiştiğinde verileri
   `HomeWidget.saveWidgetData` ile yazar, `KisiselWidgets.<tür>` widget'larını yeniler.

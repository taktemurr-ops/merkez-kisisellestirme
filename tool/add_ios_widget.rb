# iOS WidgetKit uzantısını (ios_widget/KisiselWidgets) `flutter create` ile
# oluşturulan Runner projesine ekler. İsteğe bağlıdır: ios.yml'de
# vars.KISISEL_IOS_WIDGET == '1' ise çalışır (App Group'un Apple Developer
# hesabında açılmış olması gerekir; bkz. ios_widget/README.md).
# Kullanım: gem install xcodeproj && ruby tool/add_ios_widget.rb
require 'fileutils'
require 'xcodeproj'

NAME = 'KisiselWidgets'
proj = Xcodeproj::Project.open('ios/Runner.xcodeproj')
if proj.targets.any? { |t| t.name == NAME }
  puts 'Widget hedefi zaten var.'
  exit 0
end

FileUtils.rm_rf("ios/#{NAME}")
FileUtils.cp_r("ios_widget/#{NAME}", "ios/#{NAME}")
FileUtils.cp('ios_widget/Runner.entitlements', 'ios/Runner/Runner.entitlements')

app = proj.targets.find { |t| t.name == 'Runner' }
app_id = app.build_configurations.first.build_settings['PRODUCT_BUNDLE_IDENTIFIER']
ext = proj.new_target(:app_extension, NAME, :ios, '14.0')

group = proj.main_group.new_group(NAME, NAME)
group.new_file('KisiselWidgets.swift').tap { |f| ext.add_file_references([f]) }
group.new_file('Info.plist')
group.new_file('KisiselWidgets.entitlements')
variant = group.new_variant_group('Localizable.strings')
Dir.glob("ios/#{NAME}/*.lproj").sort.each do |dir|
  lang = File.basename(dir, '.lproj')
  variant.new_reference("#{lang}.lproj/Localizable.strings").tap { |r| r.name = lang }
end
ext.resources_build_phase.add_file_reference(variant)
ext.add_system_framework(%w[WidgetKit SwiftUI])

ext.build_configurations.each do |c|
  s = c.build_settings
  s['PRODUCT_BUNDLE_IDENTIFIER'] = "#{app_id}.#{NAME}"
  s['PRODUCT_NAME'] = '$(TARGET_NAME)'
  s['INFOPLIST_FILE'] = "#{NAME}/Info.plist"
  s['CODE_SIGN_ENTITLEMENTS'] = "#{NAME}/#{NAME}.entitlements"
  s['SWIFT_VERSION'] = '5.0'
  s['TARGETED_DEVICE_FAMILY'] = '1,2'
  s['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
  s['SKIP_INSTALL'] = 'YES'
  s['GENERATE_INFOPLIST_FILE'] = 'NO'
  s['LD_RUNPATH_SEARCH_PATHS'] = ['$(inherited)', '@executable_path/Frameworks', '@executable_path/../../Frameworks']
end
app.build_configurations.each do |c|
  c.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Runner.entitlements'
end

app.add_dependency(ext)
embed = app.new_copy_files_build_phase('Embed App Extensions')
embed.dst_subfolder_spec = '13' # PlugIns
embed.add_file_reference(ext.product_reference).settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
# Flutter'ın "Thin Binary" betiğiyle döngüyü önlemek için kaynaklardan hemen sonra.
app.build_phases.delete(embed)
app.build_phases.insert(app.build_phases.index(app.resources_build_phase) + 1, embed)

proj.save
puts "Widget hedefi eklendi: #{app_id}.#{NAME}"

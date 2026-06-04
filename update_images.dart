import 'dart:io';

void main() async {
  final imageDir = Directory('assets/images');
  final files = await imageDir.list().toList();
  
  final Map<String, List<String>> prefixMap = {};
  for (var file in files) {
    if (file is File) {
      final name = file.uri.pathSegments.last;
      final match = RegExp(r'^(.+)_[1-6]\.(jpg|jpeg|png)$').firstMatch(name);
      if (match != null) {
        final prefix = match.group(1)!;
        if (!prefixMap.containsKey(prefix)) prefixMap[prefix] = [];
        prefixMap[prefix]!.add('assets/images/$name');
      }
    }
  }
  
  for (var prefix in prefixMap.keys) {
    prefixMap[prefix]!.sort();
  }

  final idMapping = {
    '1': 'desa_penglipuran',
    '2': 'desa_sade',
    '4': 'desa_legung',
    '5': 'desa_trunyan',
    '6': 'desa_ratenggaro',
    '7': 'desa_wae_rebo',
    '8': 'desa_baduy_dalam',
    '9': 'desa_kete_kesu',
    '10': 'desa_sawai',
    '11': 'desa_pariangan',
    '13': 'kampung_naga',
    '14': 'desa_kasongan',
    '15': 'desa_bawomataluo',
    '16': 'desa_sangeh',
    '17': 'kintamani',
    '18': 'desa_ponggok',
    '19': 'rammang_rammang',
    '20': 'kampung_cyber',
    '21': 'desa_bena',
    '22': 'desa_argapura'
  };

  Future<void> processFile(String path) async {
    final file = File(path);
    var content = await file.readAsString();
    
    for (var id in idMapping.keys) {
      final prefix = idMapping[id]!;
      final imageList = prefixMap[prefix];
      if (imageList == null || imageList.isEmpty) {
        continue;
      }
      final firstImage = imageList.first;
      
      final regex = RegExp(r"(id:\s*'" + id + r"'[\s\S]*?)imagePath:\s*'.*?'([\s\S]*?)gallery:\s*\[[\s\S]*?\]\s*,", multiLine: true);
      
      content = content.replaceAllMapped(regex, (match) {
        final newGallery = "gallery: [\n" + imageList.map((i) => "        '$i',").join("\n") + "\n      ],";
        return "${match.group(1)}imagePath: '$firstImage'${match.group(2)}$newGallery";
      });
    }
    await file.writeAsString(content);
    print('Updated $path');
  }

  await processFile('lib/data/app_data_id.dart');
  await processFile('lib/data/app_data_en.dart');
}
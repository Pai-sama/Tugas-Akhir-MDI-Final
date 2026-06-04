const fs = require('fs');
const path = require('path');

const idFile = 'd:/Hidden gem village/lib/data/app_data_id.dart';
const enFile = 'd:/Hidden gem village/lib/data/app_data_en.dart';

function updateFile(filePath, replacements) {
    let content = fs.readFileSync(filePath, 'utf8');
    
    const regex = /    Village\(\s*id: '13'[\s\S]*?isFeatured: false,\s*\),\s*\];/g;
    
    content = content.replace(regex, replacements + '\n];');
    
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('Updated ' + filePath);
}

const newVillagesId = `    Village(
      id: '13',
      name: 'Kampung Naga',
      location: 'Salawu, Tasikmalaya, Jawa Barat',
      province: 'Jawa Barat',
      category: 'Desa Adat',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Sunda', 'Tradisional', 'Anti-Modernisasi'],
      description: 'Kampung Naga adalah kampung adat Sunda yang terkenal karena tetap mempertahankan gaya hidup tradisional di tengah modernisasi. Kampung ini berada di lembah hijau dekat Sungai Ciwulan dan sering dianggap sebagai salah satu komunitas adat Sunda paling terjaga di Indonesia.\\n\\nMasyarakat Kampung Naga adalah keturunan Sunda yang sangat menjaga adat leluhur, pola hidup sederhana, dan keseimbangan alam. Semua rumah di Kampung Naga memiliki bentuk hampir seragam, berupa rumah panggung berdinding anyaman bambu, beratap ijuk atau nipah, dan dicat putih dengan detail hitam. Kampung Naga terkenal karena membatasi penggunaan teknologi tertentu demi menjaga tradisi.\\n\\nMayoritas masyarakat bekerja sebagai petani, pengrajin, dan pedagang kecil. Masyarakat terkenal hidup sederhana dan sangat menjunjung gotong royong, musyawarah, dan hubungan kekeluargaan. Masyarakat Kampung Naga memegang prinsip: hidup sederhana, menjaga alam, dan tidak berlebihan dalam membangun kehidupan.',
      historyTimeline: [
        TimelineEvent(
          era: 'TAHUN 1956',
          description: 'Kampung ini pernah mengalami kebakaran besar dan kemudian dibangun kembali dengan bentuk tradisional yang sama persis.',
        ),
        TimelineEvent(
          era: 'MASA KINI',
          description: 'Masyarakat masih dipimpin oleh tokoh adat dan tetap mempertahankan tradisi di tengah gempuran modernisasi.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Gaya Hidup Sederhana',
          description: 'Masyarakat sangat menjaga adat leluhur, pola hidup sederhana, dan keseimbangan alam. Menolak modernisasi dan membatasi penggunaan teknologi tertentu.',
        ),
        CultureItem(
          title: 'Rumah Panggung Seragam',
          description: 'Semua rumah berbentuk rumah panggung berdinding anyaman bambu, beratap ijuk, dan dicat putih dengan detail hitam.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '14',
      name: 'Desa Kasongan',
      location: 'Bantul, Daerah Istimewa Yogyakarta',
      province: 'Daerah Istimewa Yogyakarta',
      category: 'Desa Adat',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.7,
      tags: ['Seni', 'Gerabah', 'Desa Wisata'],
      description: 'Desa Kasongan adalah desa wisata seni yang terkenal sebagai pusat kerajinan gerabah dan keramik terbesar di Yogyakarta. Desa ini dikenal karena hampir seluruh masyarakatnya memiliki keterampilan membuat kerajinan tanah liat yang telah diwariskan turun-temurun.\\n\\nSaat memasuki desa, pengunjung akan melihat galeri gerabah, toko seni, workshop keramik, dan deretan patung tanah liat di sepanjang jalan. Sebagian pengrajin masih menggunakan teknik tradisional: membentuk tanah liat dengan tangan, menggunakan alat putar sederhana, lalu dibakar dalam tungku khusus.\\n\\nKasongan bukan hanya tempat belanja kerajinan, tetapi juga wisata edukasi. Pengunjung bisa melihat proses pembuatan gerabah, mencoba membuat keramik sendiri, belajar membentuk tanah liat, dan mengikuti workshop seni.',
      historyTimeline: [
        TimelineEvent(
          era: 'AWAL MULA',
          description: 'Pada masa kolonial Belanda, warga beralih membuat gerabah dari tanah liat untuk bertahan hidup karena takut kehilangan ternak.',
        ),
        TimelineEvent(
          era: 'TAHUN 1970-AN',
          description: 'Seniman dan desainer mulai membantu memperkenalkan gerabah Kasongan ke pasar nasional dan internasional.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Kerajinan Gerabah',
          description: 'Keterampilan membuat kerajinan tanah liat yang telah diwariskan turun-temurun menggunakan teknik tradisional tangan dan alat putar sederhana.',
        ),
        CultureItem(
          title: 'Galeri Seni Terbuka',
          description: 'Sepanjang jalan desa dipenuhi oleh galeri gerabah, toko seni, workshop keramik, dan deretan patung tanah liat.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '15',
      name: 'Desa Bawomataluo',
      location: 'Fanayama, Nias Selatan, Sumatera Utara',
      province: 'Sumatera Utara',
      category: 'Desa Adat',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.9,
      tags: ['Lompat Batu', 'Nias', 'Megalitik'],
      description: 'Desa Bawomataluo adalah desa adat terkenal di Pulau Nias yang dikenal karena tradisi lompat batu, rumah adat megah, dan budaya perang suku yang masih terasa kuat dalam identitas masyarakatnya. Nama "Bawomataluo" berarti "Bukit Matahari" karena terletak di dataran tinggi.\\n\\nHal paling terkenal dari desa ini adalah rumah adat Omo Hada yang berbentuk rumah panggung besar, terbuat dari kayu keras, beratap tinggi, dan dibangun tanpa paku modern. Selain itu Bawomataluo sangat terkenal dengan tradisi Fahombo atau lompat batu, dimana pemuda Nias melompati susunan batu setinggi sekitar 2 meter tanpa alat bantu.\\n\\nPada masa lalu masyarakat Nias dikenal memiliki budaya perang antarkampung yang kuat. Karena itu banyak unsur budaya desa berkaitan dengan keberanian, kekuatan fisik, dan status sosial prajurit.',
      historyTimeline: [
        TimelineEvent(
          era: 'BUDAYA PERANG',
          description: 'Pada masa lalu masyarakat memiliki budaya perang antarkampung yang kuat, tercermin dari budaya fisik prajurit.',
        ),
        TimelineEvent(
          era: 'WARISAN DUNIA',
          description: 'Bawomataluo pernah diajukan ke UNESCO sebagai kandidat warisan dunia berkat arsitektur tradisional dan budaya megalitik.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Rumah Omo Hada',
          description: 'Rumah panggung besar dari kayu keras beratap tinggi yang dibangun tanpa paku modern.',
        ),
        CultureItem(
          title: 'Tradisi Fahombo (Lompat Batu)',
          description: 'Pemuda Nias melompati susunan batu setinggi 2 meter tanpa alat bantu sebagai lambang kedewasaan dan keberanian prajurit.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '16',
      name: 'Desa Sangeh',
      location: 'Abiansemal, Badung, Bali',
      province: 'Bali',
      category: 'Wisata Alam',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.7,
      tags: ['Monkey Forest', 'Hutan Pala', 'Pura Suci'],
      description: 'Desa Sangeh adalah desa wisata terkenal di Bali yang identik dengan hutan pala raksasa, ratusan monyet liar jinak, dan pura kuno yang dianggap sakral oleh masyarakat Hindu Bali. Kawasan hutannya sering dianggap sebagai versi monkey forest yang lebih tenang dan alami dibanding Ubud.\\n\\nHutan ini memiliki luas sekitar 10-14 hektare, dipenuhi pohon pala raksasa yang tingginya bisa mencapai 30-40 meter. Di tengah hutan terdapat pura kuno Pura Bukit Sari peninggalan Kerajaan Mengwi. Masyarakat lokal menganggap monyet di Sangeh sebagai hewan suci, jelmaan prajurit penjaga kerajaan atau makhluk spiritual tertentu.\\n\\nWisatawan datang ke Sangeh untuk melihat monyet liar, berjalan di hutan pala, mengunjungi pura, dan menikmati suasana Bali yang lebih tenang. Namun pengunjung tetap disarankan berhati-hati karena monyet tetaplah hewan liar.',
      historyTimeline: [
        TimelineEvent(
          era: 'ABAD KE-17',
          description: 'Pura Bukit Sari dibangun pada masa Kerajaan Mengwi dan menjadi pusat spiritual kawasan hutan Sangeh.',
        ),
        TimelineEvent(
          era: 'MASA KINI',
          description: 'Menjadi desa wisata monkey forest yang lebih tenang dan alami dibanding wilayah Ubud.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Hutan Pala Raksasa',
          description: 'Hutan seluas 10-14 hektare yang dipenuhi pohon pala sakral peninggalan masa kerajaan.',
        ),
        CultureItem(
          title: 'Monyet Liar Suci',
          description: 'Ratusan monyet jinak yang dianggap oleh masyarakat lokal sebagai hewan suci jelmaan prajurit penjaga Pura Bukit Sari.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '17',
      name: 'Kintamani',
      location: 'Bangli, Bali',
      province: 'Bali',
      category: 'Wisata Alam',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Gunung Batur', 'Danau Vulkanik', 'Bali Aga'],
      description: 'Kintamani adalah kawasan pegunungan terkenal di Bali yang dikenal karena pemandangan gunung berapi, danau besar, udara sejuk, serta budaya Bali Aga yang masih kuat di beberapa desanya. Wilayah ini berada di dataran tinggi bagian timur laut Bali.\\n\\nDaya tarik utama Kintamani adalah Gunung Batur, gunung berapi aktif yang berada di tengah kaldera besar, dan Danau Batur, danau vulkanik terbesar di Bali. Di sekitar danau terdapat desa-desa adat kuno Bali Aga seperti Trunyan, Kedisan, Songan, dan Toya Bungkah.\\n\\nKintamani juga terkenal sebagai daerah penghasil kopi Arabika dengan rasa khas citrus. Wisatawan sering datang untuk melihat sunrise Gunung Batur, trekking gunung, menikmati pemandangan danau, mencoba kopi lokal, dan mandi di pemandian air panas alami.',
      historyTimeline: [
        TimelineEvent(
          era: 'KAWASAN PURBA',
          description: 'Kaldera Gunung Batur dan danau vulkaniknya terbentuk dari letusan purba yang mahadahsyat ribuan tahun lalu.',
        ),
        TimelineEvent(
          era: 'UNESCO GEOPARK',
          description: 'Kawasan Kintamani ditetapkan sebagai bagian dari UNESCO Global Geopark berkat keunikan geologinya.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Budaya Bali Aga',
          description: 'Desa-desa di sekitar Kintamani seperti Trunyan dan Kedisan masih memegang teguh tradisi kuno Bali Aga.',
        ),
        CultureItem(
          title: 'Kopi Arabika Kintamani',
          description: 'Pertanian dataran tinggi yang menghasilkan kopi Arabika berkualitas dengan cita rasa khas citrus.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '18',
      name: 'Desa Ponggok',
      location: 'Polanharjo, Klaten, Jawa Tengah',
      province: 'Jawa Tengah',
      category: 'Wisata Alam',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Umbul', 'Wisata Air', 'BUMDes'],
      description: 'Desa Ponggok adalah desa wisata terkenal di Jawa Tengah yang dikenal karena keberhasilannya mengubah sumber mata air alami menjadi destinasi wisata bawah air yang sangat populer. Desa ini sering disebut sebagai contoh sukses desa wisata dan pengelolaan ekonomi berbasis masyarakat.\\n\\nDaya tarik utama desa adalah Umbul Ponggok, kolam mata air alami dengan air sangat jernih, dasar berpasir dan berbatu, serta visibilitas bawah air yang tinggi. Keunikan utamanya adalah wisata foto bawah air dengan berbagai properti seperti sepeda motor, televisi, hingga dekorasi lainnya.\\n\\nBerkat inovasi dari BUMDes (Badan Usaha Milik Desa), Ponggok berkembang pesat. Pendapatan desa meningkat drastis, lapangan kerja bertambah, dan kesejahteraan warga naik signifikan. Ponggok sering dijadikan contoh nasional untuk pengembangan ekonomi kreatif desa.',
      historyTimeline: [
        TimelineEvent(
          era: 'MATA AIR LOKAL',
          description: 'Sejak dahulu sumber air ini hanya digunakan untuk mandi, mencuci, dan pengairan sawah oleh warga sekitar.',
        ),
        TimelineEvent(
          era: 'PENGELOLAAN BUMDES',
          description: 'Bertransformasi menjadi salah satu desa terkaya berkat inovasi wisata foto bawah air.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Wisata Mata Air (Umbul)',
          description: 'Pemanfaatan mata air alami (Umbul Ponggok) dengan visibilitas air yang sangat jernih untuk wisata bawah air.',
        ),
        CultureItem(
          title: 'Ekonomi Berbasis BUMDes',
          description: 'Budaya gotong royong modern melalui pengelolaan ekonomi kreatif desa wisata oleh Badan Usaha Milik Desa.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '19',
      name: 'Rammang-Rammang',
      location: 'Maros, Sulawesi Selatan',
      province: 'Sulawesi Selatan',
      category: 'Wisata Alam',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Karst', 'Menyusuri Sungai', 'Alam'],
      description: 'Rammang-Rammang adalah kawasan desa wisata alam yang terkenal karena bentang alam karst raksasa, sungai yang dikelilingi tebing batu kapur, dan suasana seperti dunia tersembunyi. Tempat ini sering disebut sebagai salah satu kawasan karst terindah di Indonesia bahkan dunia.\\n\\nUntuk mencapai area utama Rammang-Rammang, wisatawan biasanya naik perahu kayu kecil menyusuri Sungai Pute, melewati hutan nipah, air tenang, dan lorong karst alami. Di tengah kawasan batu kapur terdapat desa kecil seperti Kampung Berua dengan sawah hijau yang indah.\\n\\nKawasan Rammang-Rammang juga memiliki gua purba, lukisan tangan prasejarah, dan situs arkeologi kuno. Lukisan cap tangan manusia dan hewan purba di sana diperkirakan sebagai beberapa karya seni cadas tertua di dunia.',
      historyTimeline: [
        TimelineEvent(
          era: 'ZAMAN PRASEJARAH',
          description: 'Lukisan cap tangan purba membuktikan wilayah ini telah dihuni oleh manusia purba ribuan tahun lalu.',
        ),
        TimelineEvent(
          era: 'KARST MAROS-PANGKEP',
          description: 'Diakui sebagai salah satu kawasan pegunungan karst terbesar dan terindah di Asia Tenggara.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Menyusuri Sungai Pute',
          description: 'Aktivitas masyarakat lokal menaiki perahu kayu kecil menyusuri sungai dan hutan nipah di lorong karst alami.',
        ),
        CultureItem(
          title: 'Situs Purba',
          description: 'Gua kuno dengan lukisan cap tangan prasejarah dan seni cadas tertua peninggalan zaman prasejarah.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '20',
      name: 'Kampung Cyber',
      location: 'Patehan, Kota Yogyakarta, Daerah Istimewa Yogyakarta',
      province: 'Daerah Istimewa Yogyakarta',
      category: 'Desa Adat',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.6,
      tags: ['Digital', 'Mural', 'Kampung Kota'],
      description: 'Kampung Cyber adalah kampung wisata unik di Kota Yogyakarta yang terkenal karena berhasil menggabungkan budaya kampung tradisional dengan teknologi digital dan internet. Kampung ini menjadi simbol transformasi masyarakat lokal menuju era digital tanpa meninggalkan kehidupan sosial khas kampung Indonesia.\\n\\nDi banyak sudut kampung terdapat lukisan mural warna-warni, kabel jaringan internet, hotspot Wi-Fi, dan papan informasi digital. Meskipun modern secara teknologi, suasana sosial kampung seperti gotong royong, ronda, dan interaksi warga tetap sangat kuat.\\n\\nMasyarakat Kampung Cyber memanfaatkan internet untuk pendidikan, usaha kecil UMKM, promosi wisata, dan administrasi kampung. Karena inovasi ini, kampung yang berdekatan dengan Tamansari ini sering menjadi lokasi studi banding pengembangan desa atau kampung pintar (smart village).',
      historyTimeline: [
        TimelineEvent(
          era: 'TAHUN 2008',
          description: 'Masyarakat secara swadaya membangun jaringan internet dan sistem informasi warga untuk kemajuan kampung.',
        ),
        TimelineEvent(
          era: 'DESA PINTAR',
          description: 'Kini menjadi ikon percontohan \\'smart village\\' dan lokasi studi banding digitalisasi desa di Indonesia.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Digitalisasi Kampung',
          description: 'Pemanfaatan internet untuk UMKM, pendidikan, dan sistem administrasi warga tanpa meninggalkan interaksi sosial.',
        ),
        CultureItem(
          title: 'Seni Mural',
          description: 'Banyak sudut kampung dipenuhi lukisan mural warna-warni yang bersandingan dengan kabel jaringan dan hotspot Wi-Fi.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '21',
      name: 'Desa Bena',
      location: 'Ngada, Pulau Flores, Nusa Tenggara Timur',
      province: 'Nusa Tenggara Timur',
      category: 'Desa Adat',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.9,
      tags: ['Megalitik', 'Tenun Flores', 'Suku Ngada'],
      description: 'Desa Bena adalah desa adat megalitik terkenal di Flores yang dikenal karena rumah adat tradisional, batu-batu pemujaan leluhur, dan budaya kuno masyarakat Ngada yang masih sangat terjaga. Desa ini berada di lereng Gunung Inerie dengan pemandangan pegunungan yang sejuk.\\n\\nSebagai desa megalitik, di tengah Bena terdapat batu pemujaan, altar adat, dan simbol nenek moyang. Rumah-rumah adat dibangun sejajar dari kayu, bambu, dan beratapkan ilalang. Tiap rumah dilengkapi hiasan atap simbolis; bhaga (miniatur rumah) untuk leluhur perempuan dan ngadhu (tiang payung) untuk leluhur laki-laki.\\n\\nMasyarakat Bena sangat teguh memegang tradisi kekerabatan dan upacara peninggalan nenek moyang. Selain rumah adat, penduduk desa ini (terutama perempuannya) terkenal sebagai penenun kain tenun ikat Flores dengan motif khas suku Ngada.',
      historyTimeline: [
        TimelineEvent(
          era: 'ZAMAN MEGALITIKUM',
          description: 'Diperkirakan dihuni sejak ratusan tahun lalu dan tetap mempertahankan tata letak asli peninggalan leluhur.',
        ),
        TimelineEvent(
          era: 'MASA KINI',
          description: 'Masyarakat sangat teguh memegang tradisi kekerabatan, ritual kuno, dan pelestarian rumah adat Bena.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Simbol Megalitik',
          description: 'Batu pemujaan (bhaga dan ngadhu) di tengah desa sebagai penghormatan kepada leluhur laki-laki dan perempuan.',
        ),
        CultureItem(
          title: 'Tenun Ikat Flores',
          description: 'Keterampilan menenun kain dengan motif khas suku Ngada yang dikerjakan oleh para perempuan desa.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '22',
      name: 'Desa Argapura',
      location: 'Argapura, Majalengka, Jawa Barat',
      province: 'Jawa Barat',
      category: 'Wisata Alam',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Terasering', 'Pegunungan', 'Gunung Ciremai'],
      description: 'Desa Argapura adalah kawasan desa pegunungan di Kabupaten Majalengka yang terkenal karena panorama alam dataran tinggi, terasering sawah, udara sejuk, dan pemandangan Gunung Ciremai. Desa ini berada di wilayah perbukitan yang menjadi salah satu destinasi wisata alam berkembang di Jawa Barat.\\n\\nKarena berada di dataran tinggi, desa ini memiliki udara dingin, kabut pagi, dan lanskap hijau khas pegunungan. Argapura terkenal dengan hamparan sawah bertingkat, kebun sayur, dan pemandangan lembah pegunungan. Beberapa titik di kawasan Argapura bahkan sering disebut mirip lanskap pedesaan pegunungan Asia Timur karena susunan terasering dan kabutnya.\\n\\nKawasan Argapura berkembang sebagai destinasi wisata alam dan camping. Mayoritas masyarakat bekerja sebagai petani sayur, petani bawang, petani cabai, dan pengelola kebun dataran tinggi. Tanah vulkanik di sekitar Gunung Ciremai membuat wilayah ini sangat subur untuk pertanian. Kehidupan masyarakat masih sangat kental dengan budaya Sunda pedesaan seperti gotong royong dan pertanian tradisional.',
      historyTimeline: [
        TimelineEvent(
          era: 'PERTANIAN VULKANIK',
          description: 'Sejak dahulu masyarakat mengandalkan tanah vulkanik Gunung Ciremai yang sangat subur untuk bercocok tanam.',
        ),
        TimelineEvent(
          era: 'WISATA ALAM',
          description: 'Kawasan ini semakin terkenal melalui media sosial sebagai destinasi wisata lanskap mirip pedesaan Asia Timur.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Terasering Sayur',
          description: 'Sistem pertanian lahan miring (terasering) dengan hamparan kebun sayur, bawang, dan cabai yang tersusun rapi.',
        ),
        CultureItem(
          title: 'Budaya Sunda Pedesaan',
          description: 'Kehidupan pertanian masyarakat yang sangat mengutamakan gotong royong dan tradisi lokal Sunda.',
        ),
      ],
      isFeatured: false,
    ),`;

const newVillagesEn = `    Village(
      id: '13',
      name: 'Kampung Naga',
      location: 'Salawu, Tasikmalaya, West Java',
      province: 'West Java',
      category: 'Traditional Village',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Sundanese', 'Traditional', 'Anti-Modernization'],
      description: 'Kampung Naga is a traditional Sundanese village famous for maintaining a traditional lifestyle amidst modernization. This village is located in a green valley near the Ciwulan River and is often considered one of the most well-preserved Sundanese indigenous communities in Indonesia.\\n\\nThe people of Kampung Naga are descendants of the Sundanese who deeply guard their ancestral customs, simple lifestyle, and harmony with nature. All houses in Kampung Naga have a uniform shape, namely wooden stilt houses with woven bamboo walls, palm fiber or nipa roofs, painted white with black details. Kampung Naga is known for restricting the use of certain technologies to preserve their traditions.\\n\\nThe majority of the community works as farmers, craftsmen, and small traders. The community is known to live simply and highly upholds mutual cooperation (gotong royong), deliberation, and family relations. They hold the principles of living simply, protecting nature, and not being excessive in building life.',
      historyTimeline: [
        TimelineEvent(
          era: 'YEAR 1956',
          description: 'The village once suffered a massive fire and was then completely rebuilt using the exact same traditional shape and layout.',
        ),
        TimelineEvent(
          era: 'PRESENT DAY',
          description: 'The community is still led by customary leaders and maintains traditions amidst the onslaught of modernization.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Simple Lifestyle',
          description: 'The community strongly guards ancestral customs, a simple lifestyle, and harmony with nature. Rejecting modernization and limiting the use of certain technologies.',
        ),
        CultureItem(
          title: 'Uniform Stilt Houses',
          description: 'All houses are in the form of stilt houses with woven bamboo walls, palm fiber roofs, and painted white with black details.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '14',
      name: 'Kasongan Village',
      location: 'Bantul, Special Region of Yogyakarta',
      province: 'Special Region of Yogyakarta',
      category: 'Traditional Village',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.7,
      tags: ['Art', 'Pottery', 'Tourism Village'],
      description: 'Kasongan Village is an art tourism village famous as the largest pottery and ceramics craft center in Yogyakarta. The village is well-known because almost all of its community possesses clay crafting skills handed down through generations.\\n\\nUpon entering the village, visitors will see pottery galleries, art shops, ceramic workshops, and rows of clay statues along the road. Some artisans still use traditional techniques: shaping clay by hand, using a simple potter\\'s wheel, and then firing it in a special kiln.\\n\\nKasongan is not only a place to buy crafts but also an educational tourism destination. Visitors can observe the pottery-making process, try making ceramics themselves, learn clay shaping, and join art workshops.',
      historyTimeline: [
        TimelineEvent(
          era: 'THE BEGINNING',
          description: 'During the Dutch colonial era, villagers shifted to making clay pottery for survival out of fear of losing their livestock.',
        ),
        TimelineEvent(
          era: '1970S',
          description: 'Artists and designers began helping to introduce Kasongan pottery to national and international markets.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Pottery Crafting',
          description: 'Clay crafting skills passed down through generations using traditional hand techniques and simple potter\\'s wheels.',
        ),
        CultureItem(
          title: 'Open Art Gallery',
          description: 'Along the village road is filled with pottery galleries, art shops, ceramic workshops, and rows of clay statues.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '15',
      name: 'Bawomataluo Village',
      location: 'Fanayama, South Nias, North Sumatra',
      province: 'North Sumatra',
      category: 'Traditional Village',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.9,
      tags: ['Stone Jumping', 'Nias', 'Megalithic'],
      description: 'Bawomataluo Village is a famous traditional village on Nias Island, known for its stone jumping tradition, majestic traditional houses, and tribal war culture that is still strongly felt in the community\\'s identity. The name "Bawomataluo" means "Sun Hill" because it is located on a highland plateau.\\n\\nThe most famous feature of this village is the Omo Hada traditional house, which is a large stilt house made of hard wood with a high roof, built without modern nails. Furthermore, Bawomataluo is famous for the Fahombo or stone jumping tradition, where Nias youths leap over a stone arrangement about 2 meters high without any assistance.\\n\\nIn the past, the Nias community was known to have a strong inter-village war culture. Therefore, many of the village\\'s cultural elements are related to bravery, physical strength, and the social status of warriors.',
      historyTimeline: [
        TimelineEvent(
          era: 'WAR CULTURE',
          description: 'In the past, the community had a strong inter-village war culture, reflected in the physical culture of warriors.',
        ),
        TimelineEvent(
          era: 'WORLD HERITAGE',
          description: 'Bawomataluo was once submitted to UNESCO as a candidate for a world heritage site due to its traditional architecture and megalithic culture.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Omo Hada House',
          description: 'A large stilt house made of hard wood with a high roof, built without modern nails.',
        ),
        CultureItem(
          title: 'Fahombo (Stone Jumping) Tradition',
          description: 'Nias youths leap over a stone arrangement about 2 meters high without any assistance as a symbol of maturity and warrior bravery.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '16',
      name: 'Sangeh Village',
      location: 'Abiansemal, Badung, Bali',
      province: 'Bali',
      category: 'Nature Tourism',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.7,
      tags: ['Monkey Forest', 'Nutmeg Forest', 'Holy Temple'],
      description: 'Sangeh Village is a famous tourism village in Bali, synonymous with the giant nutmeg forest, hundreds of tame wild monkeys, and an ancient temple considered sacred by the Balinese Hindu community. Its forest area is often considered a quieter and more natural version of the Ubud monkey forest.\\n\\nThe forest covers an area of about 10-14 hectares, filled with giant nutmeg trees that can reach 30-40 meters in height. In the middle of the forest lies the ancient temple Pura Bukit Sari, a relic of the Mengwi Kingdom. Local people consider the monkeys in Sangeh as sacred animals, incarnations of the kingdom\\'s guardian soldiers or spiritual beings.\\n\\nTourists visit Sangeh to see the wild monkeys, walk in the nutmeg forest, visit the temple, and enjoy a quieter side of Bali. However, visitors are still advised to be careful as the monkeys are wild animals.',
      historyTimeline: [
        TimelineEvent(
          era: '17TH CENTURY',
          description: 'Pura Bukit Sari was built during the Mengwi Kingdom era and became the spiritual center of the Sangeh forest area.',
        ),
        TimelineEvent(
          era: 'PRESENT DAY',
          description: 'It has become a monkey forest tourism village that is quieter and more natural compared to the Ubud area.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Giant Nutmeg Forest',
          description: 'A 10-14 hectare forest filled with sacred nutmeg trees inherited from the kingdom era.',
        ),
        CultureItem(
          title: 'Sacred Wild Monkeys',
          description: 'Hundreds of tame monkeys considered by local people as sacred animals, incarnations of Pura Bukit Sari guardian soldiers.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '17',
      name: 'Kintamani',
      location: 'Bangli, Bali',
      province: 'Bali',
      category: 'Nature Tourism',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Mount Batur', 'Volcanic Lake', 'Bali Aga'],
      description: 'Kintamani is a famous mountainous region in Bali known for its volcano views, large lake, cool air, and the Bali Aga culture that is still strong in some of its villages. This area is located in the northeastern highlands of Bali.\\n\\nThe main attractions of Kintamani are Mount Batur, an active volcano located in the middle of a massive caldera, and Lake Batur, the largest volcanic lake in Bali. Around the lake, there are ancient Bali Aga traditional villages such as Trunyan, Kedisan, Songan, and Toya Bungkah.\\n\\nKintamani is also famous as a coffee-producing region, specifically Kintamani Arabica with its distinct citrus flavor. Tourists often visit to see the sunrise over Mount Batur, go mountain trekking, enjoy the lake views, taste local coffee, and bathe in natural hot springs.',
      historyTimeline: [
        TimelineEvent(
          era: 'ANCIENT REGION',
          description: 'The Mount Batur caldera and its volcanic lake were formed from a massive ancient eruption thousands of years ago.',
        ),
        TimelineEvent(
          era: 'UNESCO GEOPARK',
          description: 'The Kintamani area has been designated as part of the UNESCO Global Geopark due to its unique geology.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Bali Aga Culture',
          description: 'Villages around Kintamani such as Trunyan and Kedisan still firmly hold ancient Bali Aga traditions.',
        ),
        CultureItem(
          title: 'Kintamani Arabica Coffee',
          description: 'Highland agriculture producing high-quality Arabica coffee with a distinct citrus flavor.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '18',
      name: 'Ponggok Village',
      location: 'Polanharjo, Klaten, Central Java',
      province: 'Central Java',
      category: 'Nature Tourism',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Water Spring', 'Water Tourism', 'BUMDes'],
      description: 'Ponggok Village is a famous tourism village in Central Java, known for its success in transforming natural water springs into highly popular underwater tourism destinations. This village is often cited as a successful example of a tourism village and community-based economic management.\\n\\nThe main attraction is Umbul Ponggok, a natural spring pool with crystal clear water, a sandy and rocky bottom, and high underwater visibility. Its main uniqueness is the underwater photo tourism featuring various props such as motorcycles, televisions, and other decorations.\\n\\nThanks to the innovation of BUMDes (Village-Owned Enterprises), Ponggok has developed rapidly. The village\\'s income has increased dramatically, jobs have been created, and residents\\' welfare has risen significantly. Ponggok is often used as a national example for developing creative village economies.',
      historyTimeline: [
        TimelineEvent(
          era: 'LOCAL SPRING',
          description: 'Since ancient times, this water source was only used for bathing, washing, and irrigating rice fields by local residents.',
        ),
        TimelineEvent(
          era: 'BUMDES MANAGEMENT',
          description: 'Transformed into one of the richest villages thanks to underwater photo tourism innovations.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Spring Water Tourism (Umbul)',
          description: 'Utilization of natural spring water (Umbul Ponggok) with very clear water visibility for underwater tourism.',
        ),
        CultureItem(
          title: 'BUMDes-Based Economy',
          description: 'Modern mutual cooperation culture through the management of the tourism village creative economy by Village-Owned Enterprises.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '19',
      name: 'Rammang-Rammang',
      location: 'Maros, South Sulawesi',
      province: 'South Sulawesi',
      category: 'Nature Tourism',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Karst', 'River Cruise', 'Nature'],
      description: 'Rammang-Rammang is a nature tourism village area famous for its giant karst landscape, rivers surrounded by limestone cliffs, and an atmosphere like a hidden world. This place is often called one of the most beautiful karst areas in Indonesia, and even the world.\\n\\nTo reach the main area of Rammang-Rammang, tourists usually take a small wooden boat along the Pute River, passing through nipa forests, calm waters, and natural karst corridors. Amidst the limestone area lies a small village like Kampung Berua, featuring beautiful green rice fields.\\n\\nThe Rammang-Rammang area also houses ancient caves, prehistoric hand stencils, and ancient archaeological sites. The human handprint paintings and ancient animal drawings there are estimated to be some of the oldest rock art in the world.',
      historyTimeline: [
        TimelineEvent(
          era: 'PREHISTORIC TIMES',
          description: 'Ancient hand stencil paintings prove this area was inhabited by early humans thousands of years ago.',
        ),
        TimelineEvent(
          era: 'MAROS-PANGKEP KARST',
          description: 'Recognized as one of the largest and most beautiful karst mountain areas in Southeast Asia.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Cruising the Pute River',
          description: 'Local community activity riding small wooden boats along the river and nipa forests in natural karst corridors.',
        ),
        CultureItem(
          title: 'Ancient Sites',
          description: 'Ancient caves with prehistoric hand stencil paintings and the oldest rock art left from prehistoric times.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '20',
      name: 'Kampung Cyber',
      location: 'Patehan, Yogyakarta, Special Region of Yogyakarta',
      province: 'Special Region of Yogyakarta',
      category: 'Traditional Village',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.6,
      tags: ['Digital', 'Mural', 'Urban Village'],
      description: 'Kampung Cyber is a unique tourism village in the city of Yogyakarta, famous for successfully combining traditional village culture with digital technology and the internet. This village has become a symbol of the local community\\'s transformation into the digital era without leaving behind the typical social life of an Indonesian village.\\n\\nIn many corners of the village, there are colorful murals, internet network cables, Wi-Fi hotspots, and digital information boards. Although technologically modern, the social atmosphere of the village—such as mutual cooperation, night patrols, and citizen interaction—remains very strong.\\n\\nThe residents of Kampung Cyber use the internet for education, small business (UMKM), tourism promotion, and village administration. Due to these innovations, the village, located near Tamansari, is often a comparative study location for developing smart villages.',
      historyTimeline: [
        TimelineEvent(
          era: 'YEAR 2008',
          description: 'The community independently built an internet network and citizen information system for village advancement.',
        ),
        TimelineEvent(
          era: 'SMART VILLAGE',
          description: 'Now a pilot icon for \\'smart villages\\' and a comparative study location for village digitalization in Indonesia.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Village Digitalization',
          description: 'Utilization of the internet for UMKM, education, and citizen administration systems without abandoning social interaction.',
        ),
        CultureItem(
          title: 'Mural Art',
          description: 'Many corners of the village are filled with colorful mural paintings alongside network cables and Wi-Fi hotspots.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '21',
      name: 'Bena Village',
      location: 'Ngada, Flores Island, East Nusa Tenggara',
      province: 'East Nusa Tenggara',
      category: 'Traditional Village',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.9,
      tags: ['Megalithic', 'Flores Weaving', 'Ngada Tribe'],
      description: 'Bena Village is a famous megalithic traditional village in Flores, known for its traditional houses, ancestral worship stones, and the ancient culture of the Ngada people that is still highly preserved. This village is located on the slopes of Mount Inerie with cool mountainous views.\\n\\nAs a megalithic village, in the center of Bena, there are worship stones, traditional altars, and ancestral symbols. The traditional houses are built parallel from wood, bamboo, and thatched roofs. Each house features symbolic roof decorations; bhaga (a miniature house) for female ancestors and ngadhu (an umbrella pole) for male ancestors.\\n\\nThe people of Bena firmly hold onto kinship traditions and ancestral ceremonies. Besides the traditional houses, the villagers (especially the women) are famous as weavers of Flores ikat cloth with distinctive Ngada motifs.',
      historyTimeline: [
        TimelineEvent(
          era: 'MEGALITHIC ERA',
          description: 'Estimated to have been inhabited for hundreds of years and still maintains the original layout left by ancestors.',
        ),
        TimelineEvent(
          era: 'PRESENT DAY',
          description: 'The community very firmly holds kinship traditions, ancient rituals, and the preservation of Bena traditional houses.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Megalithic Symbols',
          description: 'Worship stones (bhaga and ngadhu) in the center of the village as a tribute to male and female ancestors.',
        ),
        CultureItem(
          title: 'Flores Ikat Weaving',
          description: 'The skill of weaving cloth with distinctive Ngada tribe motifs, crafted by the women of the village.',
        ),
      ],
      isFeatured: false,
    ),
    Village(
      id: '22',
      name: 'Argapura Village',
      location: 'Argapura, Majalengka, West Java',
      province: 'West Java',
      category: 'Nature Tourism',
      imagePath: 'assets/images/placeholder.png',
      rating: 4.8,
      tags: ['Terraced Fields', 'Mountains', 'Mount Ciremai'],
      description: 'Argapura Village is a mountainous village area in Majalengka Regency, famous for its highland natural panoramas, terraced rice fields, cool air, and views of Mount Ciremai. This village is located in a hilly region that is becoming a growing nature tourism destination in West Java.\\n\\nLocated in the highlands, this village has cold air, morning fog, and typical mountainous green landscapes. Argapura is famous for its expanse of terraced rice fields, vegetable gardens, and mountain valley views. Some spots in the Argapura area are even often said to resemble East Asian mountainous rural landscapes due to the terraced layout and fog.\\n\\nThe Argapura area is developing as a nature tourism and camping destination. The majority of the people work as vegetable farmers, onion farmers, chili farmers, and highland garden managers. The volcanic soil around Mount Ciremai makes this region highly fertile for agriculture. The community\\'s life is still deeply rooted in rural Sundanese culture, such as mutual cooperation (gotong royong) and traditional farming.',
      historyTimeline: [
        TimelineEvent(
          era: 'VOLCANIC AGRICULTURE',
          description: 'Since ancient times, the community has relied on the highly fertile volcanic soil of Mount Ciremai for farming.',
        ),
        TimelineEvent(
          era: 'NATURE TOURISM',
          description: 'This area is becoming increasingly famous on social media as a destination with landscapes resembling rural East Asia.',
        ),
      ],
      gallery: [
        'assets/images/placeholder.png',
      ],
      cultureList: [
        CultureItem(
          title: 'Vegetable Terraces',
          description: 'A sloping land farming system (terraces) with neatly arranged expanses of vegetable, onion, and chili gardens.',
        ),
        CultureItem(
          title: 'Rural Sundanese Culture',
          description: 'An agricultural community life that highly prioritizes mutual cooperation and local Sundanese traditions.',
        ),
      ],
      isFeatured: false,
    ),`;

updateFile(idFile, newVillagesId);
updateFile(enFile, newVillagesEn);
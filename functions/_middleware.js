const EXACT = {
  '/ar/blog/إجراءات-التشغيل-واللوائح-إجراءات-شائعة-سهلة-العثور/': '/ar/blog/ijraat-altshghyl-wallwaih-ijraat-shaiaa-shla-alathwr/',
  '/ar/blog/اللافتات-والعلامات-والأولوية-ثلاث-قراءات-للسائق/': '/ar/blog/allaftat-walalamat-walawlwya-thlath-qraat-llsaiq/',
  '/ar/blog/قواعد-المرور-الجيبية-اعثر-على-البند-عند-الحاجة/': '/ar/blog/qwaad-almrwr-aljybya-aathr-ala-albnd-and-alhaja/',
  '/en/blog/aturan-lalu-lintas-saku': '/en/blog/pocket-traffic-rules-find-the-clause-when-needed/',
  '/en/blog/rambu-marka-prioritas': '/en/blog/signs-markings-priority-three-core-rider-readings/',
  '/en/blog/sop-regulasi-offline': '/en/blog/sops-and-regulations-common-procedures-made-findable/',
  '/id/blog/aturan-lalu-lintas-saku/': '/id/blog/aturan-lalu-lintas-saku-cari-pasal-saat-dibutuhkan/',
  '/id/blog/rambu-marka-prioritas/': '/id/blog/rambu-marka-dan-prioritas-tiga-bacaan-inti-pengendara/',
  '/id/blog/sop-regulasi-offline/': '/id/blog/sop-dan-regulasi-prosedur-umum-mudah-dicari/',
  '/ja/blog/sop-と法規よく使う手順を探しやすく/': '/ja/blog/to-houki-yoku-tsukau-tejun-wo-sagashi-yasuku/',
  '/ja/blog/ポケット交通ルール要るとき条文を即検索/': '/ja/blog/poketto-koutsuu-ruuru-iru-toki-joubun-wo-soku-kensaku/',
  '/ja/blog/標識標示優先運転者の核心3読み物/': '/ja/blog/hyoushiki-hyouji-yuusen-untensha-no-kakushin-3-yomimono/',
  '/jv/blog/aturan-lalu-lintas-saku': '/jv/blog/aturan-lalu-lintas-saku-golek-pasal-nalika-dibutuhake/',
  '/jv/blog/rambu-marka-prioritas': '/jv/blog/rambu-marka-lan-prioritas-telung-wacan-inti-pengendara/',
  '/jv/blog/sop-regulasi-offline': '/jv/blog/sop-lan-regulasi-prosedur-umum-gampang-digoleki/',
  '/su/blog/aturan-lalu-lintas-saku': '/su/blog/aturan-lalu-lintas-saku-milari-pasal-nalika-dibutuhkeun/',
  '/su/blog/rambu-marka-prioritas': '/su/blog/rambu-marka-jeung-prioritas-tilu-bacaan-inti-pangendara/',
  '/su/blog/sop-regulasi-offline': '/su/blog/sop-jeung-regulasi-prosedur-umum-gampang-dipilari/',
  '/zh/blog/sop-与法规常用流程一查即得/': '/zh/blog/yu-fa-gui-chang-yong-liu-cheng-yi-cha-ji-de/',
  '/zh/blog/口袋交规需要时秒查条款/': '/zh/blog/kou-dai-jiao-gui-xu-yao-shi-miao-cha-tiao-kuan/',
  '/zh/blog/标志标线路权骑手三组核心读物/': '/zh/blog/biao-zhi-biao-xian-lu-quan-qi-shou-san-zu-he-xin-du-wu/'
};

const BLOG_PATH = /^\/(id|en|ar|zh|ja|jv|su)\/blog\/./;

export async function onRequest(context) {
  const url = new URL(context.request.url);
  const decoded = decodeURIComponent(url.pathname);
  const mapped = EXACT[decoded];
  if (mapped) return Response.redirect(url.origin + mapped, 301);

  const response = await context.next();
  if (response.status !== 404) return response;

  // Anything still unresolved under a blog path goes to its locale index rather
  // than a dead end.
  if (BLOG_PATH.test(decoded)) {
    const locale = decoded.split("/")[1];
    return Response.redirect(`${url.origin}/${locale}/blog/`, 301);
  }
  return response;
}

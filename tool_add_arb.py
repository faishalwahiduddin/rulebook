#!/usr/bin/env python3
"""Add or update l10n keys across every locale ARB file.

Usage: edit TRANSLATIONS below, then run `python3 tool_add_arb.py`.
Each key maps to a dict of locale_code -> value. The Indonesian (`id`) value is
also written into the top-level template `app_id.arb`. Missing locales fall
back to `id`.
"""
import json
import os
import glob

ARB_DIR = os.path.join(os.path.dirname(__file__), 'lib', 'l10n')

# key -> {locale: value}
T = {}

# ---------------------------------------------------------------- categories
T['catTrafficShort'] = {'id': 'Lalu Lintas', 'en': 'Traffic', 'ar': 'المرور',
                        'jv': 'Lalu Lintas', 'su': 'Lalu Lintas', 'zh': '交通',
                        'ja': '交通', 'es': 'Tránsito'}
T['catLaborShort'] = {'id': 'Kerja', 'en': 'Work', 'ar': 'العمل', 'jv': 'Kerja',
                      'su': 'Pagawean', 'zh': '劳动', 'ja': '労働', 'es': 'Laboral'}
T['catCyberShort'] = {'id': 'Data & ITE', 'en': 'Data & ITE', 'ar': 'البيانات',
                      'jv': 'Data & ITE', 'su': 'Data & ITE', 'zh': '数据',
                      'ja': 'データ', 'es': 'Datos'}
T['catConsumerShort'] = {'id': 'Konsumen', 'en': 'Consumer', 'ar': 'المستهلك',
                         'jv': 'Konsumen', 'su': 'Konsumen', 'zh': '消费者',
                         'ja': '消費者', 'es': 'Consumidor'}
T['catSafetyShort'] = {'id': 'K3', 'en': 'Safety', 'ar': 'السلامة', 'jv': 'K3',
                       'su': 'K3', 'zh': '安全', 'ja': '安全', 'es': 'Seguridad'}
T['catCivilShort'] = {'id': 'Etika', 'en': 'Ethics', 'ar': 'الأخلاق', 'jv': 'Etika',
                      'su': 'Etika', 'zh': '公德', 'ja': '公徳', 'es': 'Ética'}

T['catAllDesc'] = {'id': 'Semua aturan, panduan, dan SOP dalam satu tempat.',
                   'en': 'Every rule, guide, and SOP in one place.',
                   'ar': 'كل القواعد والأدلة والإجراءات في مكان واحد.',
                   'jv': 'Kabeh aturan, pandhuan, lan SOP ana ing siji panggonan.',
                   'su': 'Sakabeh aturan, pituduh, jeung SOP dina hiji tempat.',
                   'zh': '所有规则、指南与流程，尽在一处。',
                   'ja': 'すべてのルール・ガイド・SOPをひとつに。',
                   'es': 'Todas las normas, guías y protocolos en un solo lugar.'}
T['catTrafficDesc'] = {'id': 'Aturan berkendara, tilang, dan keselamatan jalan.',
                       'en': 'Driving rules, traffic fines, and road safety.',
                       'ar': 'قواعد القيادة والمخالفات وسلامة الطريق.',
                       'jv': 'Aturan nyopir, tilang, lan keslametan dalan.',
                       'su': 'Aturan nyetir, tilang, jeung kasalametan jalan.',
                       'zh': '驾驶规则、交通罚则与道路安全。',
                       'ja': '運転ルール、反則金、道路の安全。',
                       'es': 'Normas de tránsito, multas y seguridad vial.'}
T['catLaborDesc'] = {'id': 'Jam kerja, lembur, cuti, dan hak pesangon.',
                     'en': 'Work hours, overtime, leave, and severance rights.',
                     'ar': 'ساعات العمل والإضافي والإجازات وحقوق نهاية الخدمة.',
                     'jv': 'Jam kerja, lembur, cuti, lan hak pesangon.',
                     'su': 'Jam gawé, lembur, cuti, jeung hak pesangon.',
                     'zh': '工时、加班、休假与离职补偿权利。',
                     'ja': '労働時間、残業、休暇、退職金の権利。',
                     'es': 'Jornada, horas extra, vacaciones y derechos de despido.'}
T['catCyberDesc'] = {'id': 'Perlindungan data pribadi dan jejak digital Anda.',
                     'en': 'Personal data protection and your digital footprint.',
                     'ar': 'حماية البيانات الشخصية وأثرك الرقمي.',
                     'jv': 'Protèksi data pribadi lan jejak digital panjenengan.',
                     'su': 'Panyalindungan data pribadi jeung jejak digital anjeun.',
                     'zh': '个人数据保护与你的数字足迹。',
                     'ja': '個人データの保護とデジタルの足跡。',
                     'es': 'Protección de datos personales y tu huella digital.'}
T['catConsumerDesc'] = {'id': 'Hak pembeli, garansi, dan cara komplain.',
                        'en': 'Buyer rights, warranties, and how to complain.',
                        'ar': 'حقوق المشتري والضمان وطريقة تقديم شكوى.',
                        'jv': 'Hak panuku, garansi, lan cara komplain.',
                        'su': 'Hak nu meuli, garansi, jeung cara ngadu.',
                        'zh': '消费者权益、保修与投诉方式。',
                        'ja': '購入者の権利、保証、苦情の伝え方。',
                        'es': 'Derechos del comprador, garantías y cómo reclamar.'}
T['catSafetyDesc'] = {'id': 'Prosedur darurat, APD, dan keselamatan kerja.',
                      'en': 'Emergency procedures, PPE, and workplace safety.',
                      'ar': 'إجراءات الطوارئ ومعدات الوقاية وسلامة العمل.',
                      'jv': 'Prosedur darurat, APD, lan keslametan kerja.',
                      'su': 'Prosedur darurat, APD, jeung kasalametan gawé.',
                      'zh': '应急流程、防护装备与作业安全。',
                      'ja': '緊急手順、保護具、職場の安全。',
                      'es': 'Protocolos de emergencia, EPP y seguridad laboral.'}
T['catCivilDesc'] = {'id': 'Ketertiban umum dan hidup bersama di ruang publik.',
                     'en': 'Public order and getting along in shared spaces.',
                     'ar': 'النظام العام والتعايش في الأماكن العامة.',
                     'jv': 'Katartiban umum lan urip bebarengan ing papan umum.',
                     'su': 'Katartiban umum jeung hirup babarengan di tempat umum.',
                     'zh': '公共秩序与共享空间的相处之道。',
                     'ja': '公共の秩序と公共空間での暮らし方。',
                     'es': 'Orden público y convivencia en espacios compartidos.'}

# ---------------------------------------------------------------- nav
T['navCatalogShort'] = {'id': 'Aturan', 'en': 'Rules', 'ar': 'القواعد', 'jv': 'Aturan',
                        'su': 'Aturan', 'zh': '规则', 'ja': 'ルール', 'es': 'Normas'}
T['navSimulationShort'] = {'id': 'Hitung', 'en': 'Calculate', 'ar': 'احسب', 'jv': 'Hitung',
                           'su': 'Itung', 'zh': '计算', 'ja': '計算', 'es': 'Calcular'}
T['navSopShort'] = {'id': 'Darurat', 'en': 'Emergency', 'ar': 'طوارئ', 'jv': 'Darurat',
                    'su': 'Darurat', 'zh': '应急', 'ja': '緊急', 'es': 'Emergencia'}
T['navComplianceShort'] = {'id': 'Audit', 'en': 'Audit', 'ar': 'تدقيق', 'jv': 'Audit',
                           'su': 'Audit', 'zh': '审计', 'ja': '監査', 'es': 'Auditoría'}
T['navBookmarks'] = {'id': 'Simpanan', 'en': 'Saved', 'ar': 'المحفوظات', 'jv': 'Simpenan',
                     'su': 'Simpenan', 'zh': '收藏', 'ja': '保存', 'es': 'Guardado'}

# ---------------------------------------------------------------- catalog
T['searchRulesHint'] = {'id': 'Cari aturan, pasal, atau situasi...',
                        'en': 'Search a rule, article, or situation…',
                        'ar': 'ابحث عن قاعدة أو مادة أو حالة…',
                        'jv': 'Golèk aturan, pasal, utawa kahanan…',
                        'su': 'Pilari aturan, pasal, atawa kaayaan…',
                        'zh': '搜索规则、条款或情境……',
                        'ja': 'ルール・条文・状況を検索…',
                        'es': 'Busca una norma, artículo o situación…'}
T['forYou'] = {'id': 'Untuk Anda', 'en': 'For you', 'ar': 'لك',
               'jv': 'Kanggo Panjenengan', 'su': 'Pikeun Anjeun', 'zh': '为你推荐',
               'ja': 'あなた向け', 'es': 'Para ti'}
T['browseByTopic'] = {'id': 'Telusuri topik', 'en': 'Browse by topic',
                      'ar': 'تصفح حسب الموضوع', 'jv': 'Telusuri topik',
                      'su': 'Tiluan topik', 'zh': '按主题浏览',
                      'ja': 'トピックで探す', 'es': 'Explorar por tema'}
T['searchAriaLabel'] = {'id': 'Kolom pencarian aturan', 'en': 'Rule search field',
                        'ar': 'حقل البحث عن القواعد', 'jv': 'Kolom panggolèkan aturan',
                        'su': 'Kolom pilari aturan', 'zh': '规则搜索框',
                        'ja': 'ルール検索欄', 'es': 'Campo de búsqueda de normas'}
T['resultsCount'] = {'id': '{count} aturan', 'en': '{count} rules',
                     'ar': '{count} قاعدة', 'jv': '{count} aturan',
                     'su': '{count} aturan', 'zh': '{count} 条规则',
                     'ja': '{count} 件のルール', 'es': '{count} normas',
                     '@count': {'type': 'int'}}
T['noRulesMatch'] = {'id': 'Belum ada yang cocok', 'en': 'Nothing matched yet',
                     'ar': 'لا نتائج مطابقة بعد', 'jv': 'Durung ana sing cocog',
                     'su': 'Can aya nu cocog', 'zh': '暂时没有匹配结果',
                     'ja': 'まだ一致するものはありません', 'es': 'Aún no hay coincidencias'}
T['tryOtherKeywords'] = {'id': 'Coba kata kunci lain, atau ganti topiknya.',
                         'en': 'Try a different keyword, or switch the topic.',
                         'ar': 'جرّب كلمة أخرى أو غيّر الموضوع.',
                         'jv': 'Coba tembung liya, utawa ganti topike.',
                         'su': 'Cobaan kecap séjén, atawa ganti topikna.',
                         'zh': '换个关键词，或切换主题试试。',
                         'ja': '別のキーワードかトピックをお試しください。',
                         'es': 'Prueba otra palabra clave o cambia el tema.'}
T['clearSearch'] = {'id': 'Bersihkan pencarian', 'en': 'Clear search',
                    'ar': 'مسح البحث', 'jv': 'Resiki panggolèkan',
                    'su': 'Beresihan pilari', 'zh': '清除搜索',
                    'ja': '検索をクリア', 'es': 'Borrar búsqueda'}
T['resetFilters'] = {'id': 'Atur ulang', 'en': 'Reset', 'ar': 'إعادة تعيين',
                     'jv': 'Setel ulang', 'su': 'Setél ulang', 'zh': '重置',
                     'ja': 'リセット', 'es': 'Restablecer'}
T['readingTime'] = {'id': '{minutes} mnt baca', 'en': '{minutes} min read',
                    'ar': 'قراءة {minutes} د', 'jv': '{minutes} mnt maca',
                    'su': '{minutes} mnt maca', 'zh': '{minutes} 分钟阅读',
                    'ja': '読了 {minutes} 分', 'es': '{minutes} min de lectura',
                    '@minutes': {'type': 'int'}}

# ---------------------------------------------------------------- rule detail
T['ruleDetailMeta'] = {'id': 'Detail aturan', 'en': 'Rule detail',
                       'ar': 'تفاصيل القاعدة', 'jv': 'Rincian aturan',
                       'su': 'Rincian aturan', 'zh': '规则详情',
                       'ja': 'ルール詳細', 'es': 'Detalle de la norma'}
T['whatItMeans'] = {'id': 'Apa artinya untuk Anda', 'en': "What it means for you",
                    'ar': 'ماذا يعني لك', 'jv': 'Apa tegesé kanggo panjenengan',
                    'su': 'Naon hartina pikeun anjeun', 'zh': '这对你意味着什么',
                    'ja': 'あなたにとっての意味', 'es': 'Qué significa para ti'}
T['doThis'] = {'id': 'Lakukan', 'en': 'Do', 'ar': 'افعل', 'jv': 'Lakoni',
               'su': 'Lakukeun', 'zh': '要做的', 'ja': 'すべきこと', 'es': 'Hazlo'}
T['avoidThis'] = {'id': 'Hindari', 'en': 'Avoid', 'ar': 'تجنّب', 'jv': 'Dihindari',
                  'su': 'Dihindarkeun', 'zh': '要避免', 'ja': '避けること', 'es': 'Evítalo'}
T['legalBasisLabel'] = {'id': 'Dasar hukum', 'en': 'Legal basis', 'ar': 'الأساس القانوني',
                        'jv': 'Dasar hukum', 'su': 'Dasar hukum', 'zh': '法律依据',
                        'ja': '法的根拠', 'es': 'Base legal'}
T['consequenceLabel'] = {'id': 'Konsekuensi', 'en': 'Consequence', 'ar': 'العقوبة',
                         'jv': 'Akibaté', 'su': 'Balukarna', 'zh': '后果',
                         'ja': '罰則', 'es': 'Consecuencia'}
T['noteEmptyHint'] = {'id': 'Simpan tanggal kejadian, nomor surat, atau hal yang perlu Anda ingat.',
                      'en': "Save a date, a reference number, or anything you don't want to forget.",
                      'ar': 'احفظ التاريخ أو رقم المستند أو أي شيء لا تريد نسيانه.',
                      'jv': 'Simpen tanggal, nomer layang, utawa bab sing kudu diéling-éling.',
                      'su': 'Simpen tanggal, nomer surat, atawa hal anu kudu diinget-inget.',
                      'zh': '记下日期、编号，或任何你不想忘记的事。',
                      'ja': '日付や整理番号など、忘れたくないことを残しましょう。',
                      'es': 'Guarda una fecha, un número o algo que no quieras olvidar.'}
T['noteSaved'] = {'id': 'Catatan tersimpan', 'en': 'Note saved', 'ar': 'تم حفظ الملاحظة',
                  'jv': 'Cathetan kasimpen', 'su': 'Catetan kasimpen', 'zh': '已保存笔记',
                  'ja': 'メモを保存しました', 'es': 'Nota guardada'}
T['noteDeleted'] = {'id': 'Catatan dihapus', 'en': 'Note removed', 'ar': 'تم حذف الملاحظة',
                    'jv': 'Cathetan kabusak', 'su': 'Catetan dipupus', 'zh': '已删除笔记',
                    'ja': 'メモを削除しました', 'es': 'Nota eliminada'}
T['summaryCopied'] = {'id': 'Ringkasan disalin', 'en': 'Summary copied',
                      'ar': 'تم نسخ الملخص', 'jv': 'Ringkesan disalin',
                      'su': 'Ringkesan disalin', 'zh': '已复制摘要',
                      'ja': '要約をコピーしました', 'es': 'Resumen copiado'}
T['copySummary'] = {'id': 'Salin ringkasan', 'en': 'Copy summary',
                    'ar': 'نسخ الملخص', 'jv': 'Salin ringkesan',
                    'su': 'Salin ringkesan', 'zh': '复制摘要',
                    'ja': '要約をコピー', 'es': 'Copiar resumen'}
T['saveRule'] = {'id': 'Simpan aturan', 'en': 'Save rule', 'ar': 'حفظ القاعدة',
                 'jv': 'Simpen aturan', 'su': 'Simpen aturan', 'zh': '保存规则',
                 'ja': 'ルールを保存', 'es': 'Guardar norma'}
T['removeBookmark'] = {'id': 'Hapus dari simpanan', 'en': 'Remove from saved',
                       'ar': 'إزالة من المحفوظات', 'jv': 'Busak saka simpenan',
                       'su': 'Pupus tina simpenan', 'zh': '从收藏中移除',
                       'ja': '保存から削除', 'es': 'Quitar de guardados'}
T['relatedRules'] = {'id': 'Masih satu topik', 'en': 'More on this topic',
                     'ar': 'المزيد في هذا الموضوع', 'jv': 'Isih siji topik',
                     'su': 'Masih hiji topik', 'zh': '相关主题',
                     'ja': '関連するトピック', 'es': 'Más sobre este tema'}
T['personalNote'] = {'id': 'Catatan pribadi', 'en': 'Your note', 'ar': 'ملاحظتك',
                     'jv': 'Cathetan pribadi', 'su': 'Catetan pribadi', 'zh': '你的笔记',
                     'ja': 'あなたのメモ', 'es': 'Tu nota'}
T['saveNote'] = {'id': 'Simpan', 'en': 'Save', 'ar': 'حفظ', 'jv': 'Simpen',
                 'su': 'Simpen', 'zh': '保存', 'ja': '保存', 'es': 'Guardar'}
T['clearNote'] = {'id': 'Kosongkan', 'en': 'Clear', 'ar': 'تفريغ', 'jv': 'Kosongna',
                  'su': 'Kosongkeun', 'zh': '清空', 'ja': 'クリア', 'es': 'Vaciar'}
T['noteLengthCounter'] = {'id': '{count}/{max} karakter',
                          'en': '{count}/{max} characters',
                          'ar': '{count}/{max} حرف',
                          'jv': '{count}/{max} karakter',
                          'su': '{count}/{max} karakter',
                          'zh': '{count}/{max} 字符',
                          'ja': '{count}/{max} 文字',
                          'es': '{count}/{max} caracteres',
                          '@count': {'type': 'int'}, '@max': {'type': 'int'}}

print(f'Defined {len(T)} keys')


def main():
    files = {os.path.basename(f).replace('app_', '').replace('.arb', ''): f
             for f in glob.glob(os.path.join(ARB_DIR, 'app_*.arb'))}
    for key, by_locale in T.items():
        for loc, path in files.items():
            with open(path, 'r', encoding='utf-8') as fh:
                data = json.load(fh)
            value = by_locale.get(loc) or by_locale['id']
            data[key] = value
            meta = {k: v for k, v in by_locale.items() if k.startswith('@')}
            if meta:
                data['@' + key] = {k[1:]: v for k, v in meta.items()}
            with open(path, 'w', encoding='utf-8') as fh:
                json.dump(data, fh, ensure_ascii=False, indent=2)
                fh.write('\n')
    print(f'Applied {len(T)} keys across {len(files)} locales')


if __name__ == '__main__':
    main()

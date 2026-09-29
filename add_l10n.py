import json, sys

def add_keys(file_path, translations):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for k, v in translations.items():
        data[k] = v
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write('\n')

locales = ['id', 'en', 'ar', 'jv', 'su', 'zh', 'ja', 'es']
data = {
  'id': {
    'languageSelection': 'Pilihan Bahasa',
    'exportBackupJson': 'Ekspor Cadangan Data (JSON)',
    'copyBookmarkNotesClipboard': 'Salin bookmark dan catatan ke clipboard',
    'backupCopiedSnackbar': 'Cadangan data RuleBook berhasil disalin ke clipboard! 📋'
  },
  'en': {
    'languageSelection': 'Language Selection',
    'exportBackupJson': 'Export Data Backup (JSON)',
    'copyBookmarkNotesClipboard': 'Copy bookmarks and notes to clipboard',
    'backupCopiedSnackbar': 'RuleBook data backup successfully copied to clipboard! 📋'
  },
  'ar': {
    'languageSelection': 'اختيار اللغة',
    'exportBackupJson': 'تصدير النسخة الاحتياطية للبيانات (JSON)',
    'copyBookmarkNotesClipboard': 'نسخ الإشارات المرجعية والملاحظات إلى الحافظة',
    'backupCopiedSnackbar': 'تم نسخ النسخة الاحتياطية لبيانات RuleBook بنجاح إلى الحافظة! 📋'
  },
  'jv': {
    'languageSelection': 'Pilihan Basa',
    'exportBackupJson': 'Ékspor Cadangan Data (JSON)',
    'copyBookmarkNotesClipboard': 'Salin tetenger lan cathetan menyang clipboard',
    'backupCopiedSnackbar': 'Cadangan data RuleBook kasil disalin menyang clipboard! 📋'
  },
  'su': {
    'languageSelection': 'Pilihan Basa',
    'exportBackupJson': 'Ékspor Cadangan Data (JSON)',
    'copyBookmarkNotesClipboard': 'Salin tetengger jeung catetan ka clipboard',
    'backupCopiedSnackbar': 'Cadangan data RuleBook junun disalin ka clipboard! 📋'
  },
  'zh': {
    'languageSelection': '语言选择',
    'exportBackupJson': '导出数据备份 (JSON)',
    'copyBookmarkNotesClipboard': '将书签和笔记复制到剪贴板',
    'backupCopiedSnackbar': 'RuleBook 数据备份已成功复制到剪贴板！📋'
  },
  'ja': {
    'languageSelection': '言語選択',
    'exportBackupJson': 'データバックアップのエクスポート (JSON)',
    'copyBookmarkNotesClipboard': 'ブックマークとメモをクリップボードにコピー',
    'backupCopiedSnackbar': 'RuleBook のデータバックアップがクリップボードに正常にコピーされました！📋'
  },
  'es': {
    'languageSelection': 'Selección de idioma',
    'exportBackupJson': 'Exportar copia de seguridad de datos (JSON)',
    'copyBookmarkNotesClipboard': 'Copiar marcadores y notas al portapapeles',
    'backupCopiedSnackbar': '¡La copia de seguridad de los datos de RuleBook se copió al portapapeles! 📋'
  }
}

for loc in locales:
    add_keys(f'lib/l10n/app_{loc}.arb', data[loc])


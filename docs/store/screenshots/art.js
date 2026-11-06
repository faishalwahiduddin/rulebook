// Rulebook — scholar midnight navy with gold book-ribbon curves
(function () {
  const GOLD = '#F59E0B';
  const ribbon = 'M-50,1380 C1080,1220 2160,1540 3240,1280 S4100,1460 4400,1350';
  window.STORE_ART = {
    generic: false,
    theme: { bg: 'linear-gradient(160deg, #1E3A5F 0%, #0F1D30 55%, #070E18 100%)', ink: '#FFFFFF' },
    panoramaSvg:
      '<svg viewBox="0 0 4320 1920" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">' +
        '<path d="' + ribbon + '" fill="none" stroke="' + GOLD + '" stroke-width="8" opacity=".6"/>' +
      '</svg>',
    rtlReverse: true
  };
})();

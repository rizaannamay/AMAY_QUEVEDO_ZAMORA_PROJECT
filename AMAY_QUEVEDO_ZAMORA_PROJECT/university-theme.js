/**
 * university-theme.js
 * Applies the active university theme to ALL pages.
 * - Adds body class: theme-intramurals / theme-foundation / theme-womens / theme-christmas / theme-default
 * - Sets CSS custom properties on :root
 * - Reads from localStorage immediately (zero flash), then confirms from DB
 * - Syncs across browser tabs via storage event
 */
(function () {
    'use strict';

    var THEMES = {
        'Default': {
            cls:         'theme-default',
            header:      '#c9920a',
            accent:      '#c9920a',
            accentDark:  '#a87800',
            surface:     'rgba(255,255,255,0.92)',
            border:      'rgba(201,146,10,0.25)',
            text:        '#1a2a3a',
            muted:       '#6b7c8f',
            activeBg:    '#fef9e7'
        },
        'Intramurals': {
            cls:         'theme-intramurals',
            header:      'linear-gradient(135deg,#f97316 0%,#c2410c 48%,#431407 100%)',
            accent:      '#ff7b00',
            accentDark:  '#c2410c',
            surface:     'rgba(15,15,15,0.68)',
            border:      'rgba(255,123,0,0.25)',
            text:        '#ffffff',
            muted:       '#d1d5db',
            activeBg:    'rgba(255,123,0,0.18)'
        },
        'FoundationWeek': {
            cls:         'theme-foundation',
            header:      'linear-gradient(135deg,#f5b700 0%,#facc15 50%,#ffd84d 100%)',
            accent:      '#eab308',
            accentDark:  '#b77900',
            surface:     'rgba(255,255,255,0.90)',
            border:      'rgba(234,179,8,0.35)',
            text:        '#152033',
            muted:       '#6b5b3e',
            activeBg:    '#fff4c4'
        },
        'WomensMonth': {
            cls:         'theme-womens',
            header:      'linear-gradient(135deg,#581c87 0%,#7e22ce 48%,#a855f7 100%)',
            accent:      '#7e22ce',
            accentDark:  '#581c87',
            surface:     'rgba(255,255,255,0.90)',
            border:      'rgba(126,34,206,0.30)',
            text:        '#172033',
            muted:       '#64748b',
            activeBg:    '#f3e8ff'
        },
        'Christmas': {
            cls:         'theme-christmas',
            header:      'linear-gradient(135deg,#b91c1c 0%,#991b1b 55%,#7f1d1d 100%)',
            accent:      '#15803d',
            accentDark:  '#166534',
            surface:     'rgba(255,255,255,0.92)',
            border:      'rgba(21,128,61,0.30)',
            text:        '#0f172a',
            muted:       '#475569',
            activeBg:    '#dcfce7'
        }
    };

    var ALL_CLASSES = [
        'theme-default','theme-intramurals','theme-foundation',
        'theme-womens','theme-christmas'
    ];

    function applyUniversityTheme(name) {
        if (!name) name = 'Default';
        var t = THEMES[name] || THEMES['Default'];
        var r = document.documentElement;
        var b = document.body;
        if (!b) return;

        // 1. Swap body class
        ALL_CLASSES.forEach(function(c){ b.classList.remove(c); });
        b.classList.add(t.cls);

        // 2. Set CSS custom properties
        r.style.setProperty('--uni-header-bg',  t.header);
        r.style.setProperty('--uni-accent',     t.accent);
        r.style.setProperty('--uni-accent-dark',t.accentDark);
        r.style.setProperty('--surface',        t.surface);
        r.style.setProperty('--border',         t.border);
        r.style.setProperty('--page-text',      t.text);
        r.style.setProperty('--primary',        t.text);
        r.style.setProperty('--muted',          t.muted);
        r.style.setProperty('--active-bg',      t.activeBg);

        // 3. Also keep data-uni-theme for any legacy selectors
        b.setAttribute('data-uni-theme', name);

        try { localStorage.setItem('campus_uni_theme', name); } catch(e) {}
    }

    window.applyUniversityTheme = applyUniversityTheme;
    window.UNIVERSITY_THEMES    = THEMES;

    // Apply from localStorage immediately — zero flash
    var saved = null;
    try { saved = localStorage.getItem('campus_uni_theme'); } catch(e) {}
    if (saved) applyUniversityTheme(saved);

    // Confirm from DB (keeps in sync across devices/sessions)
    fetch('UserMgmtHandler.ashx?action=getTheme', { credentials: 'same-origin' })
        .then(function(r){ return r.json(); })
        .then(function(res){ if (res && res.ok && res.theme) applyUniversityTheme(res.theme); })
        .catch(function(){});

    // Sync across browser tabs
    window.addEventListener('storage', function(e){
        if (e.key === 'campus_uni_theme') applyUniversityTheme(e.newValue);
        // When dark/light mode toggles, re-apply current theme so bg swaps correctly
        if (e.key === 'campus_theme') {
            var current = null;
            try { current = localStorage.getItem('campus_uni_theme'); } catch(err) {}
            applyUniversityTheme(current || 'Default');
        }
    });
})();

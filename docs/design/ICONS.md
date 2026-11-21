# RuleBook Icon System

A bespoke 24×24 vector icon library for RuleBook (`rulebook`), reflecting pocket regulations, standard operating procedures, legal compliance, and penalty calculators.

## Visual Language & Geometry

- **Grid**: 24×24 px viewport (`viewBox="0 0 24 24"`), 2px boundary padding.
- **Stroke**: Uniform `1.75px` stroke weight (`stroke-width="1.75"`), rounded terminals (`stroke-linecap="round"`), smooth join transitions (`stroke-linejoin="round"`).
- **Tone**: Authoritative, concise, Swiss-modern civic clarity. Structured outlines combined with subtle duotone infill (`fill="currentColor"` at `0.25`–`0.35` opacity) for secondary surfaces (book pages, calculator keypads, shield emblems, audit clipboards, ribbon bookmarks).
- **Coloring**: Strict `currentColor` inheritance throughout. All assets cleanly tint to theme accents (`AppColors.brand`, `AppColors.brandSoft`, etc.) across light and dark modes.

## Icon Roster

### Navigation (Active / Inactive Pairs)
| Inactive | Active | Destination | Visual Metaphor |
|---|---|---|---|
| `nav_rules` | `nav_rules_active` | Rules Catalog (`/`) | Architectural open law book with spine ledger |
| `nav_calculator` | `nav_calculator_active` | Penalty & Severance (`/calculator`) | Precision regulatory penalty calculation keypad |
| `nav_sop` | `nav_sop_active` | SOP Guidelines (`/sop`) | Emergency & crisis standard operating procedure shield |
| `nav_compliance` | `nav_compliance_active` | Audit Checklists (`/checklist`) | Regulatory compliance checklist ledger with verification marks |
| `nav_bookmarks` | `nav_bookmarks_active` | Bookmarked Clauses (`/bookmarks`) | Ribbon bookmark marking critical statutory articles |

### Domain Glyphs (Legal, Regulatory & SOP)
- `gavel`: Legal judgment and statutory enforcement gavel.
- `scale`: Justice balance scales and proportional sentencing.
- `traffic`: Traffic regulation signal light.
- `briefcase`: Labor law, severance rules, and employment contracts.
- `lock`: Cybersecurity, personal data protection (UU PDP), and confidentiality.
- `cart`: Consumer protection and fair commercial trade laws.
- `hardhat`: Occupational safety, workplace health, and K3 protocols.
- `megaphone`: Freedom of speech, press rights, and public notice.
- `shield`: Offline compliance seal and legal certainty guarantee.
- `checklist`: Step-by-step procedural audit ledger.
- `search`: Statutory article search loupe.
- `settings`: System preferences cog.

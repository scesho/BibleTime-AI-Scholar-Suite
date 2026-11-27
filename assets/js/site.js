// BibleTime AI Scholar Suite - Landing Page Script (Trilingual IT/EN/ES)

const I18N = {
  it: {
    nav_features: "Caratteristiche",
    nav_hubs: "5 Hubs",
    nav_pricing: "Prezzo & Offerta",
    nav_manual: "Manuale Utente (?)",
    nav_download: "Download",
    nav_contact: "Contatti",
    manual_back_home: "← Torna alla Home",
    manual_pricing_btn: "Prezzo Offerta (€199)",
    manual_brand_subtitle: "Manuale d'Uso (?)",
    hero_badge: "✨ Rilascio Ufficiale Commerciale • Versione 2026",
    hero_title: "L'Accademia Esegetica & Biblioteca Teologica AI Definitiva",
    hero_subtitle: "519 Moduli SWORD offline, Scriptorium AI con 27 moduli scientifici, Matrice Interlineare Inversa, Atlante 4D e Predicazione su Widescreen. Nessun abbonamento mensile.",
    hero_cta_trial: "🚀 Prova Gratis 30 Giorni",
    hero_cta_buy: "💎 Acquista Licenza a Vita (€199+IVA)",
    feat_title: "Potenza Scientifica Senza Precedenti",
    feat_sub: "Tutto ciò di cui hai bisogno per l'esegesi, lo studio profondo e la predicazione biblica.",
    feat_1_title: "519 Moduli SWORD Offline & Motore Canonico",
    feat_1_desc: "Tutte le Bibbie storiche (LND, Diodati 1607, KJV, Reina-Valera, Vulgate, LXX, WLC ebraica con cantillazioni, Textus Receptus, Tischendorf), i commentari patristici (Matthew Henry, Ginevra 1599, Scofield, Jamieson-Fausset-Brown, TSK con 500.000 cross-ref) e i lessici Strong direttamente sul tuo computer senza dipendere da internet.",
    feat_2_title: "Scriptorium AI (27 Moduli Esegetici)",
    feat_2_desc: "Esegesi accademica profonda in 3 livelli configurabili (Agile, Deep, Magnum Opus): analisi morfologica, lessicale, storico-grammaticale, teologia biblica e sistematica, tipologia cristologica, retorica semitica, ermeneutica patristica e riformata, omiletica contestuale e sintassi delle clausole.",
    feat_3_title: "Mappe Storiche Interattive & Routing Biblico",
    feat_3_desc: "Visualizzatore geografico dinamico su mappa satellitare Leaflet/WebGL. Rotte storiche calcolate: Esodo dall'Egitto verso la Terra Promessa, Viaggi Missionari dell'Apostolo Paolo (1°, 2°, 3° viaggio e verso Roma), Conquista di Canaan, Ministero di Gesù in Galilea e Giudea, con Map Creator Studio per tracciare mappe personalizzate.",
    feat_4_title: "Enciclopedia Personaggi Biblici & Genealogie",
    feat_4_desc: "Database prosopografico relazionale di tutti i personaggi dell'Antico e Nuovo Testamento. Albero genealogico e dinastico interattivo, legami familiari, alleanze, cronologia biografica, riferimenti scritturali correlati ed etimologia del nome originale in Ebraico, Aramaico e Greco.",
    feat_5_title: "Atlante Sacro WGS84 4D & Cronologia Continua",
    feat_5_desc: "1.652 luoghi biblici georeferenziati con coordinate satellitari WGS84 e livelli di certezza archeologica certificati da OpenBible. Confini storici degli imperi antichi e asse temporale continuo sincronizzato da Adamo ed Eva fino al I secolo d.C.",
    feat_6_title: "Reverse Interlinear a 5 Livelli & Paleo-Ebraico",
    feat_6_desc: "Matrice scientifica a 5 livelli: allineamento token per token tra traduzione moderna e testo originale, traslitterazione fonetica, lemmi originali, codici Strong cliccabili, decodifica morfologica completa (OSHM per l'ebraico, Robinson per il greco) e glifi in Paleo-Ebraico e Fenicio antico.",
    feat_7_title: "One-Click Dossier 360° & Guida Omiletica A4",
    feat_7_desc: "Generazione istantanea con 1 click della scheda omiletica e dossier esegetico a 360° per il pulpito o lo studio biblico di gruppo. Impaginazione accademica perfetta pronta per la stampa A4 o export PDF, con sinossi bilingue, scaletta del sermone in punti, retroterra storico e domande per l'applicazione pastorale.",
    feat_8_title: "Socratic Council AI (Concilio a 5 Voci)",
    feat_8_desc: "Tavola rotonda dialettica istantanea tra 5 giganti della storia della Chiesa: Sant'Agostino d'Ippona (Patristica Latina), San Giovanni Crisostomo (Scuola di Antiochia), Martin Lutero (Riforma / Sola Fide), Giovanni Calvino (Tradizione Riformata / Soli Deo Gloria), Charles Haddon Spurgeon (Omiletica Evangelistica). Sintesi di consenso, tensioni feconde e applicazioni pastorali dirette.",
    feat_9_title: "Visualizzatore Chiasmi ad Arco (Sintassi Strutturale)",
    feat_9_desc: "Algoritmo euristico per l'individuazione e la visualizzazione ad arco di strutture chiastiche e parallelismi invertiti concentrici (A-B-C-B'-A'). Evidenziazione visiva immediata del fulcro teologico/pivot e commento sulla rilevanza letteraria ed esegetica.",
    feat_10_title: "Syntax Tree & Quiz Sintattico Seminariale",
    feat_10_desc: "Alberi sintattici e gerarchici delle proposizioni ebraiche e greche (proposizione reggente, subordinate, participi, costrutti accusativi e complementi). Include il Quiz Sintattico Interattivo seminariale per l'allenamento nell'analisi grammaticale delle lingue bibliche.",
    feat_11_title: "RAG Semantico & Biblioteca Patristica Ibrida",
    feat_11_desc: "Motore vettoriale locale (ChromaDB + SQLite) con oltre 67 opere integrali dei Padri della Chiesa e Riformatori pre-caricate. Ingestione Drag & Drop universale di libri e appunti personali in PDF, Word (.docx), TXT o URL Web con auto-tagging AI dei versetti e ricerca concettuale per somiglianza semantica.",
    feat_12_title: "Apparato Critico NA28 / UBS5 & Manoscritti Antichi",
    feat_12_desc: "Collazione scientifica versetto per versetto con varianti testuali dei papiri del Nuovo Testamento (P45, P46, P66, P75) e dei codici unciali antichi (Codex Sinaiticus, Codex Vaticanus, Codex Alexandrinus) per l'analisi rigorosa della critica del testo.",
    feat_13_title: "Workspace Multi-Pane & Synchronized Scroll-Lock",
    feat_13_desc: "Layout multimonitor fino a 4 riquadri affiancati e sincronizzati (Bibbie in lingue diverse, commentari patristici, dizionari lessicali e note personali) con scorrimento e allineamento coordinato in tempo reale al versetto attivo.",
    feat_14_title: "Modalità Pulpito & Presentazione Slide 16:9",
    feat_14_desc: "Schermata da podio ultra-contrastata dark mode con caratteri scalabili fino a 48px, teleprompter di appunti omiletici, cronometro oratorio per la predicazione e generatore automatico istantaneo di diapositive 16:9 widescreen proiettabili direttamente su beamer o secondo monitor di sala.",
    feat_15_title: "Copilot AI Esegetico Contestuale (Ctrl+L)",
    feat_15_desc: "Assistente conversazionale intelligente con accesso RAG immediato al passo biblico visualizzato, ai codici Strong, alle note di studio e all'intero corpus teologico per rispondere a qualsiasi quesito dottrinale o linguistico in tempo reale.",
    feat_16_title: "Audio Bibbia & Riproduttore Oratorio",
    feat_16_desc: "Lettura vocale oratoria continua con evidenziazione versetto per versetto, velocità di riproduzione regolabile e riproduzione in background per la meditazione orante delle Sacre Scritture.",
    feat_17_title: "Visual Router AI Multi-Provider (Libertà Totale)",
    feat_17_desc: "Flessibilità assoluta senza abbonamenti ricorrenti: collega provider gratuiti (Mistral AI, Google Gemini, Groq), provider commerciali a consumo (OpenRouter, OpenAI, Anthropic Claude, DeepSeek, Cerebras, Sambanova) oppure modelli locali 100% offline (Ollama / Llama 3) a costo zero.",
    feat_18_title: "Taccuino Personale, Note & Evidenziazioni",
    feat_18_desc: "Sistema di annotazione biblica personale con formattazione rich text (Markdown), evidenziatore cromatico a 6 tonalità semantiche, tagging tematico dei versetti ed esportazione in PDF o stampa per studi biblici e gruppi di discepolato.",
    price_badge: "OFFERTA LANCIO -50%",
    price_title: "Licenza Perpetua a Vita",
    price_sub_banner: "Offerta speciale di lancio limitata nel tempo",
    price_old: "Prezzo finale di listino: €399 + IVA",
    price_current: "€199",
    price_tax: "+ IVA (Una Tantum)",
    price_feat_1: "Licenza Perpetua a Vita (Nessun abbonamento mensile)",
    price_feat_2: "Installazione autorizzata fino a 2 PC (Fisso + Portatile)",
    price_feat_3: "Tutti i 519 Moduli SWORD e Database Esegetici inclusi",
    price_feat_4: "Scriptorium AI + Copilot AI senza limiti",
    price_feat_5: "Crittografia asimmetrica Ed25519 con Certificato PDF Ufficiale",
    price_feat_6: "Fattura elettronica con Partita IVA o Codice Fiscale",
    price_feat_7: "Libertà Totale AI: chiavi gratuite, proprie commerciali (OpenAI, Claude, DeepSeek) o 100% offline",
    price_cta: "Richiedi Licenza Commerciale (€199 + IVA)",
    price_contact_note: "Per ordini diretti, preventivi o fatturazione scrivi a:",
    down_title: "Inizia Subito: 30 Giorni di Prova Inclusi",
    down_sub: "7 studi completi al giorno senza filigrana. Nessuna carta di credito richiesta.",
    tab_win: "Windows 10 / 11",
    tab_mac: "macOS (Apple / Intel)",
    tab_linux: "Linux (Mint/Ubuntu/Debian)",
    win_btn: "Scarica Installer Windows (.zip)",
    win_cmd_btn: "Download diretto .cmd",
    win_bat_btn: "Download diretto .bat",
    win_note: "Scarica il file .zip, estrailo e fai doppio click su Install_BibleTime.cmd.",
    mac_btn: "Scarica Installer macOS (.zip)",
    mac_cmd_btn: "Download diretto .command",
    mac_note: "Compatibile con macOS Sonoma, Ventura e Monterey (Apple Silicon M1/M2/M3 e Intel).",
    mac_gatekeeper_tip: "💡 Procedura di sblocco macOS (Apple Gatekeeper - solo al 1° avvio): Fai Tasto Destro (o Control + Clic) su Install_BibleTime.command e seleziona \"Apri\", quindi conferma cliccando su \"Apri comunque\". In alternativa su macOS Sonoma/Sequoia: apri Impostazioni di Sistema ➔ Privacy e sicurezza ➔ scorri in basso su Sicurezza e clicca su \"Apri comunque\". L'autorizzazione viene salvata per sempre e non verrà mai più richiesta.",
    linux_note: "Apri il terminale e incolla questo comando 1-click per scaricare e installare:",
    linux_zip_btn: "Scarica Pacchetto Linux (.zip)",
    copy_btn: "Copia",
    copied_btn: "Copiato!",
    contact_title: "Contatti & Assistenza Commerciale",
    contact_sub: "Hai bisogno di informazioni sulla licenza perpetua, preventivi dedicati per Chiese, Seminari o Istituti Teologici, emissione fattura elettronica intestata ad Alfa Omega S.r.l., o assistenza tecnica diretta? Contatta il nostro team di supporto esegetico e accademico:",
    contact_note: "Risposte garantite entro 24 ore lavorative. Assistenza specialistica diretta senza intermediari o chatbot.",
    footer_text: "BibleTime AI Scholar Suite — Proprietà Intellettuale & Suite Accademica Esegetica. Distribuito e fatturato da Alfa Omega S.r.l. Tutti i diritti riservati."
  },
  en: {
    nav_features: "Features",
    nav_hubs: "5 Hubs",
    nav_pricing: "Pricing & Promo",
    nav_manual: "User Manual (?)",
    nav_download: "Download",
    nav_contact: "Contact",
    manual_back_home: "← Back to Home",
    manual_pricing_btn: "Launch Promo ($219 USD)",
    manual_brand_subtitle: "User Manual (?)",
    hero_badge: "✨ Official Commercial Release • 2026 Edition",
    hero_title: "The Ultimate AI Exegetical Academy & Theological Library",
    hero_subtitle: "519 offline SWORD modules, Scriptorium AI with 27 scientific modules, Reverse Interlinear, 4D Atlas and Widescreen Preaching. Zero recurring subscriptions.",
    hero_cta_trial: "🚀 Free 30-Day Trial",
    hero_cta_buy: "💎 Get Lifetime License ($219 USD)",
    feat_title: "Unprecedented Scientific Power",
    feat_sub: "Everything you need for in-depth exegesis, biblical study, and pulpit preaching.",
    feat_1_title: "519 Offline SWORD Modules & Canonical Engine",
    feat_1_desc: "All historical Bibles (KJV, ASV, Vulgate, LXX, Hebrew WLC with cantillation marks, Textus Receptus, Tischendorf), patristic commentaries (Matthew Henry, Geneva 1599, Scofield, Jamieson-Fausset-Brown, TSK with 500,000 cross-references), and Strong's lexicons right on your device with 100% offline autonomy.",
    feat_2_title: "Scriptorium AI (27 Exegetical Modules)",
    feat_2_desc: "Deep academic exegesis across 3 configurable depths (Agile, Deep, Magnum Opus): morphological, lexical, historical-grammatical analysis, biblical & systematic theology, Christological typology, Semitic rhetoric, patristic & reformed hermeneutics, contextual homiletics, and clause syntax.",
    feat_3_title: "Interactive Historical Maps & Biblical Routing",
    feat_3_desc: "Dynamic interactive historical cartography on Leaflet/WebGL satellite maps. Pre-calculated historical routes: Exodus from Egypt to the Promised Land, Apostle Paul's Missionary Journeys (1st, 2nd, 3rd, and Rome voyage), Conquest of Canaan, Jesus' ministry in Galilee and Judea, with Map Creator Studio for custom routes.",
    feat_4_title: "Biblical Prosopography & Dynastic Genealogies",
    feat_4_desc: "Comprehensive relational prosopographical database of all Old and New Testament biblical characters. Interactive genealogical and dynastic family trees, kinship ties, biographical timelines, linked biblical occurrences, and original Hebrew/Aramaic/Greek etymological root meanings.",
    feat_5_title: "WGS84 Sacred Atlas 4D & Continuous Chronology",
    feat_5_desc: "1,652 georeferenced biblical locations with high-precision WGS84 satellite coordinates and OpenBible archaeological certainty ratings. Historical imperial boundaries and continuous synchronized timeline spanning from Adam and Eve to the 1st century AD.",
    feat_6_title: "5-Level Reverse Interlinear & Paleo-Hebrew",
    feat_6_desc: "5-level scientific matrix: token-by-token alignment between modern translation and original text, phonetic transliteration, original lemmas, clickable Strong's codes, full morphological parsing (OSHM Hebrew, Robinson Greek), and ancient Paleo-Hebrew / Phoenician glyphs.",
    feat_7_title: "One-Click 360° Dossier & A4 Homiletical Guide",
    feat_7_desc: "Instant 1-click generation of the 360° homiletical dossier and study guide for pulpit preaching or small groups. Formatted for A4 print and PDF export with bilingual scripture synopsis, structured sermon outline points, historical background, and pastoral application questions.",
    feat_8_title: "Socratic Council AI (5-Voice Polyphonic Council)",
    feat_8_desc: "Instant dialectical round-table among 5 giants of Church history: St. Augustine of Hippo (Latin Patristics), St. John Chrysostom (School of Antioch), Martin Luther (Reformation / Sola Fide), John Calvin (Reformed Tradition / Soli Deo Gloria), Charles Haddon Spurgeon (Evangelical Homiletics). Consensus synthesis, dialectical tensions, and direct pastoral applications.",
    feat_9_title: "Arc Chiasm Visualizer (Structural Syntax)",
    feat_9_desc: "Heuristic algorithm for detecting and displaying concentric chiastic structures and inverted parallelisms (A-B-C-B'-A'). Visual highlight of the central theological pivot/climax and commentary on its literary and exegetical significance.",
    feat_10_title: "Syntax Tree & Seminary Grammar Quiz",
    feat_10_desc: "Syntactic and hierarchical trees of original Hebrew and Greek clauses (main clauses, subordinates, participles, accusative constructs, and modifiers). Includes an interactive seminary quiz mode for rigorous original language grammar training.",
    feat_11_title: "Semantic RAG & Hybrid Patristic Library",
    feat_11_desc: "Local vector engine (ChromaDB + SQLite) with over 67 unabridged patristic and reformational works pre-indexed. Universal drag & drop ingestion of personal books and notes in PDF, Word (.docx), TXT, or web URLs with AI verse auto-tagging and semantic vector similarity search.",
    feat_12_title: "NA28 / UBS5 Critical Apparatus & Ancient Manuscripts",
    feat_12_desc: "Verse-by-verse scientific collation with textual variants from ancient New Testament papyri (P45, P46, P66, P75) and early uncial codices (Codex Sinaiticus, Vaticanus, Alexandrinus) for rigorous textual criticism.",
    feat_13_title: "Workspace Multi-Pane & Synchronized Scroll-Lock",
    feat_13_desc: "Multi-monitor workspace tiling with up to 4 synchronized panes (parallel Bibles in multiple languages, patristic commentaries, lexicons, and personal notes) with real-time coordinated scroll-lock on the active verse.",
    feat_14_title: "Pulpit Stage & 16:9 Widescreen Slide Deck",
    feat_14_desc: "High-contrast dark podium view with fonts resizable up to 48px, homiletical teleprompter notes, sermon countdown stopwatch, and instant 16:9 widescreen slide deck generator ready for church beamers or external auditorium screens.",
    feat_15_title: "Contextual Exegetical Copilot AI (Ctrl+L)",
    feat_15_desc: "Contextual conversational AI assistant with instant RAG access to the active Scripture passage, Strong's lexical keys, personal notes, and theological library to answer complex doctrinal and linguistic questions in real time.",
    feat_16_title: "Audio Bible & Oratorical Player",
    feat_16_desc: "Continuous oratorical voice playback with verse-by-verse visual highlighting, adjustable speed controls, and background playback for prayerful scripture meditation.",
    feat_17_title: "Multi-Provider AI Visual Router (Total Freedom)",
    feat_17_desc: "Absolute freedom with zero recurring subscriptions: connect free AI providers (Mistral AI, Google Gemini, Groq), pay-as-you-go commercial keys (OpenRouter, OpenAI, Anthropic Claude, DeepSeek, Cerebras, Sambanova), or 100% offline local models (Ollama / Llama 3).",
    feat_18_title: "Personal Notebook, Notes & Exegetical Tags",
    feat_18_desc: "Personal biblical notebook system with rich Markdown formatting, 6-tone semantic color highlighters, verse topical tagging, and instant PDF/print export for Bible studies and discipleship groups.",
    price_badge: "LAUNCH OFFER -50%",
    price_title: "Perpetual Lifetime License",
    price_sub_banner: "Limited-time early adopter launch discount",
    price_old: "Regular list price: $449 USD",
    price_current: "$219 USD",
    price_tax: "One-Time (No monthly subscriptions)",
    price_feat_1: "Perpetual Lifetime License (No recurring monthly fees)",
    price_feat_2: "Authorized on up to 2 PCs (Desktop Studio + Laptop)",
    price_feat_3: "All 519 SWORD Modules & Exegetical Databases included",
    price_feat_4: "Scriptorium AI + Copilot AI with unlimited access",
    price_feat_5: "Ed25519 asymmetric cryptography with Official PDF Certificate",
    price_feat_6: "Commercial invoice with Tax ID / Export 0% VAT",
    price_feat_7: "Total AI Freedom: free keys, your own commercial keys (OpenAI, Claude, DeepSeek) or 100% offline",
    price_cta: "Request Commercial License ($219 USD)",
    price_contact_note: "For direct orders, custom quotes, or invoicing write to:",
    down_title: "Start Now: 30-Day Free Trial Included",
    down_sub: "7 full unwatermarked studies daily. No credit card required.",
    tab_win: "Windows 10 / 11",
    tab_mac: "macOS (Apple / Intel)",
    tab_linux: "Linux (Mint/Ubuntu/Debian)",
    win_btn: "Download Windows Installer (.zip)",
    win_cmd_btn: "Direct .cmd download",
    win_bat_btn: "Direct .bat download",
    win_note: "Download the .zip, extract it and double click Install_BibleTime.cmd.",
    mac_btn: "Download macOS Installer (.zip)",
    mac_cmd_btn: "Direct .command download",
    mac_note: "Compatible with macOS Sonoma, Ventura, Monterey (Apple Silicon M1/M2/M3 and Intel).",
    mac_gatekeeper_tip: "💡 macOS First-Launch Approval (Apple Gatekeeper - one time only): Right-Click (or Control + Click) on Install_BibleTime.command, select \"Open\", and click \"Open Anyway\". Alternatively on macOS Sonoma/Sequoia: open System Settings ➔ Privacy & Security ➔ scroll down to Security and click \"Open Anyway\". Approval is permanently stored and will never be asked again.",
    linux_note: "Open your terminal and paste this 1-click command to install:",
    linux_zip_btn: "Download Linux Package (.zip)",
    copy_btn: "Copy",
    copied_btn: "Copied!",
    contact_title: "Contact & Direct Commercial Support",
    contact_sub: "Need details on our perpetual lifetime license, custom volume quotes for Churches, Seminaries, or Theological Colleges, commercial invoicing issued by Alfa Omega S.r.l., or technical support? Our academic team is at your complete service:",
    contact_note: "Fast response guaranteed within 24 business hours. Direct specialist support with no intermediaries or automated chatbots.",
    footer_text: "BibleTime AI Scholar Suite — Intellectual Property & Theological Suite. Distributed and invoiced by Alfa Omega S.r.l. All rights reserved."
  },
  es: {
    nav_features: "Características",
    nav_hubs: "5 Hubs",
    nav_pricing: "Precio & Oferta",
    nav_manual: "Manual de Usuario (?)",
    nav_download: "Descargar",
    nav_contact: "Contacto",
    manual_back_home: "← Volver al Inicio",
    manual_pricing_btn: "Precio Oferta ($219 USD)",
    manual_brand_subtitle: "Manual de Usuario (?)",
    hero_badge: "✨ Lanzamiento Comercial Oficial • Edición 2026",
    hero_title: "La Academia Exegética & Biblioteca Teológica IA Definitiva",
    hero_subtitle: "519 módulos SWORD offline, Scriptorium IA con 27 módulos científicos, Interlineal Inverso, Atlas 4D y Predicación en Widescreen. Cero suscripciones mensuales.",
    hero_cta_trial: "🚀 Prueba Gratis 30 Días",
    hero_cta_buy: "💎 Licencia de por Vida ($219 USD)",
    feat_title: "Poder Científico Sin Precedentes",
    feat_sub: "Todo lo que necesitas para la exégesis profunda, el estudio bíblico y la predicación pastoral.",
    feat_1_title: "519 Módulos SWORD Offline & Motor Canónico",
    feat_1_desc: "Todas las Biblias históricas (Reina-Valera 1909, KJV, Vulgata, Septuaginta LXX, WLC hebrea con cantilación, Textus Receptus, Tischendorf), comentarios patrísticos (Matthew Henry, Ginebra 1599, Scofield, JFB, TSK con 500.000 referencias cruzadas) y léxicos Strong en tu equipo sin depender de internet.",
    feat_2_title: "Scriptorium IA (27 Módulos Exegéticos)",
    feat_2_desc: "Exégesis académica profunda en 3 niveles configurables (Ágil, Profunda, Magnum Opus): análisis morfológico, léxico, histórico-gramatical, teología bíblica y sistemática, tipología cristológica, retórica semítica, hermenéutica patrística y reformada, homilética contextual y sintaxis de cláusulas.",
    feat_3_title: "Mapas Históricos Interactivos & Rutas Bíblicas",
    feat_3_desc: "Cartografía histórica interactiva y dinámica sobre mapas satelitales Leaflet/WebGL. Rutas históricas calculadas: Éxodo de Egipto a la Tierra Prometida, Viajes Misioneros del Apóstol Pablo (1º, 2º, 3º y viaje a Roma), Conquista de Canaán, Ministerio de Jesús en Galilea y Judea, con Map Creator Studio para trazar mapas propios.",
    feat_4_title: "Enciclopedia de Personajes Bíblicos & Genealogías",
    feat_4_desc: "Base de datos prosopográfica relacional de todos los personajes bíblicos del Antiguo y Nuevo Testamento. Árboles genealógicos y dinásticos interactivos, lazos familiares, cronología biográfica, referencias escriturales asociadas y etimología original en hebreo, arameo y griego.",
    feat_5_title: "Atlas Sagrado WGS84 4D & Cronología Continua",
    feat_5_desc: "1.652 lugares bíblicos georreferenciados con coordenadas satelitales WGS84 y niveles de certeza arqueológica certificados por OpenBible. Fronteras históricas de imperios antiguos y eje cronológico continuo desde Adán y Eva hasta el siglo I d.C.",
    feat_6_title: "Interlineal Inverso a 5 Niveles & Paleo-Hebreo",
    feat_6_desc: "Matriz científica de 5 niveles: alineación palabra por palabra entre traducción moderna y texto original, transliteración fonética, lemas originales, códigos Strong interactivos, análisis morfológico completo (OSHM hebreo, Robinson griego) y glifos en Paleo-Hebreo y Fenicio.",
    feat_7_title: "Dosier 360° en 1 Clic & Guía Homilética A4",
    feat_7_desc: "Generación instantánea con 1 clic del dosier exegético 360° y guía de estudio homilética para el púlpito o células bíblicas. Maquetación para impresión A4 y exportación PDF con sinopsis bilingüe, bosquejo del sermón en puntos clave, trasfondo histórico y preguntas de aplicación pastoral.",
    feat_8_title: "Socratic Council IA (Concilio a 5 Voces)",
    feat_8_desc: "Mesa redonda dialéctica instantánea entre 5 gigantes de la historia eclesiástica: San Agustín de Hipona (Patrística Latina), San Juan Crisóstomo (Escuela de Antioquía), Martín Lutero (Reforma / Sola Fide), Juan Calvino (Tradición Reformada / Soli Deo Gloria), Charles Haddon Spurgeon (Homilética Evangelística). Síntesis de consenso, tensión dialéctica y aplicación pastoral.",
    feat_9_title: "Visualizador de Quiasmos en Arco (Sintaxis)",
    feat_9_desc: "Algoritmo heurístico para detectar y visualizar estructuras quiásticas concéntricas y paralelismos invertidos (A-B-C-B'-A'). Resalte visual inmediato del fulcro/clímax teológico central y comentario sobre su relevancia literaria y exegética.",
    feat_10_title: "Syntax Tree & Quiz Sintáctico Seminarial",
    feat_10_desc: "Árboles sintácticos y jerárquicos de las cláusulas originales hebreas y griegas (proposiciones principales, subordinadas, participios, complementos y construcciones acusativas). Incluye el Quiz Sintáctico Interactivo seminarial para entrenar el análisis gramatical.",
    feat_11_title: "RAG Semántico & Biblioteca Patrística Híbrida",
    feat_11_desc: "Motor vectorial local (ChromaDB + SQLite) con más de 67 obras completas de los Padres de la Iglesia y Reformadores. Ingesta universal drag & drop de libros y apuntes personales en PDF, Word (.docx), TXT o páginas web con auto-etiquetado IA de versículos y búsqueda semántica conceptual.",
    feat_12_title: "Aparato Crítico NA28 / UBS5 & Manuscritos",
    feat_12_desc: "Colación científica versículo por versículo con variantes textuales de papiros antiguos del Nuevo Testamento (P45, P46, P66, P75) y grandes códices unciales (Sinaiticus, Vaticanus, Alexandrinus) para la crítica textual rigurosa.",
    feat_13_title: "Workspace Multipanel & Synchronized Scroll-Lock",
    feat_13_desc: "Espacio de trabajo multipanel con hasta 4 vistas sincronizadas (Biblias paralelas en múltiples idiomas, comentarios patrísticos, léxicos y notas personales) con desplazamiento sincronizado en tiempo real.",
    feat_14_title: "Modo Púlpito & Presentación de Diapositivas 16:9",
    feat_14_desc: "Interfaz de púlpito de alto contraste en modo oscuro con tipografía escalable hasta 48px, teleprompter de notas homiléticas, cronómetro de predicación y generador instantáneo de diapositivas panorámicas 16:9 para proyectores de iglesia.",
    feat_15_title: "Copilot IA Exegético Contextual (Ctrl+L)",
    feat_15_desc: "Asistente conversacional inteligente con acceso RAG inmediato al pasaje bíblico visualizado, léxicos Strong, notas personales y biblioteca teológica para responder consultas doctrinales y lingüísticas en tiempo real.",
    feat_16_title: "Audio Biblia & Reproductor Oratorio",
    feat_16_desc: "Reproducción vocal oratoria continua con resaltado versículo por versículo, velocidad graduable y escucha en segundo plano para la meditación devocional y orante de las Escrituras.",
    feat_17_title: "Visual Router IA Multi-Proveedor (Libertad Total)",
    feat_17_desc: "Libertad absoluta sin cuotas mensuales: conecta proveedores de IA gratuitos (Mistral AI, Google Gemini, Groq), claves comerciales de pago por uso (OpenRouter, OpenAI, Anthropic Claude, DeepSeek, Cerebras, Sambanova) o modelos locales 100% offline (Ollama / Llama 3).",
    feat_18_title: "Cuaderno Personal, Notas & Resaltadores",
    feat_18_desc: "Cuaderno bíblico personal con formato Markdown enriquecido, resaltador semántico en 6 colores, etiquetado temático de versículos y exportación en PDF o impresión para células y discipulado.",
    price_badge: "OFERTA LANZAMIENTO -50%",
    price_title: "Licencia Perpetua de por Vida",
    price_sub_banner: "Descuento especial de lanzamiento por tiempo limitado",
    price_old: "Precio oficial de lista: $449 USD",
    price_current: "$219 USD",
    price_tax: "Pago Único (Sin suscripción mensual)",
    price_feat_1: "Licencia Perpetua de por Vida (Sin suscripciones recurrentes)",
    price_feat_2: "Instalación autorizada en hasta 2 PCs (Fijo + Portátil)",
    price_feat_3: "Todos los 519 Módulos SWORD y Bases de Datos incluidos",
    price_feat_4: "Scriptorium IA + Copilot IA con acceso ilimitado",
    price_feat_5: "Criptografía asimétrica Ed25519 con Certificado PDF Oficial",
    price_feat_6: "Factura comercial con NIF / CIF / IVA 0% Exportación",
    price_feat_7: "Libertad Total de IA: claves gratuitas, propias comerciales (OpenAI, Claude, DeepSeek) o 100% offline",
    price_cta: "Solicitar Licencia Comercial ($219 USD)",
    price_contact_note: "Para pedidos directos, cotizaciones o facturación escribe a:",
    down_title: "Comienza Ahora: 30 Días de Prueba Incluidos",
    down_sub: "7 estudios diarios completos sin marcas de agua. No se requiere tarjeta de crédito.",
    tab_win: "Windows 10 / 11",
    tab_mac: "macOS (Apple / Intel)",
    tab_linux: "Linux (Mint/Ubuntu/Debian)",
    win_btn: "Descargar Instalador Windows (.zip)",
    win_cmd_btn: "Descarga directa .cmd",
    win_bat_btn: "Descarga directa .bat",
    win_note: "Descarga el archivo .zip, extráelo y haz doble clic en Install_BibleTime.cmd.",
    mac_btn: "Descargar Instalador macOS (.zip)",
    mac_cmd_btn: "Descarga directa .command",
    mac_note: "Compatible con macOS Sonoma, Ventura, Monterey (Apple Silicon M1/M2/M3 e Intel).",
    mac_gatekeeper_tip: "💡 Procedimiento de desbloqueo en macOS (Apple Gatekeeper - solo 1.ᵉʳ inicio): Haz Clic Derecho (o Control + Clic) en Install_BibleTime.command, selecciona \"Abrir\" y confirma pulsando \"Abrir de todos modos\". De forma alternativa en macOS Sonoma/Sequoia: abre Ajustes del Sistema ➔ Privacidad y seguridad ➔ baja a Seguridad y pulsa \"Abrir de todos modos\". Esta autorización se guarda para siempre y no volverá a pedirse.",
    linux_note: "Abre la terminal y pega este comando 1-click para instalar:",
    linux_zip_btn: "Descargar Paquete Linux (.zip)",
    copy_btn: "Copiar",
    copied_btn: "¡Copiado!",
    contact_title: "Contacto & Asistencia Comercial Directa",
    contact_sub: "¿Necesitas información sobre la licencia perpetua, cotizaciones especiales para Iglesias, Seminarios o Institutos Teológicos, emisión de factura oficial a cargo de Alfa Omega S.r.l., o soporte técnico? Nuestro equipo académico está a tu completa disposición:",
    contact_note: "Respuestas garantizadas en menos de 24 horas laborales. Asistencia especializada directa sin intermediarios ni bots.",
    footer_text: "BibleTime AI Scholar Suite — Propiedad Intelectual & Suite Teológica. Distribuido y facturado por Alfa Omega S.r.l. Todos los derechos reservados."
  }
};

let currentLang = 'it';

function setLanguage(lang) {
  if (!I18N[lang]) return;
  currentLang = lang;
  localStorage.setItem('bibletime_site_lang', lang);

  // Update button active states
  document.querySelectorAll('.lang-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.lang === lang);
  });

  // Update all elements with data-i18n
  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.dataset.i18n;
    if (I18N[lang][key]) {
      el.textContent = I18N[lang][key];
    }
  });

  // Update HTML lang attribute
  document.documentElement.lang = lang;
  document.body.dataset.lang = lang;
}

function detectOS() {
  const ua = navigator.userAgent.toLowerCase();
  if (ua.includes('win')) return 'win';
  if (ua.includes('mac')) return 'mac';
  if (ua.includes('linux')) return 'linux';
  return 'win';
}

function selectDownloadTab(os) {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.os === os);
  });
  document.querySelectorAll('.tab-content').forEach(content => {
    content.classList.toggle('active', content.id === `tab-${os}`);
  });
}

function copyLinuxCommand() {
  const cmd = "curl -fsSL https://raw.githubusercontent.com/scesho/BibleTime-AI-Scholar-Suite/installer/install_linux.sh | bash";
  navigator.clipboard.writeText(cmd).then(() => {
    const btn = document.getElementById('copy-btn');
    if (btn) {
      btn.textContent = I18N[currentLang].copied_btn || 'Copiato!';
      setTimeout(() => {
        btn.textContent = I18N[currentLang].copy_btn || 'Copia';
      }, 2000);
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  // Init language
  const saved = localStorage.getItem('bibletime_site_lang') || navigator.language.slice(0, 2);
  const initial = ['it', 'en', 'es'].includes(saved) ? saved : 'it';
  setLanguage(initial);

  // Init OS tab
  const os = detectOS();
  selectDownloadTab(os);

  // Lang buttons
  document.querySelectorAll('.lang-btn').forEach(btn => {
    btn.addEventListener('click', () => setLanguage(btn.dataset.lang));
  });

  // Tab buttons
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => selectDownloadTab(btn.dataset.os));
  });

  // Copy button
  const copyBtn = document.getElementById('copy-btn');
  if (copyBtn) {
    copyBtn.addEventListener('click', copyLinuxCommand);
  }
});


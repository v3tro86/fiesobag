local ADDON = ...
local VERSION = "1.3.3"
local PREFIX = "|cff33ccffFiesoBag|r: "

local format, lower, find = string.format, string.lower, string.find
local floor, ceil, sqrt, max = math.floor, math.ceil, math.sqrt, math.max
local C = C_Container

------------------------------------------------------------------------
-- Texte
------------------------------------------------------------------------
local GERMAN = GetLocale and GetLocale() == "deDE"
local L
if GERMAN then
    L = {
        view = "Ansicht",
        viewAll = "Alle Taschen",
        viewBags = "Rucksack & Taschen",
        viewSpecial = "Material & Seelensteine",
        design = "Design",
        options = "Optionen",
        optLocked = "Fenster fixieren",
        optUnlockAll = "Alle Platz-Sperren lösen",
        optBank = "Bank in FiesoBag zeigen",
        optCounts = "Gesamtzahl im Tooltip",
        optGlow = "Schimmer nach Qualität",
        glowOn = "Gegenstände ab Grün schimmern in ihrer Qualitätsfarbe.",
        glowOff = "Qualitäts-Schimmer aus.",
        ttBags = "In den Taschen",
        ttBank = "In der Bank",
        ttTotal = "Gesamt",
        ttMore = "+%d weitere",
        ttAll = "Alle Charaktere",
        optAlts = "Andere Charaktere im Tooltip",
        altsOn = "Tooltips zeigen auch deine anderen Charaktere.",
        altsOff = "Tooltips zeigen nur noch diesen Charakter.",
        charsHead = "Bekannte Charaktere:",
        charsNone = "Noch kein Charakter erfasst.",
        charsItems = "Taschen: %d Gegenstände",
        charsBankItems = "Bank: %d Gegenstände",
        charsNoBank = "Bank noch nicht besucht",
        srcAccount = "Gespeichert wird kontoweit – die Kontodatei wurde gelesen.",
        srcChar = "Die kontoweite Datei kam nicht zurück; geladen wurde nur die Datei dieses Charakters. Andere Charaktere sind so nicht sichtbar.",
        srcNew = "Noch keine gespeicherten Daten gefunden (erster Start oder Datei nicht gelesen).",
        charsHere = "dieser Charakter",
        forgot = "%s vergessen.",
        whereUsage = "Was soll ich suchen? Beispiel: /fb wo stoff",
        whereNone = "Nichts mit „%s“ im gemerkten Bestand. /fb chars zeigt, was erfasst ist.",
        whereBags = "Taschen",
        whereBank = "Bank",
        whereMore = "… und %d weitere Gegenstände. Suche enger fassen.",
        ttError = "Fehler in der Tooltip-Zeile (bitte melden): ",
        forgetNone = "Kein Charakter namens „%s“ gefunden. /fb chars zeigt die Liste.",
        forgetSelf = "Der aktuelle Charakter lässt sich nicht vergessen.",
        countsOn = "Tooltips zeigen die Gesamtzahl.",
        countsOff = "Tooltips zeigen keine Gesamtzahl mehr.",
        bank = "Bank",
        emptyBank = "Kein Bankplatz gefunden. Über das Plus oben das Blizzard-Bankfenster einblenden.",
        blizzBank = "Blizzard-Bankfenster",
        blizzBankTip = "Blendet das Original ein oder aus. Dort kaufst du weitere Bankplätze und legst Banktaschen ein.",
        bankOn = "Die Bank wird in FiesoBag gezeigt.",
        bankOff = "Die Bank bleibt beim Blizzard-Fenster.",
        lockHint = "Alt+Rechtsklick sperrt einen Platz",
        search = "Suche",
        empty = "Keine Tasche in dieser Ansicht.",
        sort = "Sortieren",
        sortTip = "Typ > Qualität > Name. Stapel werden zusammengelegt, freie Plätze wandern ans Ende.",
        sortTipLock = "Gesperrte Plätze bleiben, wie sie sind (Alt+Rechtsklick auf einen Platz).",
        sortTipStop = "Nochmal klicken bricht ab.",
        sortAborted = "Sortieren abgebrochen: %s",
        sortCursor = "Gegenstand oder Zauber am Mauszeiger.",
        sortStuck = "ein Platz bleibt blockiert.",
        sortLoop = "zu viele Schritte.",
        sortStopped = "Sortieren abgebrochen.",
        noTemplate = "Die Taschenknöpfe des Clients fehlen (ContainerFrameItemButtonTemplate). FiesoBag kann so nichts anzeigen.",
        locked = "Fenster fixiert.",
        unlocked = "Fenster frei – an der Kopfzeile ziehen zum Verschieben.",
        unlockedAll = "%d Platz-Sperren gelöst.",
        reset = "Einstellungen zurückgesetzt (Platz-Sperren bleiben).",
        viewSet = "Ansicht: %s",
        theme = "Design: %s",
        scale = "Skalierung: %.2f",
        badNumber = "Ungültiger Wert. Erlaubt: %s",
        badTheme = "Unbekanntes Design. Verfügbar: modern, glas, klassisch",
        help = {
            "Befehle (/fb oder /fiesobag):",
            "  (ohne Zusatz) – Tasche öffnen / schliessen",
            "  menu – Einstellungen (auch über den Knopf oben rechts)",
            "  sort – Taschen sortieren (Typ > Qualität > Name) · sort bank – Bank sortieren",
            "  alle / taschen / material – Ansicht wählen",
            "  theme [modern|glas|klassisch] – Design wechseln",
            "  lock / unlock – Fenster fixieren / verschiebbar machen",
            "  entsperren – alle Platz-Sperren lösen",
            "  bank – Bank in FiesoBag zeigen an/aus",
            "  anzahl – Gesamtzahl im Tooltip an/aus · twinks – andere Charaktere an/aus",
            "  schimmer – Schimmer in Qualitätsfarbe an/aus",
            "  chars – erfasste Charaktere zeigen · vergessen <Name> – einen entfernen",
            "  wo <Text> – zeigt, welcher Charakter passende Gegenstände hat (Taschen und Bank)",
            "  scale <0.5-2> – Grösse",
            "  reset – Einstellungen zurücksetzen",
            "Alt+Rechtsklick auf einen Platz sperrt ihn für das Sortieren.",
        },
    }
else
    L = {
        view = "View",
        viewAll = "All bags",
        viewBags = "Backpack & bags",
        viewSpecial = "Materials & soul shards",
        design = "Theme",
        options = "Options",
        optLocked = "Lock window",
        optUnlockAll = "Clear all slot locks",
        optBank = "Show the bank in FiesoBag",
        optCounts = "Total count in tooltip",
        optGlow = "Quality shimmer",
        glowOn = "Items of green quality and above shimmer in their quality color.",
        glowOff = "Quality shimmer off.",
        ttBags = "In bags",
        ttBank = "In bank",
        ttTotal = "Total",
        ttMore = "+%d more",
        ttAll = "All characters",
        optAlts = "Other characters in tooltip",
        altsOn = "Tooltips also show your other characters.",
        altsOff = "Tooltips only show this character.",
        charsHead = "Known characters:",
        charsNone = "No character recorded yet.",
        charsItems = "bags: %d items",
        charsBankItems = "bank: %d items",
        charsNoBank = "bank not visited yet",
        srcAccount = "Data is stored account-wide – the account file was read.",
        srcChar = "The account-wide file did not come back; only this character's file was loaded. Other characters are not visible this way.",
        srcNew = "No saved data found yet (first start or file not read).",
        charsHere = "this character",
        forgot = "Forgot %s.",
        whereUsage = "What should I look for? Example: /fb where cloth",
        whereNone = "Nothing matching \"%s\" in the recorded stock. /fb chars shows what is recorded.",
        whereBags = "bags",
        whereBank = "bank",
        whereMore = "… and %d more items. Narrow the search.",
        ttError = "Error in the tooltip line (please report): ",
        forgetNone = "No character named \"%s\" found. /fb chars shows the list.",
        forgetSelf = "The current character cannot be forgotten.",
        countsOn = "Tooltips show the total count.",
        countsOff = "Tooltips no longer show the total count.",
        bank = "Bank",
        emptyBank = "No bank slot found. Use the plus at the top to show Blizzard's bank window.",
        blizzBank = "Blizzard bank window",
        blizzBankTip = "Shows or hides the original. That is where you buy more bank slots and equip bank bags.",
        bankOn = "The bank is shown in FiesoBag.",
        bankOff = "The bank stays with Blizzard's window.",
        lockHint = "Alt+right-click locks a slot",
        search = "Search",
        empty = "No bag in this view.",
        sort = "Sort",
        sortTip = "Type > quality > name. Stacks are merged, free slots move to the end.",
        sortTipLock = "Locked slots stay as they are (Alt+right-click a slot).",
        sortTipStop = "Click again to cancel.",
        sortAborted = "Sorting cancelled: %s",
        sortCursor = "item or spell on the cursor.",
        sortStuck = "a slot stays blocked.",
        sortLoop = "too many steps.",
        sortStopped = "Sorting cancelled.",
        noTemplate = "The client's bag buttons are missing (ContainerFrameItemButtonTemplate). FiesoBag cannot show anything.",
        locked = "Window locked.",
        unlocked = "Window unlocked – drag the title bar to move.",
        unlockedAll = "%d slot locks cleared.",
        reset = "Settings reset (slot locks are kept).",
        viewSet = "View: %s",
        theme = "Theme: %s",
        scale = "Scale: %.2f",
        badNumber = "Invalid value. Allowed: %s",
        badTheme = "Unknown theme. Available: modern, glass, classic",
        help = {
            "Commands (/fb or /fiesobag):",
            "  (no argument) – open / close the bag",
            "  menu – settings (also the button top right)",
            "  sort – sort the bags (type > quality > name) · sort bank – sort the bank",
            "  all / bags / special – choose view",
            "  theme [modern|glass|classic] – switch theme",
            "  lock / unlock – lock the window or make it movable",
            "  unlockall – clear all slot locks",
            "  bank – show the bank in FiesoBag on/off",
            "  counts – total count in tooltip on/off · alts – other characters on/off",
            "  glow – shimmer in quality color on/off",
            "  chars – list recorded characters · forget <name> – remove one",
            "  where <text> – shows which character has matching items (bags and bank)",
            "  scale <0.5-2> – size",
            "  reset – reset settings",
            "Alt+right-click a slot to keep it out of sorting.",
        },
    }
end

-- string.lower kennt nur ASCII; für die Suche auch die deutschen Umlaute angleichen
local function Lower(text)
    text = lower(text)
    if find(text, "\195", 1, true) then
        text = string.gsub(text, "Ä", "ä")
        text = string.gsub(text, "Ö", "ö")
        text = string.gsub(text, "Ü", "ü")
    end
    return text
end

local function Print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. msg)
    else
        print(PREFIX .. msg)
    end
end

------------------------------------------------------------------------
-- Designs (dieselben drei wie FiesoThreat)
------------------------------------------------------------------------
local FONT_CLEAN = "Fonts\\ARIALN.TTF"
local FONT_CLASSIC = "Fonts\\FRIZQT__.TTF"

-- flat = eigene, flache Plätze · sonst die Blizzard-Optik der Taschenplätze
local THEMES = {
    modern = {
        label = "Modern", flat = true, gap = 3, font = FONT_CLEAN, size = 12,
        bg = { 0.04, 0.05, 0.07, 0.92 }, border = { 0, 0, 0, 1 }, edge = { 1, 1, 1, 0.06 },
        headTop = { 0.15, 0.16, 0.20, 1 }, headBottom = { 0.07, 0.08, 0.10, 1 },
        title = { 1, 0.82, 0.30 },
        slot = { 0.11, 0.12, 0.15, 1 }, slotBorder = { 0, 0, 0, 1 },
    },
    glass = {
        label = "Glas", flat = true, gap = 3, font = FONT_CLEAN, size = 12,
        bg = { 0.02, 0.03, 0.05, 0.45 }, border = { 1, 1, 1, 0.14 }, edge = { 1, 1, 1, 0.10 },
        headTop = { 1, 1, 1, 0.12 }, headBottom = { 1, 1, 1, 0.02 },
        title = { 0.85, 0.93, 1 },
        slot = { 1, 1, 1, 0.07 }, slotBorder = { 1, 1, 1, 0.10 },
    },
    classic = {
        label = "Klassisch", flat = false, gap = 5, font = FONT_CLASSIC, size = 11,
        bg = { 0, 0, 0, 0.75 }, border = { 0.78, 0.62, 0.26, 0.95 }, edge = { 0, 0, 0, 0 },
        headTop = { 0.30, 0.22, 0.06, 0.95 }, headBottom = { 0.12, 0.08, 0.02, 0.95 },
        title = { 1, 0.82, 0 },
    },
}
local THEME_ALIAS = {
    modern = "modern", glas = "glass", glass = "glass",
    klassisch = "classic", classic = "classic", klassik = "classic",
}
local THEME_ORDER = { "modern", "glass", "classic" }

local function ThemeLabel(key)
    if not GERMAN and key == "glass" then return "Glass" end
    if not GERMAN and key == "classic" then return "Classic" end
    return THEMES[key].label
end

-- Rahmenfarbe nach Qualität (ab Selten-Grün); Grau und Weiss bleiben neutral
local QUALITY = {
    [2] = { 0.12, 1, 0, 1 }, [3] = { 0, 0.44, 0.87, 1 }, [4] = { 0.64, 0.21, 0.93, 1 },
    [5] = { 1, 0.50, 0, 1 }, [6] = { 0.90, 0.80, 0.50, 1 }, [7] = { 0, 0.80, 1, 1 },
}
-- Einfärbung der Plätze, damit Spezialtaschen und Schlüsselbund erkennbar bleiben
local KIND_TINT = {
    special = { 0.45, 0.40, 0.95 },
    keys = { 1, 0.80, 0.25 },
}
local GOLD = { 1, 0.82, 0.3 }

------------------------------------------------------------------------
-- Ansichten
------------------------------------------------------------------------
local VIEWS = {
    all = { normal = true, special = true, keys = true },
    bags = { normal = true },
    special = { special = true },
}
local VIEW_ORDER = { "all", "bags", "special" }
local VIEW_LABEL = { all = L.viewAll, bags = L.viewBags, special = L.viewSpecial }
local VIEW_ALIAS = {
    all = "all", alle = "all", alles = "all",
    bags = "bags", taschen = "bags", rucksack = "bags",
    special = "special", material = "special", seelen = "special", spezial = "special",
}
local KIND_ORDER = { "normal", "special", "keys" }

------------------------------------------------------------------------
-- Masse
------------------------------------------------------------------------
local SLOT, PAD, HEADER_H, FOOTER_H = 37, 6, 22, 22
local MIN_COLS = 4
local MENU_W, ITEM_H = 196, 18

------------------------------------------------------------------------
-- Einstellungen
------------------------------------------------------------------------
local defaults = {
    point = "BOTTOMRIGHT", relPoint = "BOTTOMRIGHT", x = -90, y = 150,
    scale = 1, theme = "modern", view = "all", locked = false,
    bank = true, counts = true, alts = true, glow = true, bpoint = "TOPLEFT", brelPoint = "TOPLEFT", bx = 40, by = -130,
}
local db = { locks = {} }
for k, v in pairs(defaults) do db[k] = v end
local charKey = "?"

local ownAtLoad      -- Charakterdatei, wie sie von der Platte kam
local loadedFrom     -- "account", "char" oder "new": woher die Daten beim Start kamen

local function LoadDB()
    -- Die Forever-Beta hat kontoweite SavedVariables zeitweise nicht wieder
    -- eingelesen. Darum zeigen Konto- und Charaktervariable auf dieselbe
    -- Tabelle; geladen wird, was vorhanden ist.
    if ownAtLoad == nil and type(FiesoBagCharDB) == "table" and FiesoBagCharDB ~= FiesoBagDB then
        ownAtLoad = FiesoBagCharDB
    end
    if not loadedFrom then
        loadedFrom = (type(FiesoBagDB) == "table" and "account")
            or (type(FiesoBagCharDB) == "table" and "char") or "new"
    end
    local saved = FiesoBagDB
    if type(saved) ~= "table" then saved = FiesoBagCharDB end
    if type(saved) ~= "table" then saved = {} end
    for k, v in pairs(defaults) do
        if type(saved[k]) ~= type(v) then saved[k] = v end
    end
    if not THEMES[saved.theme] then saved.theme = defaults.theme end
    if not VIEWS[saved.view] then saved.view = defaults.view end
    if type(saved.locks) ~= "table" then saved.locks = {} end
    if type(saved.chars) ~= "table" then saved.chars = {} end
    db = saved
    FiesoBagDB = saved
    FiesoBagCharDB = saved
end

-- Fehlt dieser Charakter in der Kontodatei (siehe oben), kommen seine Sperren
-- und sein gemerkter Bestand aus der eigenen Charakterdatei zurück.
local function RestoreOwn()
    local own = ownAtLoad
    ownAtLoad = false
    if type(own) ~= "table" or own == db then return end
    if type(own.locks) == "table" and db.locks[charKey] == nil and type(own.locks[charKey]) == "table" then
        db.locks[charKey] = own.locks[charKey]
    end
    if type(own.chars) == "table" and db.chars[charKey] == nil and type(own.chars[charKey]) == "table" then
        db.chars[charKey] = own.chars[charKey]
    end
end

local function Theme() return THEMES[db.theme] or THEMES.modern end

-- Gesperrte Plätze gelten pro Charakter: { ["Tasche:Platz"] = true }
local function Locks()
    if type(db.locks) ~= "table" then db.locks = {} end
    local l = db.locks[charKey]
    if type(l) ~= "table" then
        l = {}
        db.locks[charKey] = l
    end
    return l
end

local function LockKey(bag, slot) return bag .. ":" .. slot end

------------------------------------------------------------------------
-- Taschen lesen
------------------------------------------------------------------------
-- Der Schlüsselbund hat je nach Client eine andere Nummer (Forever: -1).
local KEYRING = KEYRING_CONTAINER
if KEYRING == nil and Enum and Enum.BagIndex then KEYRING = Enum.BagIndex.Keyring end

local function NormalBagSlots() return NUM_BAG_SLOTS or 4 end
local function HeldBagSlots() return NUM_TOTAL_EQUIPPED_BAG_SLOTS or NormalBagSlots() end

local function BagSize(bag)
    if bag == KEYRING then
        if C_ActionBar and C_ActionBar.ShouldShowKeyring and not C_ActionBar.ShouldShowKeyring() then
            return 0
        end
        if GetKeyRingSize then return tonumber(GetKeyRingSize()) or 0 end
    end
    return tonumber(C.GetContainerNumSlots(bag)) or 0
end

local function Family(bag)
    local _, family = C.GetContainerNumFreeSlots(bag)
    return (type(family) == "number") and family or 0
end

-- "normal" = Rucksack und gewöhnliche Taschen · "special" = Taschen, die nur
-- bestimmte Dinge fassen (Seelen-, Kräuter-, Verzauberertasche, Köcher ...)
local function BagKind(bag)
    if bag == KEYRING then return "keys" end
    if bag == 0 then return "normal" end
    if bag > NormalBagSlots() then return "special" end      -- eigener Materialtaschen-Platz
    if Family(bag) ~= 0 then return "special" end
    return "normal"
end

-- Getragene Taschen als Liste { bag=, size=, kind= }
local function ScanBags()
    local list = {}
    for bag = 0, HeldBagSlots() do
        local size = BagSize(bag)
        if size > 0 then list[#list + 1] = { bag = bag, size = size, kind = BagKind(bag) } end
    end
    if KEYRING ~= nil then
        local size = BagSize(KEYRING)
        if size > 0 then list[#list + 1] = { bag = KEYRING, size = size, kind = "keys" } end
    end
    return list
end

-- Die Bank von Forever besteht aus gekauften "Fächern": das erste ist das
-- Bankfach selbst, jedes weitere ein Banktaschen-Platz mit der Grösse der
-- eingelegten Tasche. Jedes Fach ist eine eigene Taschen-Nummer.
local function BankReady()
    return BankFrame ~= nil and C_Bank ~= nil and C_Bank.FetchPurchasedBankTabData ~= nil
        and Enum ~= nil and Enum.BankType ~= nil and Enum.BankType.Character ~= nil
end

local function ScanBank()
    local list = {}
    if not BankReady() then return list end
    local tabs = C_Bank.FetchPurchasedBankTabData(Enum.BankType.Character)
    if type(tabs) ~= "table" then return list end
    for i = 1, #tabs do
        local id = tabs[i] and tabs[i].ID
        if type(id) == "number" then
            local size = tonumber(C.GetContainerNumSlots(id)) or 0
            if size > 0 then
                list[#list + 1] = { bag = id, size = size, kind = (Family(id) ~= 0) and "special" or "normal" }
            end
        end
    end
    return list
end

-- Die beiden Fenster. slots = { bag=, slot=, kind= } in Anzeigereihenfolge.
-- corner: über diese Ecke wird die Lage gemerkt (von dort wächst das Fenster weg).
local bagWin = {
    scan = ScanBags, slots = {}, layoutDirty = true, dirty = true, footer = FOOTER_H,
    corner = "BOTTOMRIGHT", posKeys = { "point", "relPoint", "x", "y" },
}
local bankWin = {
    isBank = true, scan = ScanBank, slots = {}, layoutDirty = true, dirty = true, footer = 0,
    corner = "TOPLEFT", posKeys = { "bpoint", "brelPoint", "bx", "by" },
}
local windows = { bagWin, bankWin }

local function MarkDirty()
    bagWin.dirty, bankWin.dirty = true, true
end

-- Baut die Platzliste neu, wenn sich Ansicht oder Taschen geändert haben.
local function RebuildSlots(w)
    local list = w.scan()
    local parts = { w.isBank and "bank" or db.view }
    for i = 1, #list do
        local b = list[i]
        parts[#parts + 1] = b.bag .. ":" .. b.size .. ":" .. b.kind
    end
    local sig = table.concat(parts, ";")
    if sig == w.slotSig then return end
    w.slotSig = sig

    local slots = w.slots
    for i = #slots, 1, -1 do slots[i] = nil end
    local show = w.isBank and VIEWS.all or (VIEWS[db.view] or VIEWS.all)
    for k = 1, #KIND_ORDER do
        local kind = KIND_ORDER[k]
        if show[kind] then
            for i = 1, #list do
                local b = list[i]
                if b.kind == kind then
                    for s = 1, b.size do
                        slots[#slots + 1] = { bag = b.bag, slot = s, kind = kind }
                    end
                end
            end
        end
    end
    w.layoutDirty = true
end

------------------------------------------------------------------------
-- Bausteine
------------------------------------------------------------------------
-- VERTICAL: a = unten, b = oben
local function Gradient(tex, a, b)
    tex:SetColorTexture(1, 1, 1, 1)
    if CreateColor and pcall(tex.SetGradient, tex, "VERTICAL",
        CreateColor(a[1], a[2], a[3], a[4]), CreateColor(b[1], b[2], b[3], b[4])) then
        return
    end
    tex:SetColorTexture(b[1], b[2], b[3], b[4])
end

local function Font(fs, font, size)
    if GameFontHighlightSmall then fs:SetFontObject(GameFontHighlightSmall) end
    fs:SetFont(font, size, "")
    fs:SetShadowOffset(1, -1)
    fs:SetShadowColor(0, 0, 0, 0.9)
end

-- Neues Textfeld, sofort mit Schrift: der Client lehnt SetText ohne Schrift ab.
local function NewText(parent)
    local t = Theme()
    local fs = parent:CreateFontString(nil, "OVERLAY")
    Font(fs, t.font, t.size)
    return fs
end

-- Rahmen aus vier Texturen
local function MakeBorder(parent, layer, size, sub)
    local b = {}
    for i = 1, 4 do b[i] = parent:CreateTexture(nil, layer, nil, sub or 0) end
    b[1]:SetPoint("TOPLEFT");    b[1]:SetPoint("TOPRIGHT");    b[1]:SetHeight(size)
    b[2]:SetPoint("BOTTOMLEFT"); b[2]:SetPoint("BOTTOMRIGHT"); b[2]:SetHeight(size)
    b[3]:SetPoint("TOPLEFT");    b[3]:SetPoint("BOTTOMLEFT");  b[3]:SetWidth(size)
    b[4]:SetPoint("TOPRIGHT");   b[4]:SetPoint("BOTTOMRIGHT"); b[4]:SetWidth(size)
    return b
end

local function BorderColor(b, c)
    for i = 1, 4 do b[i]:SetColorTexture(c[1], c[2], c[3], c[4] or 1) end
end

local function SetShown(obj, shown)
    if shown then obj:Show() else obj:Hide() end
end

local function MoneyText(copper)
    copper = tonumber(copper) or 0
    local g, s, c = floor(copper / 10000), floor(copper / 100) % 100, copper % 100
    local out = ""
    if g > 0 then out = format("%d|cffffd100g|r ", g) end
    if g > 0 or s > 0 then out = out .. format("%d|cffc7c7cfs|r ", s) end
    return out .. format("%d|cffeda55fc|r", c)
end

------------------------------------------------------------------------
-- Blizzard-Taschenfenster parken
------------------------------------------------------------------------
local blizzFrames = {}
local parking = CreateFrame("Frame")
parking:Hide()
local manualOpen = false    -- nur, falls der Client keine Blizzard-Taschenfenster hat

local function CollectBlizzFrames()
    for i = #blizzFrames, 1, -1 do blizzFrames[i] = nil end
    if ContainerFrameCombinedBags then blizzFrames[#blizzFrames + 1] = ContainerFrameCombinedBags end
    for i = 1, 20 do
        local f = _G["ContainerFrame" .. i]
        if not f then break end
        blizzFrames[#blizzFrames + 1] = f
    end
end

-- Blizzard hängt die Fenster gelegentlich selbst um (Vollbild-Ansichten),
-- darum wird das bei jedem Bild geprüft.
local function ParkBlizzFrames()
    for i = 1, #blizzFrames do
        local f = blizzFrames[i]
        if f:GetParent() ~= parking then f:SetParent(parking) end
    end
end

local function BlizzOpen()
    for i = 1, #blizzFrames do
        if blizzFrames[i]:IsShown() then return true end
    end
    return false
end

local function BagsOpen()
    if #blizzFrames == 0 then return manualOpen end
    return BlizzOpen()
end

local function OpenBags()
    if #blizzFrames == 0 or not OpenAllBags then manualOpen = true else OpenAllBags() end
end

local function CloseBags()
    if #blizzFrames == 0 or not CloseAllBags then manualOpen = false else CloseAllBags() end
end

------------------------------------------------------------------------
-- Blizzard-Bankfenster: offen lassen, aber unsichtbar und winzig
------------------------------------------------------------------------
local showBlizzBank = false     -- über das Plus im Bankfenster eingeblendet
local bankHidden = false
local bankScale

local function BankOpen()
    return (db.bank and BankReady() and BankFrame:IsShown()) and true or false
end

local function CloseBank()
    if not BankReady() then return end
    if HideUIPanel then HideUIPanel(BankFrame) else BankFrame:Hide() end
end

-- Wird bei jedem Bild geprüft, falls Blizzard Grösse oder Deckkraft zurücksetzt.
local function UpdateBlizzBank()
    if not BankReady() then return end
    if db.bank and not showBlizzBank then
        local scale = BankFrame:GetScale()
        if scale > 0.001 then
            bankScale = scale
            BankFrame:SetScale(0.0001)
        end
        if BankFrame:GetAlpha() ~= 0 then BankFrame:SetAlpha(0) end
        bankHidden = true
    elseif bankHidden then
        bankHidden = false
        BankFrame:SetAlpha(1)
        BankFrame:SetScale(bankScale or 1)
    end
end

------------------------------------------------------------------------
-- Plätze
------------------------------------------------------------------------
local menu
local ToggleMenu, RefreshMenu, StartSort, StopSort     -- weiter unten definiert
local filter = ""
local sort                     -- laufender Sortiervorgang oder nil
local bagFrames = {}           -- Tasche -> Elternframe mit der Taschen-ID
local buttons = {}             -- Tasche -> { Platz -> Knopf }
local allButtons = {}
local isSlotButton = {}        -- Knopf -> true
local templateMissing = false

local function ToggleSlotLock(bag, slot)
    local locks, key = Locks(), LockKey(bag, slot)
    if locks[key] then locks[key] = nil else locks[key] = true end
    MarkDirty()
end

local function SlotClicked(self, button)
    if button == "RightButton" and IsAltKeyDown and IsAltKeyDown() then
        ToggleSlotLock(self.fbBag, self.fbSlot)
    end
end

-- Kleines Vorhängeschloss aus Farbflächen (keine Grafikdatei nötig)
local function MakeLockIcon(b)
    local parts = {}
    local function Part(w, h, x, y, r, g, bl, a)
        local t = b:CreateTexture(nil, "OVERLAY", nil, 7)
        t:SetSize(w, h)
        t:SetPoint("TOPRIGHT", b, "TOPRIGHT", x, y)
        t:SetColorTexture(r, g, bl, a)
        t:Hide()
        parts[#parts + 1] = t
    end
    Part(11, 12, -1, -1, 0, 0, 0, 0.65)                  -- dunkler Grund
    Part(7, 5, -3, -7, GOLD[1], GOLD[2], GOLD[3], 1)     -- Schlosskörper
    Part(5, 1, -4, -3, GOLD[1], GOLD[2], GOLD[3], 1)     -- Bügel oben
    Part(1, 3, -4, -4, GOLD[1], GOLD[2], GOLD[3], 1)     -- Bügel rechts
    Part(1, 3, -8, -4, GOLD[1], GOLD[2], GOLD[3], 1)     -- Bügel links
    return parts
end

local function GetButton(w, bag, slot)
    local row = buttons[bag]
    if not row then
        row = {}
        buttons[bag] = row
    end
    local b = row[slot]
    if b then return b end
    if templateMissing then return nil end

    local parent = bagFrames[bag]
    if not parent then
        parent = CreateFrame("Frame", nil, w.frame)
        parent:SetAllPoints(w.frame)
        parent:SetID(bag)                 -- Blizzards Knopf liest die Tasche hier ab
        bagFrames[bag] = parent
    end

    local ok, created = pcall(CreateFrame, "ItemButton", "FiesoBagSlot" .. (#allButtons + 1),
        parent, "ContainerFrameItemButtonTemplate")
    if not ok or not created then
        templateMissing = true
        Print(L.noTemplate)
        return nil
    end
    b = created
    b:SetID(slot)
    b.fbBag, b.fbSlot, b.fbWin = bag, slot, w

    b.fbBg = b:CreateTexture(nil, "BACKGROUND")
    b.fbBg:SetAllPoints()
    b.fbEdge = MakeBorder(b, "OVERLAY", 1, 6)
    b.fbLock = MakeLockIcon(b)
    b:HookScript("OnClick", SlotClicked)

    row[slot] = b
    allButtons[#allButtons + 1] = b
    isSlotButton[b] = true
    return b
end

-- Grundoptik eines Platzes: hängt nur von Design, Taschenart und Sperre ab
local function StyleButton(b, t, kind, userLocked)
    local tint = KIND_TINT[kind]
    local normal = b.GetNormalTexture and b:GetNormalTexture()
    if t.flat then
        if normal then normal:SetAlpha(0) end
        if userLocked then
            b.fbBg:SetColorTexture(GOLD[1], GOLD[2], GOLD[3], 0.22)
        elseif tint then
            b.fbBg:SetColorTexture(tint[1], tint[2], tint[3], 0.20)
        else
            b.fbBg:SetColorTexture(t.slot[1], t.slot[2], t.slot[3], t.slot[4])
        end
        b.fbBg:Show()
        for i = 1, 4 do b.fbEdge[i]:Show() end
    else
        if normal then
            normal:SetAlpha(1)
            if tint then
                normal:SetVertexColor(0.55 + 0.45 * tint[1], 0.55 + 0.45 * tint[2], 0.55 + 0.45 * tint[3])
            else
                normal:SetVertexColor(1, 1, 1)
            end
        end
        b.fbBg:Hide()
        for i = 1, 4 do b.fbEdge[i]:Hide() end
    end
    for i = 1, #b.fbLock do SetShown(b.fbLock[i], userLocked) end
end

-- Zusätze aus Blizzards eigenem Knopf (Quest-Rahmen, Neu-Leuchten, Münze beim
-- Händler, Abklingzeit, Tooltip). Fehlt etwas davon im Client, bleibt es aus.
local function BlizzExtras(b, bag, slot, info, texture)
    local quality = info and info.quality
    if b.UpdateQuestItem and C.GetContainerItemQuestInfo then
        local q = C.GetContainerItemQuestInfo(bag, slot)
        b:UpdateQuestItem(q and q.isQuestItem, q and q.questID, q and q.isActive)
    end
    if b.UpdateNewItem then b:UpdateNewItem(quality) end
    if b.UpdateJunkItem then b:UpdateJunkItem(quality, info and info.hasNoValue) end
    if b.SetReadable then b:SetReadable(info and info.isReadable) end
    if b.UpdateItemContextMatching then b:UpdateItemContextMatching() end
    if b.UpdateCooldown then b:UpdateCooldown(texture) end
    if b.CheckUpdateTooltip and GameTooltip then b:CheckUpdateTooltip(GameTooltip:GetOwner()) end
end

-- Schimmernder Innenrand in Qualitätsfarbe (ab Grün): vier Verläufe, die vom
-- Rand nach innen auslaufen. Sie liegen über dem Symbol, aber unter Stapelzahl,
-- Qualitätsrahmen und dem Abdunkeln der Suche. Das Schimmern selbst macht der
-- Taktgeber weiter unten über die Deckkraft.
local GLOW_W, GLOW_A = 8, 0.60

local function MakeGlow(b)
    local g = {}
    for i = 1, 4 do
        local tex = b:CreateTexture(nil, "ARTWORK", nil, 1)
        tex:SetBlendMode("ADD")
        tex:Hide()
        g[i] = tex
    end
    -- 1 px Abstand, damit der Verlauf innerhalb des Qualitätsrahmens bleibt
    g[1]:SetPoint("TOPLEFT", 1, -1);     g[1]:SetPoint("TOPRIGHT", -1, -1);       g[1]:SetHeight(GLOW_W)   -- oben
    g[2]:SetPoint("BOTTOMLEFT", 1, 1);   g[2]:SetPoint("BOTTOMRIGHT", -1, 1);     g[2]:SetHeight(GLOW_W)   -- unten
    g[3]:SetPoint("TOPLEFT", 1, -1);     g[3]:SetPoint("BOTTOMLEFT", 1, 1);       g[3]:SetWidth(GLOW_W)    -- links
    g[4]:SetPoint("TOPRIGHT", -1, -1);   g[4]:SetPoint("BOTTOMRIGHT", -1, 1);     g[4]:SetWidth(GLOW_W)    -- rechts
    return g
end

-- from = unten bzw. links, to = oben bzw. rechts
local function GlowGradient(tex, dir, r, g, b, fromA, toA)
    tex:SetColorTexture(1, 1, 1, 1)
    if CreateColor and pcall(tex.SetGradient, tex, dir, CreateColor(r, g, b, fromA), CreateColor(r, g, b, toA)) then
        return
    end
    tex:SetColorTexture(r, g, b, GLOW_A * 0.4)      -- ohne Verläufe: gleichmässiger Schein
end

local function PaintGlow(glow, c)
    local r, g, b = c[1], c[2], c[3]
    GlowGradient(glow[1], "VERTICAL", r, g, b, 0, GLOW_A)
    GlowGradient(glow[2], "VERTICAL", r, g, b, GLOW_A, 0)
    GlowGradient(glow[3], "HORIZONTAL", r, g, b, GLOW_A, 0)
    GlowGradient(glow[4], "HORIZONTAL", r, g, b, 0, GLOW_A)
end

-- Schaltet den Schimmer eines Platzes passend zur Qualität (nil = aus)
local function SetGlow(b, quality)
    local c = db.glow and quality and quality >= 2 and QUALITY[quality]
    if not c then
        if b.fbGlow and b.fbGlowQ then
            b.fbGlowQ = nil
            for i = 1, 4 do b.fbGlow[i]:Hide() end
        end
        return false
    end
    if not b.fbGlow then b.fbGlow = MakeGlow(b) end
    if b.fbGlowQ ~= quality then
        b.fbGlowQ = quality
        PaintGlow(b.fbGlow, c)
        for i = 1, 4 do b.fbGlow[i]:Show() end
    end
    return true
end

-- Füllt einen Platz; gibt true zurück, wenn er leer ist.
local function UpdateButton(b, e, t, userLocked)
    local info = C.GetContainerItemInfo(e.bag, e.slot)
    local texture = info and info.iconFileID
    local quality = info and info.quality
    local icon = b.icon

    local style = db.theme .. e.kind .. (userLocked and "L" or "")
    if b.fbStyle ~= style then
        b.fbStyle = style
        StyleButton(b, t, e.kind, userLocked)
    end

    if t.flat then
        icon:SetTexture(texture)
        if texture then
            icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)   -- Symbolrand abschneiden
            icon:Show()
        else
            icon:Hide()
        end
        if b.IconBorder then b.IconBorder:Hide() end
        BorderColor(b.fbEdge, (quality and QUALITY[quality]) or t.slotBorder)
    else
        if SetItemButtonTexture then
            SetItemButtonTexture(b, texture)           -- leer: Blizzards Platz-Hintergrund
        else
            icon:SetTexture(texture)
            SetShown(icon, texture ~= nil)
        end
        if texture then icon:SetTexCoord(0, 1, 0, 1) end
        if SetItemButtonQuality then
            SetItemButtonQuality(b, quality, info and info.hyperlink, false, info and info.isBound)
        end
    end

    if SetItemButtonCount then SetItemButtonCount(b, info and info.stackCount) end
    icon:SetDesaturated((info and info.isLocked) and true or false)

    if b.searchOverlay then
        local hide = false
        if filter ~= "" then
            local name = info and (info.itemName or (info.hyperlink and string.match(info.hyperlink, "%[(.-)%]")))
            hide = not (name and find(Lower(name), filter, 1, true))
        end
        SetShown(b.searchOverlay, hide)
    end

    b.fbGlowOn = SetGlow(b, texture and quality)

    pcall(BlizzExtras, b, e.bag, e.slot, info, texture)
    return texture == nil
end

------------------------------------------------------------------------
-- Fenster
------------------------------------------------------------------------
local syncing = false

local function Layout(w)
    w.layoutDirty = false
    local f, t, slots = w.frame, Theme(), w.slots
    local n = #slots
    -- möglichst quadratisch: Spalten = aufgerundete Wurzel der Platzzahl
    local cols = max(MIN_COLS, ceil(sqrt(n)))
    local rows = max(1, ceil(n / cols))
    local pitch = SLOT + t.gap
    local left, top = 1 + PAD, 1 + HEADER_H + PAD

    f:SetSize(left * 2 + cols * pitch - t.gap, top + rows * pitch - t.gap + PAD + w.footer + 1)

    for i = 1, #allButtons do
        if allButtons[i].fbWin == w then allButtons[i].fbUsed = false end
    end
    for i = 1, n do
        local e = slots[i]
        local b = GetButton(w, e.bag, e.slot)
        e.button = b
        if b then
            local col, row = (i - 1) % cols, floor((i - 1) / cols)
            b.fbUsed = true
            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", f, "TOPLEFT", left + col * pitch, -(top + row * pitch))
            b:Show()
        end
    end
    for i = 1, #allButtons do
        local b = allButtons[i]
        if b.fbWin == w and not b.fbUsed then b:Hide() end
    end
    SetShown(f.empty, n == 0)
end

local function Refresh(w)
    w.dirty = false
    RebuildSlots(w)
    if w.layoutDirty then Layout(w) end

    local f, slots = w.frame, w.slots
    local t, locks, free = Theme(), Locks(), 0
    local glowing = w.glowing or {}
    w.glowing = glowing
    for i = #glowing, 1, -1 do glowing[i] = nil end
    for i = 1, #slots do
        local e = slots[i]
        local b = e.button
        if b then
            if UpdateButton(b, e, t, locks[LockKey(e.bag, e.slot)] and true or false) then
                free = free + 1
            end
            if b.fbGlowOn then
                b.fbGlowPhase = i * 0.55        -- versetzt: der Schimmer läuft als Welle durchs Raster
                glowing[#glowing + 1] = b
            end
        end
    end

    -- belegt / gesamt; rot, wenn voll
    local n = #slots
    local color = "b0b0b0"
    if n > 0 and free == 0 then color = "ff3030" elseif n > 0 and free <= 3 then color = "ffd100" end
    f.count:SetText(format("|cff%s%d/%d|r", color, n - free, n))
    if w.isBank then
        f.title:SetText(L.bank)
    else
        f.money:SetText(MoneyText(GetMoney and GetMoney() or 0))
        f.title:SetText(VIEW_LABEL[db.view] or "FiesoBag")
    end
end

local function PaintLines(button, active)
    for i = 1, #button.lines do
        if active then
            button.lines[i]:SetColorTexture(GOLD[1], GOLD[2], GOLD[3], 1)
        else
            button.lines[i]:SetColorTexture(1, 1, 1, 1)
        end
    end
end

-- Sortier-Knopf golden, solange dieses Fenster sortiert wird; Plus golden,
-- solange das Blizzard-Bankfenster eingeblendet ist
local function PaintHeadButtons()
    for i = 1, #windows do
        local w = windows[i]
        if w.frame then PaintLines(w.frame.sortButton, sort ~= nil and sort.win == w) end
    end
    if bankWin.frame then PaintLines(bankWin.frame.blizzButton, showBlizzBank) end
end

local function ApplyLayout()
    local t = Theme()
    for i = 1, #windows do
        local w = windows[i]
        local f = w.frame
        if f then
            local k = w.posKeys
            f:SetScale(db.scale)
            f:ClearAllPoints()
            f:SetPoint(db[k[1]], UIParent, db[k[2]], db[k[3]], db[k[4]])

            f.bg:SetColorTexture(t.bg[1], t.bg[2], t.bg[3], t.bg[4])
            BorderColor(f.border, t.border)
            f.edge:SetColorTexture(t.edge[1], t.edge[2], t.edge[3], t.edge[4])
            Gradient(f.head, t.headBottom, t.headTop)
            Font(f.title, t.font, t.size + 1)
            f.title:SetTextColor(t.title[1], t.title[2], t.title[3])
            Font(f.count, t.font, t.size)
            Font(f.empty, t.font, t.size)
            f.empty:SetTextColor(0.6, 0.6, 0.6)
            if f.search then
                f.footLine:SetColorTexture(1, 1, 1, 0.06)
                Font(f.money, t.font, t.size)
                Font(f.searchHint, t.font, t.size)
                f.searchHint:SetTextColor(0.5, 0.5, 0.5)
                f.search:SetFont(t.font, t.size, "")
                f.search:SetTextColor(1, 1, 1)
            end
            w.layoutDirty = true      -- der Platzabstand hängt vom Design ab
        end
    end
    PaintHeadButtons()
    MarkDirty()
end

-- Merkt die Lage über eine feste Ecke. Taschen: unten rechts (das Fenster
-- wächst nach oben links, wie eine gewöhnliche Tasche). Bank: oben links.
local function SaveGeometry(w)
    local f, k = w.frame, w.posKeys
    local a, b, ua, ub
    if w.corner == "BOTTOMRIGHT" then
        a, b, ua, ub = f:GetRight(), f:GetBottom(), UIParent:GetRight(), UIParent:GetBottom()
    else
        a, b, ua, ub = f:GetLeft(), f:GetTop(), UIParent:GetLeft(), UIParent:GetTop()
    end
    if a and b and ua and ub then
        local s = f:GetEffectiveScale() / UIParent:GetEffectiveScale()
        db[k[1]], db[k[2]] = w.corner, w.corner
        db[k[3]] = floor(a - ua / s + 0.5)
        db[k[4]] = floor(b - ub / s + 0.5)
        f:ClearAllPoints()
        f:SetPoint(db[k[1]], UIParent, db[k[2]], db[k[3]], db[k[4]])
        return
    end
    local point, _, relPoint, x, y = f:GetPoint(1)
    if point then
        db[k[1]], db[k[2]], db[k[3]], db[k[4]] = point, relPoint or point, x or 0, y or 0
    end
end

-- Knopf in der Kopfzeile; jeder weitere reiht sich links an den vorigen.
local function HeadButton(w, onClick)
    local f = w.frame
    local b = CreateFrame("Button", nil, f)
    b:SetSize(18, 16)
    if w.headAnchor then
        b:SetPoint("RIGHT", w.headAnchor, "LEFT", -1, 0)
    else
        b:SetPoint("RIGHT", f.head, "RIGHT", -3, 0)
    end
    w.headAnchor = b
    b:SetFrameLevel(f:GetFrameLevel() + 12)
    b:SetAlpha(0.55)
    b.lines = {}
    b:SetScript("OnEnter", function(self)
        self:SetAlpha(1)
        if self.tooltip then self.tooltip(self) end
    end)
    b:SetScript("OnLeave", function(self)
        self:SetAlpha(0.55)
        if GameTooltip then GameTooltip:Hide() end
    end)
    b:SetScript("OnClick", onClick)
    return b
end

local function Stroke(b, w, h, point, x, y, rotation)
    local t = b:CreateTexture(nil, "ARTWORK")
    t:SetColorTexture(1, 1, 1, 1)
    t:SetSize(w, h)
    t:SetPoint(point, b, point, x, y)
    if rotation and t.SetRotation then t:SetRotation(rotation) end
    b.lines[#b.lines + 1] = t
end

local function SortTooltip(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:AddLine(L.sort, 1, 1, 1)
    GameTooltip:AddLine(L.sortTip, GOLD[1], GOLD[2], GOLD[3], true)
    GameTooltip:AddLine(L.sortTipLock, 0.7, 0.7, 0.7, true)
    if sort then GameTooltip:AddLine(L.sortTipStop, 0.7, 0.7, 0.7, true) end
    GameTooltip:Show()
end

local function BlizzBankTooltip(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:AddLine(L.blizzBank, 1, 1, 1)
    GameTooltip:AddLine(L.blizzBankTip, GOLD[1], GOLD[2], GOLD[3], true)
    GameTooltip:Show()
end

-- Gemeinsamer Aufbau: Rahmen, Kopfzeile, Schliessen-Knopf
local function CreateWindow(w, name, onClose)
    local f = CreateFrame("Frame", name, UIParent)
    w.frame = f
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)          -- Klicks sollen nicht in die Welt durchfallen
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        if not db.locked then self:StartMoving() end
    end)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SaveGeometry(w)
    end)

    f.bg = f:CreateTexture(nil, "BACKGROUND")
    f.bg:SetAllPoints()
    f.border = MakeBorder(f, "BORDER", 1)

    -- Kopfzeile mit Verlauf und feiner Lichtkante
    f.head = f:CreateTexture(nil, "BACKGROUND", nil, 1)
    f.head:SetPoint("TOPLEFT", 1, -1)
    f.head:SetPoint("TOPRIGHT", -1, -1)
    f.head:SetHeight(HEADER_H)

    f.edge = f:CreateTexture(nil, "BORDER", nil, 1)
    f.edge:SetPoint("TOPLEFT", 1, -1)
    f.edge:SetPoint("TOPRIGHT", -1, -1)
    f.edge:SetHeight(1)

    local close = HeadButton(w, onClose)
    Stroke(close, 12, 2, "CENTER", 0, 0, math.rad(45))
    Stroke(close, 12, 2, "CENTER", 0, 0, math.rad(-45))
    f.closeButton = close

    f.empty = NewText(f)
    f.empty:SetPoint("LEFT", PAD + 1, 0)
    f.empty:SetPoint("RIGHT", -PAD - 1, 0)
    f.empty:SetJustifyH("CENTER")
    f.empty:SetText(w.isBank and L.emptyBank or L.empty)
    f.empty:Hide()
    return f
end

-- Sortier-Knopf, Zähler und Titel: kommen nach den fensterspezifischen Knöpfen
local function FinishHeader(w)
    local f = w.frame
    local sb = HeadButton(w, function()
        if sort then StopSort(L.sortStopped, true) else StartSort(w) end
    end)
    Stroke(sb, 12, 2, "LEFT", 3, 4)        -- absteigende Striche = sortieren
    Stroke(sb, 8, 2, "LEFT", 3, 0)
    Stroke(sb, 4, 2, "LEFT", 3, -4)
    sb.tooltip = SortTooltip
    f.sortButton = sb

    f.count = NewText(f)
    f.count:SetPoint("RIGHT", sb, "LEFT", -4, 0)
    f.count:SetJustifyH("RIGHT")

    f.title = NewText(f)
    f.title:SetPoint("LEFT", f.head, "LEFT", 7, 0)
    f.title:SetPoint("RIGHT", f.count, "LEFT", -6, 0)
    f.title:SetJustifyH("LEFT")
    f.title:SetWordWrap(false)
end

local function CreateBagWindow()
    -- Kopfzeile von rechts: Schliessen, Einstellungen (drei Striche), Sortieren
    local f = CreateWindow(bagWin, "FiesoBagFrame", function() CloseBags() end)
    local mb = HeadButton(bagWin, function() ToggleMenu() end)
    for i = 1, 3 do Stroke(mb, 12, 2, "CENTER", 0, 4 - (i - 1) * 4) end
    f.menuButton = mb
    FinishHeader(bagWin)

    -- Fusszeile: Suche links, Geld rechts
    f.footLine = f:CreateTexture(nil, "BORDER", nil, 1)
    f.footLine:SetPoint("BOTTOMLEFT", 1, FOOTER_H)
    f.footLine:SetPoint("BOTTOMRIGHT", -1, FOOTER_H)
    f.footLine:SetHeight(1)

    f.money = NewText(f)
    f.money:SetPoint("BOTTOMRIGHT", -PAD - 1, 6)
    f.money:SetJustifyH("RIGHT")

    -- Die Suche gilt für beide Fenster
    local search = CreateFrame("EditBox", "FiesoBagSearch", f)
    search:SetHeight(16)
    search:SetPoint("BOTTOMLEFT", PAD + 1, 3)
    search:SetPoint("BOTTOMRIGHT", f.money, "BOTTOMLEFT", -8, -3)
    search:SetAutoFocus(false)
    search:SetMaxLetters(40)
    search:SetTextInsets(4, 4, 0, 0)
    if GameFontHighlightSmall then search:SetFontObject(GameFontHighlightSmall) end
    search:SetFont(Theme().font, Theme().size, "")
    local sbg = search:CreateTexture(nil, "BACKGROUND")
    sbg:SetAllPoints()
    sbg:SetColorTexture(1, 1, 1, 0.07)
    f.searchHint = NewText(search)
    f.searchHint:SetPoint("LEFT", 4, 0)
    f.searchHint:SetText(L.search)
    local function HintShown()
        SetShown(f.searchHint, search:GetText() == "" and not search:HasFocus())
    end
    search:SetScript("OnTextChanged", function(self)
        filter = Lower(string.match(self:GetText() or "", "^%s*(.-)%s*$"))
        HintShown()
        MarkDirty()
    end)
    search:SetScript("OnEditFocusGained", HintShown)
    search:SetScript("OnEditFocusLost", HintShown)
    search:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    search:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
    end)
    f.search = search

    f:Hide()
    f:SetScript("OnShow", function()
        if PlaySound and SOUNDKIT and SOUNDKIT.IG_BACKPACK_OPEN then PlaySound(SOUNDKIT.IG_BACKPACK_OPEN) end
        bagWin.dirty = true
    end)
    f:SetScript("OnHide", function()
        if PlaySound and SOUNDKIT and SOUNDKIT.IG_BACKPACK_CLOSE then PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE) end
        if menu then menu:Hide() end
        search:SetText("")
        search:ClearFocus()
        -- Von aussen geschlossen (z. B. ESC): Blizzards Taschen mit schliessen,
        -- sonst ginge das Fenster beim nächsten Bild gleich wieder auf.
        if not syncing and BagsOpen() then CloseBags() end
    end)
    if UISpecialFrames then table.insert(UISpecialFrames, "FiesoBagFrame") end   -- ESC schliesst
end

local function CreateBankWindow()
    -- Kopfzeile von rechts: Schliessen, Blizzard-Bankfenster (Plus), Sortieren
    local f = CreateWindow(bankWin, "FiesoBagBankFrame", function() CloseBank() end)
    local bz = HeadButton(bankWin, function()
        showBlizzBank = not showBlizzBank
        UpdateBlizzBank()
        PaintHeadButtons()
    end)
    Stroke(bz, 10, 2, "CENTER", 0, 0)
    Stroke(bz, 2, 10, "CENTER", 0, 0)
    bz.tooltip = BlizzBankTooltip
    f.blizzButton = bz
    FinishHeader(bankWin)

    f:Hide()
    f:SetScript("OnShow", function() bankWin.dirty = true end)
    f:SetScript("OnHide", function()
        if sort and sort.win == bankWin then StopSort() end
        -- Von aussen geschlossen (z. B. ESC): die Bank wirklich verlassen
        if not syncing and BankOpen() then CloseBank() end
    end)
    if UISpecialFrames then table.insert(UISpecialFrames, "FiesoBagBankFrame") end   -- ESC schliesst
end

local function CreateUI()
    CreateBagWindow()
    CreateBankWindow()
    ApplyLayout()
end

------------------------------------------------------------------------
-- Sortieren
------------------------------------------------------------------------
-- Reihenfolge: Typ > Qualität (beste zuerst) > Name. Schrott (grau) ganz hinten,
-- der Ruhestein ganz vorne. Sortiert wird, was das Fenster zeigt, je Gruppe
-- für sich: Rucksack + gewöhnliche Taschen zusammen (in der Bank: Bankfach +
-- gewöhnliche Banktaschen), jede Spezialtasche und der Schlüsselbund einzeln
-- (dort passt nicht jeder Gegenstand hinein). Gesperrte Plätze nehmen nicht teil.
local HEARTHSTONE = 6948
local MAX_MOVES = 20
local CLASS_ORDER = {
    0,      -- Verbrauchbares
    2, 4,   -- Waffen, Rüstung
    6, 11,  -- Munition, Köcher
    1,      -- Taschen
    5,      -- Reagenzien
    7, 3,   -- Handwerkswaren, Edelsteine
    8, 9,   -- Verbesserungen, Rezepte
    12,     -- Questgegenstände
    13,     -- Schlüssel
    15,     -- Verschiedenes
}
local CLASS_RANK = {}
for i = 1, #CLASS_ORDER do CLASS_RANK[CLASS_ORDER[i]] = i end

local itemMeta = {}

local function Meta(id)
    local m = itemMeta[id]
    if m then return m end
    local classID, maxStack
    local instant = (C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
    if instant then
        local _, _, _, _, _, c = instant(id)
        classID = c
    end
    if C_Item and C_Item.GetItemMaxStackSizeByID then maxStack = C_Item.GetItemMaxStackSizeByID(id) end
    if not maxStack then
        local full = (C_Item and C_Item.GetItemInfo) or GetItemInfo
        if full then maxStack = select(8, full(id)) end
    end
    m = { rank = CLASS_RANK[classID] or 50, max = tonumber(maxStack) or 1 }
    if classID and maxStack then itemMeta[id] = m end   -- Unbekanntes später neu fragen
    return m
end

-- anyCount: Stapel dieses Gegenstands gelten unabhängig von der Stückzahl als gleich
local function Describe(info, anyCount)
    local id = info.itemID
    local m = Meta(id)
    local quality = info.quality or 1
    local rank = m.rank
    if id == HEARTHSTONE then rank = 0 elseif quality == 0 then rank = 90 end
    local count = info.stackCount or 1
    local link = info.hyperlink or ""
    return {
        id = id, rank = rank, quality = quality, count = count, max = m.max, link = link,
        name = info.itemName or string.match(link, "%[(.-)%]") or "",
        key = id .. ":" .. (anyCount and "*" or count) .. ":" .. link,   -- gleiche Schlüssel = austauschbar
    }
end

local function Before(a, b)
    if a.rank ~= b.rank then return a.rank < b.rank end
    if a.quality ~= b.quality then return a.quality > b.quality end
    if a.name ~= b.name then return a.name < b.name end
    if a.id ~= b.id then return a.id < b.id end
    if a.count ~= b.count then return a.count > b.count end
    return a.link < b.link
end

-- Plätze des Fensters, ohne gesperrte, nach Gruppen
local function SortGroups(w)
    RebuildSlots(w)
    local slots = w.slots
    local locks, groups, byId = Locks(), {}, {}
    for i = 1, #slots do
        local e = slots[i]
        if not locks[LockKey(e.bag, e.slot)] then
            local id = (e.kind == "special") and ("s" .. e.bag) or e.kind
            local g = byId[id]
            if not g then
                g = { id = id }
                byId[id] = g
                groups[#groups + 1] = g
            end
            g[#g + 1] = e
        end
    end
    return groups
end

-- Nimmt von "from" auf und legt auf "to" ab: tauscht oder legt Stapel zusammen.
local function Move(from, to)
    C.PickupContainerItem(from.bag, from.slot)
    C.PickupContainerItem(to.bag, to.slot)
    if GetCursorInfo and GetCursorInfo() and ClearCursor then ClearCursor() end
end

-- Ein Durchgang für eine Gruppe. Jeder Platz wird höchstens einmal angefasst,
-- danach wird auf den Server gewartet und neu geplant. Höchstens "budget" Züge;
-- gibt die Zahl der Züge zurück.
local function StepGroup(g, s, budget)
    local n, moves = #g, 0
    local cur, used = {}, {}
    for i = 1, n do
        local info = C.GetContainerItemInfo(g[i].bag, g[i].slot)
        cur[i] = (info and info.itemID) and Describe(info, s.noStack[g.id .. ":" .. info.itemID]) or false
    end

    -- 1. Angebrochene Stapel zusammenlegen (ein Zug je Gegenstand und Durchgang)
    local first = {}
    for i = 1, n do
        local it = cur[i]
        if it and it.max > 1 and it.count < it.max then
            local tag = g.id .. ":" .. it.id
            local j = first[it.id]
            if s.noStack[tag] then
                -- lässt sich nicht zusammenlegen: in Ruhe lassen
            elseif not j then
                first[it.id] = i
            elseif j > 0 and moves < budget then
                first[it.id] = -1
                -- Jeder gelungene Zug macht einen Stapel voll oder leer; deutlich mehr
                -- Versuche als Plätze heisst: der Server legt diese Stapel nicht zusammen.
                local tries = (s.tries[tag] or 0) + 1
                s.tries[tag] = tries
                if tries > 2 * n + 2 then
                    s.noStack[tag] = true
                else
                    Move(g[i], g[j])
                    s.tried[#s.tried + 1] = tag
                    used[i], used[j] = true, true
                    moves = moves + 1
                end
            end
        end
    end
    if moves > 0 then return moves end

    -- 2. In die Zielreihenfolge tauschen
    local want = {}
    for i = 1, n do
        if cur[i] then want[#want + 1] = cur[i] end
    end
    table.sort(want, Before)
    for i = 1, #want do
        local key = want[i].key
        if moves >= budget then break end
        if not used[i] and (cur[i] and cur[i].key) ~= key then
            -- einen passenden Gegenstand holen, der selbst noch falsch liegt
            for j = i + 1, n do
                if not used[j] and cur[j] and cur[j].key == key
                    and (want[j] and want[j].key) ~= key then
                    Move(g[j], g[i])
                    cur[i], cur[j] = cur[j], cur[i]
                    used[i], used[j] = true, true
                    moves = moves + 1
                    break
                end
            end
        end
    end
    return moves
end

function StopSort(reason, quiet)
    if not sort then return end
    sort = nil
    PaintHeadButtons()
    MarkDirty()
    if reason then
        if quiet then Print(reason) else Print(format(L.sortAborted, reason)) end
    end
end

function StartSort(w)
    if sort then return end
    w = w or bagWin
    if w.isBank and not BankOpen() then return end
    sort = {
        win = w,
        batches = 0, stalls = 0, lastMove = GetTime(), waiting = false, sawUpdate = false, elapsed = 1,
        noStack = {}, tries = {}, tried = {},
    }
    PaintHeadButtons()
end

local function SortStep()
    local s = sort
    if (GetCursorInfo and GetCursorInfo()) or (SpellIsTargeting and SpellIsTargeting()) then
        return StopSort(L.sortCursor)
    end

    -- Stand aller beteiligten Plätze: Fingerabdruck und "ist noch etwas unterwegs?"
    local groups = SortGroups(s.win)
    local total, busy, parts = 0, false, {}
    for gi = 1, #groups do
        local g = groups[gi]
        for i = 1, #g do
            total = total + 1
            local info = C.GetContainerItemInfo(g[i].bag, g[i].slot)
            if info and info.isLocked then busy = true end
            parts[total] = (info and info.itemID) and (info.itemID .. "x" .. (info.stackCount or 1)) or "-"
        end
    end
    local state = table.concat(parts, ",")

    -- Nach einem Durchgang warten, bis der Server geantwortet hat.
    local waited = GetTime() - s.lastMove
    if busy then
        if waited > 6 then return StopSort(L.sortStuck) end
        return
    end
    if s.waiting then
        local changed = state ~= s.state
        if not changed and not s.sawUpdate and waited < 1.5 then return end
        s.waiting = false
        if changed then
            s.stalls = 0
        else
            -- Ohne jede Wirkung: versuchte Stapel gelten als nicht zusammenlegbar.
            -- Zweimal hintereinander ohne Wirkung: der Server lehnt die Züge ab.
            for i = 1, #s.tried do s.noStack[s.tried[i]] = true end
            s.stalls = s.stalls + 1
            if s.stalls >= 2 then return StopSort(L.sortStuck) end
        end
    end
    s.tried = {}

    s.batches = s.batches + 1
    if s.batches > total * 3 + 30 then return StopSort(L.sortLoop) end

    -- Nicht alles auf einmal schicken: höchstens MAX_MOVES Züge je Durchgang
    local moves = 0
    for gi = 1, #groups do
        if moves < MAX_MOVES then moves = moves + StepGroup(groups[gi], s, MAX_MOVES - moves) end
    end
    if moves == 0 then return StopSort() end          -- fertig
    s.waiting, s.sawUpdate, s.lastMove, s.state = true, false, GetTime(), state
end

------------------------------------------------------------------------
-- Bestand merken
------------------------------------------------------------------------
-- Pro Charakter wird gemerkt, was in Taschen und Bank liegt:
--   db.chars["Name-Realm"] = { name=, realm=, class=, bags = { [itemID] = Anzahl },
--                              bank = { [itemID] = Anzahl }, bankSeen = true }
-- Die Bank lässt sich nur lesen, solange sie offen ist; ihr Stand bleibt danach
-- stehen und stimmt, weil sie sich nur an der Bank ändern kann.
-- Zählt alle Gegenstände der Liste; gibt { [itemID] = Anzahl } und die Zahl der
-- belegten Plätze zurück. Nebenbei werden die Namen gemerkt (db.names), damit
-- /fb wo auch Gegenstände findet, die dieser Charakter nie gesehen hat.
local function CountAll(list)
    local counts, used = {}, 0
    if type(db.names) ~= "table" then db.names = {} end
    for i = 1, #list do
        local bag = list[i].bag
        for slot = 1, list[i].size do
            local id = C.GetContainerItemID(bag, slot)
            if id then
                local info = C.GetContainerItemInfo(bag, slot)
                counts[id] = (counts[id] or 0) + ((info and info.stackCount) or 1)
                used = used + 1
                if info and type(info.itemName) == "string" and info.itemName ~= "" then
                    db.names[id] = info.itemName
                end
            end
        end
    end
    return counts, used
end

local function Me()
    if type(db.chars) ~= "table" then db.chars = {} end
    local me = db.chars[charKey]
    if type(me) ~= "table" then
        me = {}
        db.chars[charKey] = me
    end
    return me
end

local stockStale, stockElapsed = true, 0
local bankGone = false      -- Bank gerade geschlossen, Blizzards Fenster aber noch nicht zu
local bankShownSince        -- Zeitpunkt, seit dem Blizzards Bankfenster offen ist

-- Gemerkt wird nur, was der Client gerade wirklich liefert: fehlen die Taschen
-- (Ladebildschirm, Ausloggen) oder die Bankfächer, bleibt der alte Stand stehen.
local function SaveStock()
    stockStale, stockElapsed = false, 0
    if charKey == "?" then return end           -- vor dem Einloggen ist der Name unbekannt
    local me = Me()
    local bags = ScanBags()
    if #bags > 0 then
        local counts, used = CountAll(bags)
        -- Völlig leere Taschen gibt es praktisch nie: das heisst "noch nicht geladen".
        if used > 0 or type(me.bags) ~= "table" then me.bags = counts end
    end
    if BankReady() and BankFrame:IsShown() and not bankGone then
        local list = ScanBank()
        if #list > 0 then                       -- nichts merken, wenn die Bank (noch) keine Fächer liefert
            local counts, used = CountAll(list)
            -- Eine leere Bank erst glauben, wenn sie schon einen Moment offen ist.
            local settled = bankShownSince and GetTime() - bankShownSince >= 2
            if used > 0 or settled or type(me.bank) ~= "table" then
                me.bank = counts
                me.bankSeen = true
            end
        end
    end
end

------------------------------------------------------------------------
-- Gesamtzahl im Tooltip
------------------------------------------------------------------------
-- Unter den Tooltip eines FiesoBag-Platzes kommt, wie oft es den Gegenstand
-- gibt: in allen getragenen Taschen (unabhängig von der Ansicht), in der Bank
-- (offen: gezählt, sonst der gemerkte Stand) und bei den anderen Charakteren.
-- Der Client baut den Tooltip beim Draufzeigen laufend neu auf; der Rückruf
-- hängt die Zeilen jedes Mal wieder an.
local MAX_ALT_LINES = 6

local function CountIn(list, id)
    local total = 0
    for i = 1, #list do
        local bag = list[i].bag
        for slot = 1, list[i].size do
            if C.GetContainerItemID(bag, slot) == id then
                local info = C.GetContainerItemInfo(bag, slot)
                total = total + ((info and info.stackCount) or 1)
            end
        end
    end
    return total
end

-- Anzeigename: auf dem eigenen Realm ohne Realm
local function CharLabel(key, c)
    local name, realm = c.name, c.realm
    if type(name) ~= "string" or type(realm) ~= "string" then
        name, realm = string.match(key, "^(.-)%-(.*)$")
    end
    local myRealm = string.match(charKey, "^.-%-(.*)$")
    if name and realm == myRealm then return name end
    return key
end

local function ClassColor(c)
    local colors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
    local col = c.class and colors and colors[c.class]
    if col and col.r then return col.r, col.g, col.b end
    return 0.8, 0.8, 0.8
end

local function ByCountDesc(a, b)
    if a.n ~= b.n then return a.n > b.n end
    return a.key < b.key
end

local function AddCounts(tooltip)
    if not db.counts or tooltip ~= GameTooltip then return end
    local owner = tooltip:GetOwner()
    if not owner or not isSlotButton[owner] then return end       -- nur eigene Plätze
    local id = C.GetContainerItemID(owner.fbBag, owner.fbSlot)
    if not id then return end

    local function Row(label, n, r, g, b)
        tooltip:AddDoubleLine(label, tostring(n), r or GOLD[1], g or GOLD[2], b or GOLD[3], 1, 1, 1)
    end

    -- dieser Charakter
    local inBags = CountIn(ScanBags(), id)
    local inBank
    if BankReady() and BankFrame:IsShown() then
        inBank = CountIn(ScanBank(), id)
    elseif charKey ~= "?" then
        local me = db.chars and db.chars[charKey]
        if type(me) == "table" and me.bankSeen and type(me.bank) == "table" then inBank = me.bank[id] or 0 end
    end
    local mine = inBags + (inBank or 0)
    tooltip:AddLine(" ")
    Row(L.ttBags, inBags)
    if inBank then
        Row(L.ttBank, inBank)
        Row(L.ttTotal, mine)
    end

    -- andere Charaktere, die den Gegenstand haben
    if not db.alts or type(db.chars) ~= "table" then return end
    local others, sum = {}, 0
    for key, c in pairs(db.chars) do
        if key ~= charKey and type(c) == "table" then
            local n = ((type(c.bags) == "table" and tonumber(c.bags[id])) or 0)
                + ((type(c.bank) == "table" and tonumber(c.bank[id])) or 0)
            if n > 0 then
                others[#others + 1] = { key = key, c = c, n = n }
                sum = sum + n
            end
        end
    end
    if #others == 0 then return end
    table.sort(others, ByCountDesc)
    local rest = 0
    for i = 1, #others do
        local o = others[i]
        if i <= MAX_ALT_LINES then
            Row(CharLabel(o.key, o.c), o.n, ClassColor(o.c))
        else
            rest = rest + o.n
        end
    end
    if #others > MAX_ALT_LINES then Row(format(L.ttMore, #others - MAX_ALT_LINES), rest, 0.6, 0.6, 0.6) end
    Row(L.ttAll, mine + sum)
end

if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall
    and Enum and Enum.TooltipDataType and Enum.TooltipDataType.Item ~= nil then
    local reported = false
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip)
        -- ein Fehler hier darf keinen Tooltip stören; er wird einmal im Chat gemeldet
        local ok, err = pcall(AddCounts, tooltip)
        if not ok and not reported then
            reported = true
            Print(L.ttError .. tostring(err))
        end
    end)
end

------------------------------------------------------------------------
-- Einstellungsmenü
------------------------------------------------------------------------
local function MenuFont(fs, size)
    if GameFontHighlightSmall then fs:SetFontObject(GameFontHighlightSmall) end
    fs:SetFont(FONT_CLEAN, size, "")
    fs:SetShadowOffset(1, -1)
    fs:SetShadowColor(0, 0, 0, 0.9)
end

function RefreshMenu()
    if not menu then return end
    for i = 1, #menu.items do
        local b = menu.items[i]
        if not b.get then
            b.label:SetTextColor(0.85, 0.85, 0.85)
        elseif b.get() then
            b.mark:Show()
            b.label:SetTextColor(1, 1, 1)
        else
            b.mark:Hide()
            b.label:SetTextColor(0.7, 0.7, 0.7)
        end
    end
end

local function MenuHeading(y, text)
    local fs = menu:CreateFontString(nil, "OVERLAY")
    MenuFont(fs, 11)
    fs:SetTextColor(GOLD[1], GOLD[2], GOLD[3])
    fs:SetPoint("TOPLEFT", 12, y)
    fs:SetText(string.upper(text))
    local line = menu:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 1, 1, 0.08)
    line:SetHeight(1)
    line:SetPoint("LEFT", fs, "RIGHT", 6, 0)
    line:SetPoint("RIGHT", menu, "RIGHT", -12, 0)
    return y - 16
end

-- radio = Auswahl (kleiner Punkt) · false = Häkchen-Kästchen · get = nil: Aktion
local function MenuOption(y, id, label, radio, get, set)
    local b = CreateFrame("Button", nil, menu)
    b:SetPoint("TOPLEFT", 6, y)
    b:SetPoint("TOPRIGHT", -6, y)
    b:SetHeight(ITEM_H)

    local hl = b:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.07)

    b.label = b:CreateFontString(nil, "OVERLAY")
    MenuFont(b.label, 12)
    if get then
        b.box = b:CreateTexture(nil, "ARTWORK")
        b.box:SetSize(11, 11)
        b.box:SetPoint("LEFT", 8, 0)
        b.box:SetColorTexture(0.22, 0.24, 0.29, 1)

        b.mark = b:CreateTexture(nil, "OVERLAY")
        if radio then b.mark:SetSize(5, 5) else b.mark:SetSize(7, 7) end
        b.mark:SetPoint("CENTER", b.box)
        b.mark:SetColorTexture(GOLD[1], GOLD[2], GOLD[3], 1)
        b.label:SetPoint("LEFT", b.box, "RIGHT", 8, 0)
    else
        b.label:SetPoint("LEFT", 8, 0)
    end
    b.label:SetText(label)

    b.id, b.get = id, get
    b:SetScript("OnClick", function()
        set()
        ApplyLayout()
        RefreshMenu()
    end)
    menu.items[#menu.items + 1] = b
    return y - ITEM_H
end

local function ClearLocks()
    local locks, n = Locks(), 0
    for k in pairs(locks) do
        locks[k] = nil
        n = n + 1
    end
    MarkDirty()
    return n
end

local function CreateMenu()
    menu = CreateFrame("Frame", "FiesoBagMenu", UIParent)
    menu:SetFrameStrata("DIALOG")
    menu:SetWidth(MENU_W)
    menu:SetClampedToScreen(true)
    menu:EnableMouse(true)
    menu.items = {}

    local bg = menu:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.05, 0.06, 0.08, 0.96)
    BorderColor(MakeBorder(menu, "BORDER", 1), { 0, 0, 0, 1 })
    local edge = menu:CreateTexture(nil, "BORDER", nil, 1)
    edge:SetPoint("TOPLEFT", 1, -1)
    edge:SetPoint("TOPRIGHT", -1, -1)
    edge:SetHeight(1)
    edge:SetColorTexture(1, 1, 1, 0.08)

    local y = -10
    y = MenuHeading(y, L.view)
    for i = 1, #VIEW_ORDER do
        local key = VIEW_ORDER[i]
        y = MenuOption(y, "view:" .. key, VIEW_LABEL[key], true,
            function() return db.view == key end,
            function() db.view = key end)
    end

    y = MenuHeading(y - 8, L.design)
    for i = 1, #THEME_ORDER do
        local key = THEME_ORDER[i]
        y = MenuOption(y, "theme:" .. key, ThemeLabel(key), true,
            function() return db.theme == key end,
            function() db.theme = key end)
    end

    y = MenuHeading(y - 8, L.options)
    y = MenuOption(y, "locked", L.optLocked, false,
        function() return db.locked end, function() db.locked = not db.locked end)
    y = MenuOption(y, "bank", L.optBank, false,
        function() return db.bank end, function() db.bank = not db.bank end)
    y = MenuOption(y, "glow", L.optGlow, false,
        function() return db.glow end, function() db.glow = not db.glow end)
    y = MenuOption(y, "counts", L.optCounts, false,
        function() return db.counts end, function() db.counts = not db.counts end)
    y = MenuOption(y, "alts", L.optAlts, false,
        function() return db.alts end, function() db.alts = not db.alts end)
    y = MenuOption(y, "unlockall", L.optUnlockAll, false, nil,
        function() Print(format(L.unlockedAll, ClearLocks())) end)

    local hint = menu:CreateFontString(nil, "OVERLAY")
    MenuFont(hint, 11)
    hint:SetTextColor(0.55, 0.55, 0.55)
    hint:SetPoint("TOPLEFT", 14, y - 6)
    hint:SetText(L.lockHint)
    y = y - 20

    menu:SetHeight(-y + 8)
    menu:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "FiesoBagMenu") end  -- ESC schliesst
end

function ToggleMenu()
    local frame = bagWin.frame
    if not frame then return end
    if not menu then CreateMenu() end
    if menu:IsShown() then
        menu:Hide()
        return
    end
    menu:SetScale(db.scale)
    menu:ClearAllPoints()
    -- auf die Seite, auf der mehr Platz ist
    local center, width = frame:GetCenter(), UIParent:GetWidth()
    if center and width and center * frame:GetEffectiveScale() > width * UIParent:GetEffectiveScale() / 2 then
        menu:SetPoint("TOPRIGHT", frame, "TOPLEFT", -4, 0)
    else
        menu:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, 0)
    end
    RefreshMenu()
    menu:Show()
end

------------------------------------------------------------------------
-- Ereignisse
------------------------------------------------------------------------
local driver = CreateFrame("Frame")
local glowElapsed = 0

driver:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == ADDON then
            LoadDB()
            ApplyLayout()
        end
        return
    end
    if event == "PLAYER_LOGIN" then
        LoadDB()
        charKey = (UnitName and UnitName("player") or "?") .. "-" .. (GetRealmName and GetRealmName() or "?")
        RestoreOwn()
        local me = Me()
        me.name, me.realm = UnitName and UnitName("player"), GetRealmName and GetRealmName()
        if UnitClass then
            local _, class = UnitClass("player")
            me.class = class
        end
        CreateUI()
        CollectBlizzFrames()
        ParkBlizzFrames()
        UpdateBlizzBank()
    elseif sort and (event == "BAG_UPDATE" or event == "BAG_UPDATE_DELAYED") then
        sort.sawUpdate = true
    end
    -- Bestand merken: nach einem abgeschlossenen Schub und beim Ausloggen sofort,
    -- sonst kurz gebündelt
    if event == "BANKFRAME_CLOSED" then
        bankGone = true
    elseif event == "BANKFRAME_OPENED" then
        bankGone = false
    end
    if event == "PLAYER_LOGOUT" then
        -- nichts: beim Ausloggen liefert der Client die Taschen nicht mehr verlässlich
    elseif event == "BAG_UPDATE_DELAYED" or event == "BANK_TABS_CHANGED" or event == "PLAYERBANKSLOTS_CHANGED" then
        SaveStock()
    else
        stockStale = true
    end
    MarkDirty()
end)

-- Fenster zeigen oder verbergen, ohne dass das als Schliessen von aussen zählt
local function Sync(w, want)
    if want ~= w.frame:IsShown() then
        syncing = true
        SetShown(w.frame, want)
        syncing = false
    end
end

driver:SetScript("OnUpdate", function(_, dt)
    if not bagWin.frame then return end

    if BankReady() and BankFrame:IsShown() then
        bankShownSince = bankShownSince or GetTime()
    else
        bankShownSince, bankGone = nil, false
    end
    stockElapsed = stockElapsed + dt
    if stockStale and stockElapsed >= 0.3 then SaveStock() end

    -- Nach dem Bankbesuch ist das Blizzard-Bankfenster wieder verborgen
    if showBlizzBank and not (BankReady() and BankFrame:IsShown()) then
        showBlizzBank = false
        PaintHeadButtons()
    end

    -- FiesoBag folgt dem Zustand der Blizzard-Fenster (Taschen geparkt, Bank winzig)
    ParkBlizzFrames()
    UpdateBlizzBank()
    Sync(bagWin, BagsOpen())
    Sync(bankWin, BankOpen())

    if sort then
        sort.elapsed = sort.elapsed + dt
        if sort.elapsed >= 0.1 then
            sort.elapsed = 0
            SortStep()
        end
    end

    for i = 1, #windows do
        local w = windows[i]
        if w.dirty and w.frame:IsShown() then Refresh(w) end
    end

    -- Schimmer: Deckkraft der Innenränder sanft auf- und abschwellen lassen
    glowElapsed = glowElapsed + dt
    if glowElapsed >= 0.03 then
        glowElapsed = 0
        local now = GetTime()
        for i = 1, #windows do
            local w = windows[i]
            local glowing = w.glowing
            if glowing and w.frame:IsShown() then
                for k = 1, #glowing do
                    local b = glowing[k]
                    local alpha = 0.72 + 0.28 * math.sin(now * 2.6 - b.fbGlowPhase)
                    local glow = b.fbGlow
                    glow[1]:SetAlpha(alpha); glow[2]:SetAlpha(alpha); glow[3]:SetAlpha(alpha); glow[4]:SetAlpha(alpha)
                end
            end
        end
    end
end)

for _, event in ipairs({
    "ADDON_LOADED", "PLAYER_LOGIN", "PLAYER_ENTERING_WORLD",
    "BAG_UPDATE", "BAG_UPDATE_DELAYED", "BAG_CONTAINER_UPDATE", "BAG_NEW_ITEMS_UPDATED",
    "ITEM_LOCK_CHANGED", "BAG_UPDATE_COOLDOWN", "PLAYER_MONEY",
    "MERCHANT_SHOW", "MERCHANT_CLOSED", "QUEST_ACCEPTED", "QUEST_REMOVED",
    "BANKFRAME_OPENED", "BANKFRAME_CLOSED", "BANK_TABS_CHANGED", "PLAYERBANKSLOTS_CHANGED",
    "PLAYER_LOGOUT",
}) do
    pcall(driver.RegisterEvent, driver, event)  -- unbekannte Events nicht fatal
end

------------------------------------------------------------------------
-- Befehle
------------------------------------------------------------------------
local function Number(arg, lo, hi)
    local v = tonumber(arg)
    if v and v >= lo and v <= hi then return v end
    Print(format(L.badNumber, lo .. "–" .. hi))
end

local function Kinds(t)
    local n = 0
    if type(t) == "table" then
        for _ in pairs(t) do n = n + 1 end
    end
    return n
end

-- Zeigt, woher die Daten kamen und was je Charakter gemerkt ist
local function ListChars()
    Print("v" .. VERSION .. " – " .. ((loadedFrom == "account" and L.srcAccount) or (loadedFrom == "char" and L.srcChar) or L.srcNew))
    local keys = {}
    for key, c in pairs(db.chars) do
        if type(c) == "table" then keys[#keys + 1] = key end
    end
    if #keys == 0 then
        Print(L.charsNone)
        return
    end
    table.sort(keys)
    Print(L.charsHead)
    for i = 1, #keys do
        local key = keys[i]
        local c = db.chars[key]
        local text = "  " .. key .. " – " .. format(L.charsItems, Kinds(c.bags)) .. ", "
            .. (c.bankSeen and format(L.charsBankItems, Kinds(c.bank)) or L.charsNoBank)
        if key == charKey then text = text .. " (" .. L.charsHere .. ")" end
        Print(text)
    end
end

-- name kommt kleingeschrieben an; passt auf "Name" oder "Name-Realm"
local function ForgetChar(name)
    local found
    for key in pairs(db.chars) do
        local k = lower(key)
        if k == name or string.match(k, "^(.-)%-") == name then
            if key == charKey then
                Print(L.forgetSelf)
                return
            end
            found = found or {}
            found[#found + 1] = key
        end
    end
    if not found then
        Print(format(L.forgetNone, name))
        return
    end
    for i = 1, #found do
        db.chars[found[i]] = nil
        if type(db.locks) == "table" then db.locks[found[i]] = nil end
        Print(format(L.forgot, found[i]))
    end
end

local function ItemName(id)
    local name = type(db.names) == "table" and db.names[id]
    if name then return name end
    if C_Item and C_Item.GetItemNameByID then name = C_Item.GetItemNameByID(id) end
    if not name then
        local full = (C_Item and C_Item.GetItemInfo) or GetItemInfo
        if full then name = full(id) end
    end
    return name
end

-- Durchsucht den gemerkten Bestand aller Charaktere nach einem Namensteil
local MAX_WHERE = 12
local function Where(text)
    text = Lower(string.match(text or "", "^%s*(.-)%s*$"))
    if text == "" then
        Print(L.whereUsage)
        return
    end
    local hits, order = {}, {}
    for key, c in pairs(db.chars) do
        if type(c) == "table" then
            for f = 1, 2 do
                local stock = c.bank
                if f == 1 then stock = c.bags end
                if type(stock) == "table" then
                    for id, n in pairs(stock) do
                        local name = ItemName(id)
                        if type(name) == "string" and find(Lower(name), text, 1, true) then
                            local h = hits[id]
                            if not h then
                                h = { name = name, chars = {} }
                                hits[id] = h
                                order[#order + 1] = h
                            end
                            local e = h.chars[key]
                            if not e then
                                e = { 0, 0 }
                                h.chars[key] = e
                            end
                            e[f] = e[f] + (tonumber(n) or 0)
                        end
                    end
                end
            end
        end
    end
    if #order == 0 then
        Print(format(L.whereNone, text))
        return
    end
    table.sort(order, function(a, b) return a.name < b.name end)
    for i = 1, math.min(#order, MAX_WHERE) do
        local h = order[i]
        local keys, parts, total = {}, {}, 0
        for key in pairs(h.chars) do keys[#keys + 1] = key end
        table.sort(keys)
        for k = 1, #keys do
            local e = h.chars[keys[k]]
            total = total + e[1] + e[2]
            local where = {}
            if e[1] > 0 then where[#where + 1] = e[1] .. " " .. L.whereBags end
            if e[2] > 0 then where[#where + 1] = e[2] .. " " .. L.whereBank end
            parts[#parts + 1] = CharLabel(keys[k], db.chars[keys[k]]) .. ": " .. table.concat(where, ", ")
        end
        Print("|cffffd100" .. h.name .. "|r (" .. total .. ") – " .. table.concat(parts, " · "))
    end
    if #order > MAX_WHERE then Print(format(L.whereMore, #order - MAX_WHERE)) end
end

SLASH_FIESOBAG1 = "/fb"
SLASH_FIESOBAG2 = "/fiesobag"
SlashCmdList["FIESOBAG"] = function(msg)
    local cmd, arg = string.match(lower(msg or ""), "^%s*(%S*)%s*(.-)%s*$")
    arg = string.gsub(arg, ",", ".")

    if cmd == "" or cmd == "toggle" then
        if BagsOpen() then CloseBags() else OpenBags() end
        return
    elseif cmd == "show" or cmd == "open" then
        OpenBags()
        return
    elseif cmd == "hide" or cmd == "close" then
        CloseBags()
        return
    elseif cmd == "menu" or cmd == "config" or cmd == "optionen" or cmd == "settings" then
        if not BagsOpen() then OpenBags() end
        ToggleMenu()
        return
    elseif cmd == "sort" or cmd == "sortieren" then
        if sort then
            StopSort(L.sortStopped, true)
        else
            StartSort(arg == "bank" and bankWin or bagWin)
        end
        return
    elseif cmd == "bank" then
        db.bank = not db.bank
        Print(db.bank and L.bankOn or L.bankOff)
    elseif cmd == "alts" or cmd == "twinks" then
        db.alts = not db.alts
        Print(db.alts and L.altsOn or L.altsOff)
    elseif cmd == "chars" or cmd == "charaktere" then
        ListChars()
        return
    elseif cmd == "forget" or cmd == "vergessen" then
        ForgetChar(arg)
        return
    elseif cmd == "wo" or cmd == "where" or cmd == "find" then
        Where(string.match(msg or "", "^%s*%S+%s*(.-)%s*$"))
        return
    elseif cmd == "glow" or cmd == "schimmer" then
        db.glow = not db.glow
        Print(db.glow and L.glowOn or L.glowOff)
    elseif cmd == "counts" or cmd == "anzahl" then
        db.counts = not db.counts
        Print(db.counts and L.countsOn or L.countsOff)
    elseif VIEW_ALIAS[cmd] then
        db.view = VIEW_ALIAS[cmd]
        Print(format(L.viewSet, VIEW_LABEL[db.view]))
    elseif cmd == "lock" then
        db.locked = true; Print(L.locked)
    elseif cmd == "unlock" then
        db.locked = false; Print(L.unlocked)
    elseif cmd == "unlockall" or cmd == "entsperren" then
        Print(format(L.unlockedAll, ClearLocks()))
    elseif cmd == "theme" or cmd == "design" or cmd == "style" then
        local key
        if arg == "" then
            for i = 1, #THEME_ORDER do
                if THEME_ORDER[i] == db.theme then key = THEME_ORDER[i % #THEME_ORDER + 1] end
            end
            key = key or "modern"
        else
            key = THEME_ALIAS[arg]
        end
        if key then
            db.theme = key
            Print(format(L.theme, ThemeLabel(key)))
        else
            Print(L.badTheme)
        end
    elseif cmd == "scale" then
        local v = Number(arg, 0.5, 2)
        if v then db.scale = v; Print(format(L.scale, v)) end
    elseif cmd == "reset" then
        for k, v in pairs(defaults) do db[k] = v end
        Print(L.reset)
    else
        Print("v" .. VERSION)
        for i = 1, #L.help do Print(L.help[i]) end
        return
    end
    ApplyLayout()
    RefreshMenu()
end

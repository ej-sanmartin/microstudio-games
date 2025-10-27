// --- Config (tuning) ---
GRAVITY           = -0.35
BOUNCE            = 0.92    // energy kept after bounce
MOVE              = 2.5     // carrier movement speed
SHEET_THICK       = 6
MIN_GAP           = 50      // min distance between carriers
SHEET_MARGIN      = 40

MIN_BOUNCE_VY     = 5.0     // minimum upward speed after a bounce (keeps it lively)
HIT_K             = 0.65    // horizontal push from where you land on the sheet (-1..1 -> vx delta)
CARRIER_K         = 0.75    // horizontal push transferred from how fast you moved the sheet
SHEET_SHRINK      = 0.70    // 70% of the distance between carriers (narrower sheet)
VX_MAX            = 4.0     // clamp horizontal speed so it stays controllable
VY_MAX            = 7.0     // cap rebound if it gets too wild
TARGET_BOUNCE_VY  = 7.2     // consistent apex; adjust 6.0–7.5 to taste
EPS               = 0.1
START_UP_VY = 8.0

// --- Jumper Drift ---
AMBIENT_DRIFT_MAX  = 0.45   // peak random drift strength
AMBIENT_TICKS      = 60     // how often (frames) to change drift (~1s at 60fps)

// --- Base Vars for Reset ---
BASE_GRAVITY       = -0.35
BASE_SHEET_SHRINK  = 0.70

// --- Celebration ---
CELEB_STEP         = 5      // every 5 points (make this whatever you like)
CELEB_TIME         = 18     // frames to keep the burst visible
CELEB_COUNT        = 32     // dots per frame

// --- Polish ---
TARGET_APEX = (TARGET_BOUNCE_VY * TARGET_BOUNCE_VY) / (2 * abs(BASE_GRAVITY))

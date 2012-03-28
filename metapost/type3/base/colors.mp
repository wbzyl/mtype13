%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

if known included_colors: expandafter endinput
else: included_colors:=1.0;
fi

%% Created by CMYK2RGB script on Sat Nov  4 18:01:29 2000
%% RGB colors for Metapost.

color cyan    ; cyan    = (0,1,1) ;
color magenta ; magenta = (1,0,1) ;
color yellow  ; yellow  = (1,1,0) ;

%% color.lpro: this sets up color macros used by dvips and defines some
%%             default color parameters (if these are not already user
%%             defined by another header file).
%%
%% This was written by J. Hafner (hafner@almaden.ibm.com) and was last
%% modified on 2/14/92.  It was then rewritten by Tomas Rokicki to be
%% smaller.
%%
%% The color names used here mostly come from the Crayola Crayon box of
%% 64 colors, with some small additions and deletions.  The names match 
%% those used in the color.[sty,tex] and black.[sty,tex] files. 
%% The actual color parameters were set using a Tektronix Phaser
%% printer.  Approximate PANTONE numbers are given for most colors.
%% 
%% If any of these colors don't match the reditions given by your 
%% color device, then you can redefine them by adding another header file 
%% to predefine the colors in userdict.  In this way you can easily 
%% customize these colors to every device by adding a header entry in the
%% corresponding config.PRINTER file.
%%
%% This header file assumes that tex.pro is already loaded (e.g., B is
%% defined in that header).
%%
%%
%% This defines the currentcmykcolor and setcmykcolor in terms of rbg
%% if they are not defined in the current interpreter.
%%
%%
%% This is intended to set the color states by these defaults, only if
%% they are not defined elsewhere, particularly in another header file.
%% If defined in another header file, they must be defined in userdict to
%% take effect.
%%
%% GreenYellow  Approximate PANTONE 388
%% GreenYellow 0.15 0 0.69 0
color GreenYellow ; GreenYellow=(0.85,1.00,0.31) ;
%% Yellow  Approximate PANTONE YELLOW
%% Yellow 0 0 1 0
color Yellow ; Yellow=(1.00,1.00,0.00) ;
%% Goldenrod  Approximate PANTONE 109
%% Goldenrod 0 0.10 0.84 0
color Goldenrod ; Goldenrod=(1.00,0.90,0.16) ;
%% Dandelion  Approximate PANTONE 123
%% Dandelion 0 0.29 0.84 0
color Dandelion ; Dandelion=(1.00,0.71,0.16) ;
%% Apricot  Approximate PANTONE 1565
%% Apricot 0 0.32 0.52 0
color Apricot ; Apricot=(1.00,0.68,0.48) ;
%% Peach  Approximate PANTONE 164
%% Peach 0 0.50 0.70 0
color Peach ; Peach=(1.00,0.50,0.30) ;
%% Melon  Approximate PANTONE 177
%% Melon 0 0.46 0.50 0
color Melon ; Melon=(1.00,0.54,0.50) ;
%% YellowOrange  Approximate PANTONE 130
%% YellowOrange 0 0.42 1 0
color YellowOrange ; YellowOrange=(1.00,0.58,0.00) ;
%% Orange  Approximate PANTONE ORANGE-021
%% Orange 0 0.61 0.87 0
color Orange ; Orange=(1.00,0.39,0.13) ;
%% BurntOrange  Approximate PANTONE 388
%% BurntOrange 0 0.51 1 0
color BurntOrange ; BurntOrange=(1.00,0.49,0.00) ;
%% Bittersweet  Approximate PANTONE 167
%% Bittersweet 0 0.75 1 0.24
color Bittersweet ; Bittersweet=(0.76,0.01,0.00) ;
%% RedOrange  Approximate PANTONE 179
%% RedOrange 0 0.77 0.87 0
color RedOrange ; RedOrange=(1.00,0.23,0.13) ;
%% Mahogany  Approximate PANTONE 484
%% Mahogany 0 0.85 0.87 0.35
color Mahogany ; Mahogany=(0.65,0.00,0.00) ;
%% Maroon  Approximate PANTONE 201
%% Maroon 0 0.87 0.68 0.32
color Maroon ; Maroon=(0.68,0.00,0.00) ;
%% BrickRed  Approximate PANTONE 1805
%% BrickRed 0 0.89 0.94 0.28
color BrickRed ; BrickRed=(0.72,0.00,0.00) ;
%% Red  VERY-Approx PANTONE RED
%% Red 0 1 1 0
color Red ; Red=(1.00,0.00,0.00) ;
%% OrangeRed  No PANTONE match
%% OrangeRed 0 1 0.50 0
color OrangeRed ; OrangeRed=(1.00,0.00,0.50) ;
%% RubineRed  Approximate PANTONE RUBINE-RED
%% RubineRed 0 1 0.13 0
color RubineRed ; RubineRed=(1.00,0.00,0.87) ;
%% WildStrawberry  Approximate PANTONE 206
%% WildStrawberry 0 0.96 0.39 0
color WildStrawberry ; WildStrawberry=(1.00,0.04,0.61) ;
%% Salmon  Approximate PANTONE 183
%% Salmon 0 0.53 0.38 0
color Salmon ; Salmon=(1.00,0.47,0.62) ;
%% CarnationPink  Approximate PANTONE 218
%% CarnationPink 0 0.63 0 0
color CarnationPink ; CarnationPink=(1.00,0.37,1.00) ;
%% Magenta  Approximate PANTONE PROCESS-MAGENTA
%% Magenta 0 1 0 0
color Magenta ; Magenta=(1.00,0.00,1.00) ;
%% VioletRed  Approximate PANTONE 219
%% VioletRed 0 0.81 0 0
color VioletRed ; VioletRed=(1.00,0.19,1.00) ;
%% Rhodamine  Approximate PANTONE RHODAMINE-RED
%% Rhodamine 0 0.82 0 0
color Rhodamine ; Rhodamine=(1.00,0.18,1.00) ;
%% Mulberry  Approximate PANTONE 241
%% Mulberry 0.34 0.90 0 0.02
color Mulberry ; Mulberry=(0.64,0.08,0.98) ;
%% RedViolet  Approximate PANTONE 234
%% RedViolet 0.07 0.90 0 0.34
color RedViolet ; RedViolet=(0.59,0.00,0.66) ;
%% Fuchsia  Approximate PANTONE 248
%% Fuchsia 0.47 0.91 0 0.08
color Fuchsia ; Fuchsia=(0.45,0.01,0.92) ;
%% Lavender  Approximate PANTONE 223
%% Lavender 0 0.48 0 0
color Lavender ; Lavender=(1.00,0.52,1.00) ;
%% Thistle  Approximate PANTONE 245
%% Thistle 0.12 0.59 0 0
color Thistle ; Thistle=(0.88,0.41,1.00) ;
%% Orchid  Approximate PANTONE 252
%% Orchid 0.32 0.64 0 0
color Orchid ; Orchid=(0.68,0.36,1.00) ;
%% DarkOrchid  No PANTONE match
%% DarkOrchid 0.40 0.80 0.20 0
color DarkOrchid ; DarkOrchid=(0.60,0.20,0.80) ;
%% Purple  Approximate PANTONE PURPLE
%% Purple 0.45 0.86 0 0
color Purple ; Purple=(0.55,0.14,1.00) ;
%% Plum  VERY-Approx PANTONE 518
%% Plum 0.50 1 0 0
color Plum ; Plum=(0.50,0.00,1.00) ;
%% Violet  Approximate PANTONE VIOLET
%% Violet 0.79 0.88 0 0
color Violet ; Violet=(0.21,0.12,1.00) ;
%% RoyalPurple  Approximate PANTONE 267
%% RoyalPurple 0.75 0.90 0 0
color RoyalPurple ; RoyalPurple=(0.25,0.10,1.00) ;
%% BlueViolet  Approximate PANTONE 2755
%% BlueViolet 0.86 0.91 0 0.04
color BlueViolet ; BlueViolet=(0.10,0.05,0.96) ;
%% Periwinkle  Approximate PANTONE 2715
%% Periwinkle 0.57 0.55 0 0
color Periwinkle ; Periwinkle=(0.43,0.45,1.00) ;
%% CadetBlue  Approximate PANTONE (534+535)/2
%% CadetBlue 0.62 0.57 0.23 0
color CadetBlue ; CadetBlue=(0.38,0.43,0.77) ;
%% CornflowerBlue  Approximate PANTONE 292
%% CornflowerBlue 0.65 0.13 0 0
color CornflowerBlue ; CornflowerBlue=(0.35,0.87,1.00) ;
%% MidnightBlue  Approximate PANTONE 302
%% MidnightBlue 0.98 0.13 0 0.43
color MidnightBlue ; MidnightBlue=(0.00,0.44,0.57) ;
%% NavyBlue  Approximate PANTONE 293
%% NavyBlue 0.94 0.54 0 0
color NavyBlue ; NavyBlue=(0.06,0.46,1.00) ;
%% RoyalBlue  No PANTONE match
%% RoyalBlue 1 0.50 0 0
color RoyalBlue ; RoyalBlue=(0.00,0.50,1.00) ;
%% Blue  Approximate PANTONE BLUE-072
%% Blue 1 1 0 0
color Blue ; Blue=(0.00,0.00,1.00) ;
%% Cerulean  Approximate PANTONE 3005
%% Cerulean 0.94 0.11 0 0
color Cerulean ; Cerulean=(0.06,0.89,1.00) ;
%% Cyan  Approximate PANTONE PROCESS-CYAN
%% Cyan 1 0 0 0
color Cyan ; Cyan=(0.00,1.00,1.00) ;
%% ProcessBlue  Approximate PANTONE PROCESS-BLUE
%% ProcessBlue 0.96 0 0 0
color ProcessBlue ; ProcessBlue=(0.04,1.00,1.00) ;
%% SkyBlue  Approximate PANTONE 2985
%% SkyBlue 0.62 0 0.12 0
color SkyBlue ; SkyBlue=(0.38,1.00,0.88) ;
%% Turquoise  Approximate PANTONE (312+313)/2
%% Turquoise 0.85 0 0.20 0
color Turquoise ; Turquoise=(0.15,1.00,0.80) ;
%% TealBlue  Approximate PANTONE 3145
%% TealBlue 0.86 0 0.34 0.02
color TealBlue ; TealBlue=(0.12,0.98,0.64) ;
%% Aquamarine  Approximate PANTONE 3135
%% Aquamarine 0.82 0 0.30 0
color Aquamarine ; Aquamarine=(0.18,1.00,0.70) ;
%% BlueGreen  Approximate PANTONE 320
%% BlueGreen 0.85 0 0.33 0
color BlueGreen ; BlueGreen=(0.15,1.00,0.67) ;
%% Emerald  No PANTONE match
%% Emerald 1 0 0.50 0
color Emerald ; Emerald=(0.00,1.00,0.50) ;
%% JungleGreen  Approximate PANTONE 328
%% JungleGreen 0.99 0 0.52 0
color JungleGreen ; JungleGreen=(0.01,1.00,0.48) ;
%% SeaGreen  Approximate PANTONE 3268
%% SeaGreen 0.69 0 0.50 0
color SeaGreen ; SeaGreen=(0.31,1.00,0.50) ;
%% Green  VERY-Approx PANTONE GREEN
%% Green 1 0 1 0
color Green ; Green=(0.00,1.00,0.00) ;
%% ForestGreen  Approximate PANTONE 349
%% ForestGreen 0.91 0 0.88 0.12
color ForestGreen ; ForestGreen=(0.00,0.88,0.00) ;
%% PineGreen  Approximate PANTONE 323
%% PineGreen 0.92 0 0.59 0.25
color PineGreen ; PineGreen=(0.00,0.75,0.16) ;
%% LimeGreen  No PANTONE match
%% LimeGreen 0.50 0 1 0
color LimeGreen ; LimeGreen=(0.50,1.00,0.00) ;
%% YellowGreen  Approximate PANTONE 375
%% YellowGreen 0.44 0 0.74 0
color YellowGreen ; YellowGreen=(0.56,1.00,0.26) ;
%% SpringGreen  Approximate PANTONE 381
%% SpringGreen 0.26 0 0.76 0
color SpringGreen ; SpringGreen=(0.74,1.00,0.24) ;
%% OliveGreen  Approximate PANTONE 582
%% OliveGreen 0.64 0 0.95 0.40
color OliveGreen ; OliveGreen=(0.00,0.60,0.00) ;
%% RawSienna  Approximate PANTONE 154
%% RawSienna 0 0.72 1 0.45
color RawSienna ; RawSienna=(0.55,0.00,0.00) ;
%% Sepia  Approximate PANTONE 161
%% Sepia 0 0.83 1 0.70
color Sepia ; Sepia=(0.30,0.00,0.00) ;
%% Brown  Approximate PANTONE 1615
%% Brown 0 0.81 1 0.60
color Brown ; Brown=(0.40,0.00,0.00) ;
%% Tan  No PANTONE match
%% Tan 0.14 0.42 0.56 0
color Tan ; Tan=(0.86,0.58,0.44) ;
%% Gray  Approximate PANTONE COOL-GRAY-8
%% Gray 0 0 0 0.50
color Gray ; Gray=(0.50,0.50,0.50) ;
%% Black  Approximate PANTONE PROCESS-BLACK
%% Black 0 0 0 1
color Black ; Black=(0.00,0.00,0.00) ;
%% White  No PANTONE match
%% White 0 0 0 0
color White ; White=(1.00,1.00,1.00) ;

%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/23 09:35:44 $
%%%%

%% \input xanthi-format
%% \title{Driver file for Xanthi font}

if known included_xanthi_driver:
  expandafter endinput
else:
  included_xanthi_driver:=1;
fi

input type1; % metatype1 base macros
input xanthi-pfi; % postscript info
input xanthi-base.mp; % base format
input xanthi-param.mp; % font parameters
input xanthi-enc.mp; % font encoding
input xanthi-metric.mp; % font metric data

% Below we redefine METATYPE1 macros.
% New |beginfont| macros allows separate compilation
% of glyphs programmed in separate files.

numeric beginfont_level; beginfont_level:=1;

def beginfont_ =
 min_glyph_code=max_glyph_code=0;
 if known generating:
  if generating<>0: fontmaking:=1; fi
 else:
  if unknown show_fills_: show_fills(0); fi
  if unknown show_strokes_: show_strokes(1); fi
  if unknown show_paths_: show_paths(1); fi
  if unknown show_labels_: show_labels(1); fi
  if unknown show_boxes_: show_boxes(1); fi
  if unknown show_stems_: show_stems(1); fi
  if unknown show_stencils_: show_stencils(0); fi
 fi
 if designsize=0: designsize:=10; fi
 if unknown space: space:=333; fi
 if unknown space_stretch: space_stretch:=round(1/2space); fi
 if unknown space_shrink: space_shrink:=round(1/3space); fi
 if unknown extra_space: extra_space:=round(1/3space); fi
 if unknown quad: quad:=1000; fi
 if unknown slang:
  if known slant: % compatibility with the Old Tradition...
   slang:=angle(1, slant);
  else: slang:=0; fi
 fi
 if unknown uc_height: uc_height:=750; fi
 if unknown lc_height: lc_height:=400; fi
 if unknown math_axis: math_axis:=250; fi
 if unknown math_rule: math_rule:=40; fi
 if unknown italic_shift: italic_shift:=-100; fi
 if unknown depth: depth:=-250; fi
 if unknown ascender: ascender:=uc_height; fi
 if unknown descender: descender:=depth; fi
 if unknown adl_ascender: adl_ascender:=uc_height; fi
 if unknown adl_descender: adl_descender:=-depth; fi
 if unknown adl_lineskip: adl_lineskip:=0; fi
 if unknown top_line: top_line:=adl_ascender+1/2adl_lineskip; fi
 if unknown bot_line: bot_line:=-(adl_descender+1/2adl_lineskip); fi
 scantokens extra_beginfont;
enddef;

def endfont_ =
 scantokens extra_endfont;
 complete_pf_info;
 if fontmaking=1: write_dvips_info; fi
 complete_tfm_info;
 scantokens "end";
enddef;

def beginfont =
  beginfont_
  def beginfont_ = beginfont_level:=beginfont_level+1; enddef;
enddef;

def endfont = beginfont_level:=beginfont_level-1;
  if beginfont_level=0:
    expandafter endfont_
  fi
enddef;

endinput

%% \end

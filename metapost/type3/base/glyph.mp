%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%%% x tracingglyph tracingligtable
%%%% x glyph.topline glyph.bottomline
%%%% x glyph.get.bottomline glyph.get.topline
%%%% x glyph.set.bottomline glyph.set.topline
%%%% x glyph.width glyph.height glyph.depth
%%%% x glyph.get.width glyph.get.height glyph.get.depth
%%%% x glyph.set.width glyph.set.height glyph.set.depth
%%%% x glyph.italiccorrection
%%%% x glyph.get.italiccorrection
%%%% x glyph.set.italiccorrection
%%%% x glyph.leftsidebearing glyph.rightsidebearing
%%%% x glyph.get.leftsidebearing glyph.get.rightsidebearing
%%%% x glyph.set.leftsidebearing glyph.set.rightsidebearing
%%%% x glyph.defaultcolor
%%%% x glyph.get.defaultcolor
%%%% x glyph.set.defaultcolor
%%%% x glyph.get.encode
%%%% x glyph.set.encode


%% \title{GLYPH\_BEGIN -- A REPLACEMENT FOR BEGINPIC MACRO}

%% Forbid second and subsequent inclusions of this file.

if known glyph_version: expandafter endinput
else: glyph_version:=1.13;
  message "Loaded GLYPH macros v" & decimal glyph_version;
fi

%% Find the length of the prefix of string \\{s} for which
%% \\{cond} is true for each character \\{c} of the prefix

vardef generisize_prefix(expr s)(text cond) =
 save i_, c_; string c_;
 i_ = 0;
 forever:
  c_ := substring (i_,i_+1) of s;
  exitunless cond; exitif incr i_=length s;
 endfor
 i_
enddef;

%% Take a string returned by the $\2{str}$ operator and return
%% the same string with explicit numeric subscripts replaced
%% by generic subscript symbols $[]$.

vardef generisize(expr s) =
 save res_, s_, l_; string res_, s_;
 res_=""; % result so far
 s_ =s; % left to process
 forever: exitif s_="";
  l_:=generisize_prefix(s_, (c_<>"[") and ((c_<"0") or (c_>"9")));
  res_:=res_ & substring (0,l_) of s_;
  s_:=substring (l_,infinity) of s_;
  if s_<>"":
   res_ := res_ & "[]";
   l_ :=if s_>="[": 1+generisize_prefix(s_, c_<>"]")
    else: generisize_prefix(s_, (c_=".") or ("0"<=c_) and (c_<="9")) fi;
   s_:=substring(l_,infinity) of s_;
  fi
 endfor
 res_
enddef;

vardef glyph.prefix = "glyph" enddef;

newinternal tracingglyph; tracingglyph:=0;
newinternal tracingligtable; tracingligtable:=0;


def glyph_message = message glyph.prefix & ": " & enddef;
def glyph_errmessage = errmessage glyph.prefix ": " & enddef;

string glyph_begin_extra, glyph_end_extra;
glyph_begin_extra=""; glyph_end_extra="";

vardef glyph.makeVariable(expr middle, last) =
  glyph.prefix & "." & middle & "." & last
enddef;

def glyph_name(text name) = % name is either a suffix or a string expression
 if is_suffix(name): name else: scantokens("_" & name) fi
enddef;

vardef glyph.get@#(text name) =
  save $, $$, $$$; string $, $$, $$$;
  $$=str @#; $$$=str glyph_name(name);
  if $$="decode":
    $=glyph.prefix & "." & $$ & "[" & $$$ & "]" ;
  else:
    $=glyph.makeVariable($$,$$$);
  fi
%%%%  if unknown scantokens $: glyph_errmessage "unknown: "; fi
  scantokens $
enddef;

vardef glyph.set@#(expr value)(text names) =
   save $, $$, $$$; string $, $$, $$$;
   for name=names:
     $$$:=str glyph_name(name);
     $$:=str @#; $:=glyph.makeVariable($$,$$$);
     if unknown scantokens $: % don't redefine known values
       if tracingglyph>0:
	 glyph_message "tracing: set `" & $$$ & "' " & $$;
       fi
       if $$="defaultcolor":
	 scantokens("color " & generisize($));
       else:
	 scantokens("numeric " & generisize($));
       fi
       scantokens $=value;
     else:
       if tracingglyph>0: glyph_message "warning: do not redefined `"
	 & $$$ & "' " & $$;
       fi
     fi
   endfor
enddef;

vardef glyph.reset@#(expr value)(text names) =
   save $, $$, $$$; string $, $$, $$$;
   for name=names:
     $$$:=str glyph_name(name);
     $$:=str @#; $:=glyph.makeVariable($$,$$$);
     if tracingglyph>0:
       glyph_message "tracing: reset `" & $$$ & "' " & $$;
     fi
     if $$="defaultcolor":
       scantokens("color " & generisize($));
     else:
       scantokens("numeric " & generisize($));
     fi
     scantokens $:=value;
   endfor
enddef;

string glyph.decode[\\];

vardef encode(expr psname, pscode) = % |psname| -- string, |pscode| -- number
  if (known glyph.encode.glyph_name(psname)) or (known glyph.decode[pscode]):
    if tracingglyph>0:
      glyph_message "skipped: encode("
        & str glyph_name(psname) & ")(" & decimal pscode & ")";
      if known glyph.encode.glyph_name(psname):
        glyph_message "  known: " & str glyph_name(psname)
          & "<-" & decimal glyph.encode.glyph_name(psname);
      fi
      if known glyph.decode[pscode]:
        glyph_message "  known: " & decimal pscode 
          & "<-" & glyph.decode[pscode];
      fi
      if (glyph.encode.glyph_name(psname)<0) or
          (glyph.encode.glyph_name(psname)>255):
        glyph_errmessage "wrong code: " & decimal pscode;
      fi
    fi
  else:
    glyph.encode.glyph_name(psname)=pscode;
    glyph.decode[pscode]=str glyph_name(psname);
    if tracingglyph>1:
      glyph_message "encoded: " &
        str glyph_name(psname) & "<->" & decimal pscode;
    else:
    fi
  fi
enddef;

vardef reencode(expr psname, pscode) = % |psname| -- string, |pscode| -- number
  if (known glyph.encode.glyph_name(psname)) and (known glyph.decode[pscode]):
    glyph.encode.glyph_name(psname):=pscode;
    glyph.decode[pscode]:=str glyph_name(psname);
    if tracingglyph>1:
      glyph_message "reencoded: "
        & str glyph_name(psname) & "<->" & decimal pscode;
    fi
  fi
enddef;

def glyph_begin(text s) = begingroup \\ % |s| -- character name
  def glyph_psname = glyph_name(s) enddef; % used in |glyph_end|
  charcode:=glyph.get.encode(s);
  w:=glyph.get.width(s);
  h:=glyph.get.height(s);
  d:=glyph.get.depth(s);
  charic:=glyph.get.italiccorrection(s);
  interim xoffset:=glyph.get.leftsidebearing(s);
  clearxy; clearit; clearpen;
  picproof_:=nullpicture; % proof marks are drawn on |picproof_| sheet
  drawoptions(withcolor glyph.get.defaultcolor(s));
  scantokens glyph_begin_extra;
enddef;

def glyph_end = scantokens glyph_end_extra;
  if proofing>0: makebox(proofrule);
    currentpicture:=currentpicture scaled proofscale;
    addto currentpicture also picproof_ scaled proofscale;
  fi
  w:=glyph.get.leftsidebearing(glyph_psname)+
       w+glyph.get.rightsidebearing(glyph_psname);
  write decimal charcode & ":" & decimal w to pcw_file;
  write_tex(glyph_psname,charcode);
  charwd:=w#; charht:=h#; chardp:=d#;
  if charic<>0: charic:=charic#; fi
  shipit;
  endgroup
enddef;

color defaultcolor; defaultcolor:=black;

vardef glyph.new(expr w,h,d,i,ls,rs)(text names) =
  glyph.set.width(w,names);
  glyph.set.height(h,names);
  glyph.set.depth(d,names);
  glyph.set.italiccorrection(i,names);
  glyph.set.leftsidebearing(ls,names);
  glyph.set.rightsidebearing(rs,names);
enddef;

endinput

%% \end

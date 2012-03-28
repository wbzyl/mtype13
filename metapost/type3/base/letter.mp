%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{METAPOST MACROS FOR DRAWING LETERS}

if known included_letter: expandafter endinput
else: included_letter:=1.31;
fi

%% \section{GETTING STARTED}

%% The most important routines  in {\it cmbase\/} and in {\tt type3\/}
%% are the {\it pos\/} macro, which generalizes plain METAFONT
%% `{\it penpos}' by substracting the breadth of the currently picked
%% up pen: 

newinternal currentbreadth;
vardef pos@#(expr b,d) =
 if known b: if b<=currentbreadth: errmessage "bad pos"; fi fi
 (x@#r-x@#l,y@#r-y@#l)=(b-currentbreadth,0) rotated d;
 x@#=.5(x@#l+x@#r); y@#=.5(y@#l+y@#r) enddef;

%% In order to make {\it pos\/} work, it is necessary to maintain
%% the value of {\it currentbreadth}, by redefining part of
%% {\bf pickup} macro:

def numeric_pickup_ primary q =
 currentpen:=pen_[q];
 pen_lft:=pen_lft_[q];  pen_rt:=pen_rt_[q];
 pen_top:=pen_top_[q];  pen_bot:=pen_bot_[q];
 currentpen_path:=pen_path_[q];
 if known breadth_[q]: currentbreadth:=breadth_[q]; fi enddef;

%% The next most important feature of {\it cmbase\/} and {\it type3\/}
%% is the {\bf stroke\/} macro, which simplifies and generalizes
%% the {\bf penstroke} feature of {\it plain\/} base.

path path_;

vardef stroke text t =
 forsuffixes e = l,r: path_.e:=t; endfor
 if cycle path_.l:
  errmessage "Beware: `stroke' isn't intended for cycles"; fi
 path_.l -- reverse path_.r -- cycle enddef;

vardef lstroke text t =
 forsuffixes e=l,: path_.e:=t; endfor
 if cycle path_.l:
  errmessage "Beware: `lstroke' isn't intended for cycles"; fi
 path_.l -- reverse path_ -- cycle enddef;

vardef rstroke text t =
 forsuffixes e=r,: path_.e:=t; endfor
 if cycle path_.r:
  errmessage "Beware: `rstroke' isn't intended for cycles"; fi
 path_.r -- reverse path_ -- cycle enddef;

vardef circ_stroke text t =
 forsuffixes e=l,r: path_.e:=t; endfor
 if cycle path_.l:
  errmessage "Beware: `stroke' isn't intended for cycles"; fi
 path_.l -- reverse path_.r .. cycle
enddef;

%% This macro is taken from {\it cmbase}.

vardef diag_ratio(expr a,b,y,c) = % assuming that $a>\vert b/y\vert$,
% compute the value $\alpha=(x\6{++}y)/y$ such that $ax+b\alpha=c$
 numeric aa_,bb_,cc_; bb_=b/y; cc_=c/y; aa_=a*a-bb_*bb_;
 (a*(cc_++sqrt aa_)-bb_*cc_)/aa_ enddef;

endinput

%% \end

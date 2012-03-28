%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \font\ttt=pltt10

%% \title{MODES OF OPERATION}
%%
%% The standard way to create a Type 3 font is to start~up the
%% {\tt mptot3} script by saying  
%% \begindisplay
%%   {\ttt mptot3 }\meta{font program}
%% \enddisplay
%% It calls the {\tt mpost} with the command
%% \begindisplay
%%   {\ttt mpost -mem=type3 $\BS$mode=final; input }\meta{font program}
%% \enddisplay
%% and afterwards collects glyphs created by {\tt mpost} into
%% a Type 3 font ({\it final} is the default mode).
%% The mode name should have been predeclared in your base file, by the
%% $\2{mode\_def}$ routine below. 
%% If, however, you need special modes that aren't in the base, you can put
%% its commands into a file (e.g., `{\tt specmode.mp}') and invoke it
%% by saying
%% \begindisplay
%%   {\ttt mptot3 --change-mode=specmode,}\meta{mode name} \meta{font program}
%% \enddisplay

%% Here is the $\2{mode\_setup}$ routine, which is usually one of the first
%% macros to be called after a font program establishes the values of all font
%% parameters. The first `$\2{scantokens}$' in $\2{mode\_setup}$ either
%% reads a special file or calls a macro that expands into commands defining
%% the mode.

newinternal slant;

def mode_setup = if unknown mode: mode=final; fi
  transform currenttransform;
  if unknown aspect_ratio: aspect_ratio=1; fi
  if string mode: scantokens ("input "&mode);
    for i:=1 upto number_of_modes:
      if mode_name[i]=requested_mode_: scantokens mode_name[i]; fi
    endfor
  else: scantokens mode_name[mode];
  fi
  scantokens extra_setup; % the user's special last-minute adjustments
  currenttransform:=identity slanted slant;
  if currenttransform=identity: let t_=relax
  else: def t_ = transformed currenttransform enddef fi;
  clearit;
enddef;

def change_mode(expr file_name, mode_name) =
  string mode; mode:=file_name;
  requested_mode_:=mode_name & "_"
enddef;
string requested_mode_;

string extra_setup, mode_name[];
extra_setup=""; % usually there's nothing special to do

%% When a mode is defined (e.g., `{\tt proof}'), a numeric variable of that
%% name is created and assigned a unique number (e.g.,~1). Then an
%% underscore character is appended, and a macro is defined for the
%% resulting name (e.g., `{\tt proof\_}'). The \\{mode\_name} array is used to
%% convert between number and name (e.g., \\{mode\_name}$_1=\null${\tt proof\_}).

def mode_def suffix $ =
  $:=incr number_of_modes;
  mode_name[$]:=str$ & "_";
  expandafter quote def scantokens mode_name[$]
enddef;
newinternal number_of_modes;

%% Three basic modes are now defined, starting with two for proofing.

%% Proof mode --- for initial design of characters.

mode_def proof =
  proofing:=2;            % yes, we're making full proofs
  fontmaking:=0;          % no, we're not making a font
  tracingtitles:=1;       % yes, show titles online
enddef;

%% Smoke mode --- for label-free proofs.

mode_def smoke =
  proof_;                 % same as proof mode, except:
  proofing:=1;            % yes, we're making unlabeled proofs
  fontmaking:=0;          % no, we're not making a font
  let makebox=maketicks;  % make the boxes less obtrusive
enddef;

%% Final mode --- a typical mode for font generation
%% (note, that we get a {\TeX} font metric file if {\tt mpost} internal
%% quantity $fontmaking$ is positive at the end of our job).

mode_def final =
  proofing:=0;            % no, we're not making proofs
  fontmaking:=1;          % yes, we are making a font
  tracingtitles:=0;       % no, don't show titles at all
  prologues:=-2;          % high resolution bounding box.
enddef;

newinternal grayproofing; 

mode_def grayproof =
  proofing:=2;                 % yes, we're making full proofs
  fontmaking:=0;               % no, we're not making a font
  tracingtitles:=1;            % yes, show titles online
  grayproofing:=1;             % use gray for drawing proofs
  proofcolor:=.3[white,black];
  rulecolor:=.5[white,black];
enddef;

mode_def colorproof =
  proofing:=2;                 % yes, we're making full proofs
  fontmaking:=0;               % no, we're not making a font
  tracingtitles:=1;            % yes, show titles online
  grayproofing:=1;             % use color for drawing defined in the source
enddef;

localfont:=final;         % the mode most commonly used to make fonts

%% It is not likely that additional modes are needed, but if they are,
%% additional $\2{mode\_def}$ commands should be in another input file that
%% gets loaded after the plain base.  The auxiliary file should set
%% $\\{base\_version}:=\\{base\_version}\AM \7"/localname"$

%% \end

%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{TYPE 3 DRIVER FILE}

%% This driver file serves as chief executive for the
%% files which supports Type 3 font generation process.

%% Forbid second and subsequent inclusions of this file.

if known included_typethree: expandafter endinput
else: included_typethree:=1.31;
fi

%% The first few lines usually give the base file a name
%% and version number.

message "Preloading the type3 mem file, version "&decimal included_typethree;

%% Supporting macros are divided into several files.

input type3adm; % glyph and font administration.
input type3mop; % modes of operation
input type3pf; % support for hardcopy proofs
input type3ps; % PostScript specific items.
input type3ex; % various utility functions

endinput

%%\end

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aquila-doc}[2025/10/10 The Aquila document template V0.1]


\DeclareOption{hidelinks}{}
\ProcessOptions\relax

\LoadClass[a4paper,hidelinks]{article}

\RequirePackage[top=3cm, bottom=4cm, left=2cm, right=2cm]{geometry}
\RequirePackage{xspace}
\RequirePackage{appendix}
\RequirePackage{mathtools}
\RequirePackage{amssymb,amsthm}
\RequirePackage{amsmath}
\RequirePackage{hyperref}

%%% Setting up columns, spacing and general document stuff
\RequirePackage[skip=1em]{parskip}
\RequirePackage{paracol}
\RequirePackage{setspace}

\footnotelayout{m}

\newcommand{\aquila}{\textcolor{minty-blue}{\texttt{Aquila}}\xspace}

\renewcommand{\baselinestretch}{1.1}
\tolerance = 5000

\newcommand{\goldencolumn}[1]{%
    \columnratio{0.382}
    \begin{paracol}{2}
        \hbadness = 5000
        \columncolor{softest_black}
        \switchcolumn
        #1
    \end{paracol}
}

\newcommand{\goldencolumnbegin}{%
    \columnratio{0.382}%
    \begin{paracol}{2}%
        \hbadness=5000%
        \columncolor{softest_black}%
        \switchcolumn%
        }

        \newcommand{\goldencolumnend}{%
    \end{paracol}%
}

\newcommand{\spanalign}[1]{%
    \goldencolumnend
    \alignskip
    \refstepcounter{equation}% ensure global reference step
    \begin{align}
        #1
    \end{align}
    \goldencolumnbegin
    \vspace{-1em}
}

% For a later version: introduce spanning equations.
% \RequirePackage{environ}
% \NewEnviron{spanalign}{%
%   \goldencolumnend % temporarily leave the automatic paracol
%   \begin{align}
%     \collect@body
%   \end{align}
%   \goldencolumnbegin % re-enter the automatic paracol
% }

% Automatically start the default goldencolumn at document start
% This works, but is incompatible with appendix. Remove for now
% \AtBeginDocument{\goldencolumnbegin}
% \AtEndDocument{\par\clearpage\goldencolumnend}

\newcommand{\golden}{0.382\linewidth}
\newcommand{\togolden}{0.618\linewidth}

\newcommand{\qq}[1]{``#1''}
\newcommand{\cf}{cf.\xspace}
\newcommand{\eg}{e.g.\xspace}
\newcommand{\ie}{i.e.\xspace}
\newcommand{\shift}[1]{\hfill #1}

% This skips the space before/after an align environment
\newcommand{\alignskip}{
    \vspace{-\baselineskip}
    \vspace{-\belowdisplayshortskip}
}

% Changing footnote size
\makeatletter
\renewcommand{\@makefnmark}{\hbox{\@textsuperscript{\fontsize{5}{6}\selectfont\@thefnmark}}}
\makeatother

% Changing the page numbering when present
\RequirePackage{fancyhdr}
\pagestyle{fancy}

\fancyhf{} % clear all header and footer fields
\fancyfoot[R]{\fontsize{9}{10}\selectfont\thepage} % put smaller page number bottom right
\renewcommand{\headrulewidth}{0pt} % remove header line
\renewcommand{\footrulewidth}{0pt} % remove footer line (optional)

\fancypagestyle{plain}{%
    \fancyfoot[R]{\fontsize{9}{10}\selectfont\thepage} % put smaller page number bottom right
    \renewcommand{\headrulewidth}{0pt} % remove header line
    \renewcommand{\footrulewidth}{0pt} % remove footer line (optional)
}

% The all-important comment
\newcommand{\comment}[1]{%
    \switchcolumn*%
    #1%
    \switchcolumn%
}
\newcommand{\floatcomment}[1]{
    \switchcolumn%
    #1%
    \switchcolumn%
}

\newcommand{\spanningtext}[1]{
\switchcolumn[1]*[\color{black}#1]
}

\makeatletter
\renewcommand{\section}{%
    \@ifstar
    {\@ifundefined{switchcolumn}{\@aquilasectionstarplain}{\@aquilasectionstar}}%
    {\@ifundefined{switchcolumn}{\@aquilasectionnostarplain}{\@aquilasectionnostar}}%
}
% Starred version inside paracol (with \switchcolumn)
\newcommand{\@aquilasectionstar}[1]{%
\par
\switchcolumn[1]*[%
\vspace{2em}%
{\color{black}\large\bfseries #1}%
\par
]%
\ignorespaces
}
% Unstarred version inside paracol (with \switchcolumn)
\newcommand{\@aquilasectionnostar}[1]{%
\par
\refstepcounter{section}%
\switchcolumn[1]*[%
\@startsection{section}{1}{\z@}%
{2em}{2em}{\color{black}\large\bfseries}{#1}%
\par
]%
\ignorespaces
}
% Starred version outside paracol (no \switchcolumn)
\newcommand{\@aquilasectionstarplain}[1]{%
    \par
    \vspace{2em}%
    {\color{black}\large\bfseries #1}%
    \par
    \ignorespaces
}
% Unstarred version outside paracol (no \switchcolumn)
\newcommand{\@aquilasectionnostarplain}[1]{%
    \par
    \refstepcounter{section}%
    \@startsection{section}{1}{\z@}%
    {2em}{2em}{\color{black}\large\bfseries}{#1}%
    \par
    \ignorespaces
}
\makeatother

\makeatletter
\renewcommand{\subsection}{%
    \@ifstar
    \@aquilasubsectionstar
    \@aquilasubsectionnostar
}
\newcommand{\@aquilasubsectionstar}[1]{%
\par
\switchcolumn[1]*[%
% Unnumbered, styled section spanning columns
\vspace{1em}%
{\color{black}\bfseries #1}%
\par
]%
\ignorespaces
}
\newcommand{\@aquilasubsectionnostar}[1]{%
\par
\refstepcounter{subsection}%
\switchcolumn[1]*[%
% Numbered, styled section spanning columns
\@startsection{subsection}{1}{\z@}%
{1em}{1em}{\color{black}\bfseries}{#1}%
\par
]%
\ignorespaces
}
\makeatother

\makeatletter
\def\subsubsection{\@subsubsection}
\newcommand{\@subsubsection}[1]{
    {\bfseries #1}
    \@afterheading
}
\makeatother

\makeatletter
\renewcommand{\paragraph}{\@paragraph}
\newcommand{\@paragraph}[1]{
    {\bfseries #1}%
}
\makeatother

%%% Referencing of custom text
\makeatletter
\newcommand{\namelabel}[1]{%
    \phantomsection
    \renewcommand{\@currentlabel}{#1}% Update the label text/name
    \label{#1}% Set the label
}
\makeatother


%%% Setting up fonts and their look, including math fonts
\RequirePackage{microtype}
\RequirePackage[utf8]{inputenc}
\RequirePackage[default,defaultsans]{lato}
\RequirePackage[T1]{fontenc}
\RequirePackage{inconsolata}

\renewcommand*{\bfdefault}{m}
\renewcommand*{\seriesdefault}{l}

\RequirePackage[italic]{mathastext}

\renewcommand{\accent}[1]{\textbf{#1}}
\newcommand{\colouraccent}[2]{\textcolor{#1}{\textbf{#2}}}
\newcommand{\colourmath}[2]{\colournode{#1}{\ensuremath{#2}}{}{0.25em}}

%%% Defining the aquila colour palette
\RequirePackage{xcolor}

\definecolor{red_salsa}{HTML}{F94144}
\definecolor{orange_red}{HTML}{F3722C}
\definecolor{yellow_orange}{HTML}{F8961E}
\definecolor{mango_tango}{HTML}{F9844A}
\definecolor{maize_crayola}{HTML}{F9C74F}
\definecolor{pistachio}{HTML}{90BE6D}
\definecolor{jungle_green}{HTML}{43AA8B}
\definecolor{steel_teal}{HTML}{4D908E}
\definecolor{queen_blue}{HTML}{577590}
\definecolor{celadon_blue}{HTML}{277DA1}
\definecolor{softer_black}{HTML}{2A2A2A}

\definecolor{poinant_purple}{HTML}{A87DC1}
\definecolor{purpose_purple}{HTML}{4D5AC0}
\definecolor{bliss_brown}{HTML}{C36D3A}
\definecolor{turd_turqoise}{HTML}{44BAC3}
\definecolor{soft_white}{HTML}{F1F1F1}
\definecolor{softer_white}{HTML}{E5E5E5}
\definecolor{grey}{HTML}{A5A5A5}
\definecolor{soft_black}{HTML}{101010}
\definecolor{softer_black}{HTML}{2A2A2A}
\definecolor{softest_black}{HTML}{707070}

\definecolor{minty-blue}{cmyk}{.59,.07,.00,.00}
\definecolor{flair_purple}{HTML}{36337D}


%%% Setting up the tikz environments and styles
\RequirePackage{tikz}
\RequirePackage{circuitikz}
\usetikzlibrary{
    calc,
    shapes,
    shapes.misc,
    shapes.symbols,
    backgrounds,
    fit,
    arrows,
    arrows.meta,
    positioning,
    decorations.pathmorphing,
    patterns,
    patterns.meta,
    scopes,
}

\RequirePackage[%
    linewidth=1pt,
    middlelinecolor= black,
    middlelinewidth=0.4pt,
    roundcorner=1pt,
    topline = false,
    rightline = false,
    bottomline = false,
    rightmargin=0pt,
    skipbelow=0pt,
    leftmargin=0cm,
    innerleftmargin=0.25cm,
    innerrightmargin=0pt,
    innertopmargin=0pt,
    innerbottommargin=0pt,
]{mdframed}
\RequirePackage{pgfplots}

\tikzset{
circnode/.style={
        fill=grey, align=center,
        fill opacity=0.25, text opacity=1,
        circle,
        minimum width=2em
    },
sqnode/.style={
        % draw=softer_black, thick,
        fill=grey,
        fill opacity=0.25, text opacity=1,
        rounded corners=0.25em, align=center,
        minimum width=2.5em, minimum height=2.5em
    },
regpath/.style={
-Triangle[round], draw=softer_black, ultra thick, rounded corners=0.25em
},
thinpath/.style={
-Triangle[round], draw=softer_black, thick, rounded corners=0.25em
},
thinline/.style={
        solid, draw=softer_black, thick, rounded corners=0.25em, shorten <= 1mm, shorten >= 1mm
    },
between/.style args={#1 and #2}{
        at = ($(#1)!0.5!(#2)$)
    }
}

\tikzdeclarepattern{
    name=custom_line,
    parameters={
            \pgfkeysvalueof{/pgf/pattern keys/size},
            \pgfkeysvalueof{/pgf/pattern keys/angle},
            \pgfkeysvalueof{/pgf/pattern keys/line width},
        },
    bounding box={
            (0,-0.5*\pgfkeysvalueof{/pgf/pattern keys/line width}) and
            (\pgfkeysvalueof{/pgf/pattern keys/size},
            0.5*\pgfkeysvalueof{/pgf/pattern keys/line width})
        },
    tile size={
            (\pgfkeysvalueof{/pgf/pattern keys/size},
            \pgfkeysvalueof{/pgf/pattern keys/size})},
    tile transformation={rotate=\pgfkeysvalueof{/pgf/pattern keys/angle}},
    defaults={
            size/.initial=5pt,
            angle/.initial=90,
            line width/.initial=7pt,
            xshift/.initial=1.1*\n cm,
            distance/.initial=3pt,
        },
    code={
            \draw [line width=\pgfkeysvalueof{/pgf/pattern keys/line width}]
            (0,0) -- (\pgfkeysvalueof{/pgf/pattern keys/size},0);
        }
}


%%% Tikz magic for nodes in text and mathematics
\newcommand{\colournode}[4]{%
    \tikz[baseline=(#3.base), remember picture]
    \node[
        rounded corners=0.25em,
        fill=#1,
        fill opacity=0.2,
        text opacity=1,
        inner sep=#4,
        outer sep=0em
    ] (#3) {
        #2%
    };
}

\newenvironment{overlaypicture}{
    \begin{tikzpicture}[overlay, remember picture]
        }{
    \end{tikzpicture}
}

\newcommand{\colourmathnode}[3]{\colournode{#1}{\ensuremath{#2}}{#3}{0.25em}}
\newcommand{\colouraccentnode}[3]{\colournode{white}{\colouraccent{#1}{#2}}{#3}{0em}}
\newcommand{\textnode}[2]{\colournode{white}{#2}{#1}{0em}}

% More tikz magic for rounded images (CURRENTLY ALWAYS SAME ROUNDED CORNERS)
\newsavebox{\imagebox}
\newcommand{\roundpic}[2]{
    \sbox{\imagebox}{\includegraphics[width=#1]{#2}} % Save the image inside the box    
    \begin{tikzpicture}
        \clip[rounded corners=0.5em] (0,0) rectangle (\wd\imagebox, \ht\imagebox);
        \usebox{\imagebox}
    \end{tikzpicture}
}


%%% Mathematical environments
\newtheoremstyle{aquilathm}
{1em}           % Space above
{1em}           % Space below
{}              % Body font
{}              % Indent amount
{\bfseries}     % Head font
{.}             % Punctuation after head
{ }             % Space after theorem head
{}              % Theorem head spec


\theoremstyle{aquilathm}
\newtheorem{theorem}{Theorem}
\theoremstyle{aquilathm}
\newtheorem{definition}{Definition}
\theoremstyle{aquilathm}
\newtheorem{lemma}{Lemma}
\theoremstyle{aquilathm}
\newtheorem{example}{Example}
\theoremstyle{aquilathm}
\newtheorem{proposition}{Proposition}

\ifcsname section\endcsname
    % If the document class uses chapters, 
    % then update numbering to use chapters.
    \numberwithin{definition}{section}
    \numberwithin{example}{section}
    \numberwithin{proposition}{section}
    \numberwithin{theorem}{section}
    \numberwithin{lemma}{section}
\fi

%%% Some ease-of-life macros
% Differently coloured environments for questions/answers/internal thoughts
\newcommand{\new}[1]{#1}
\newcommand{\question}[1]{\textcolor{red_salsa}{#1}}
\newcommand{\answer}[1]{\textcolor{jungle_green}{#1}}
\newcommand{\remember}[1]{\textcolor{orange_red}{#1}}
\newcommand{\rewrite}[1]{\textcolor{steel_teal}{#1}}
\newcommand{\thought}[1]{\textcolor{purpose_purple}{#1}}

\newcommand{\command}[1]{\texttt{$\backslash$#1}}

\newcommand{\qemph}[1]{\emph{``#1''}}
\newcommand{\resetcounters}{%
    \setcounter{definition}{0}%
    \setcounter{example}{0}%
    \setcounter{equation}{0}%
    \setcounter{figure}{0}%
    \setcounter{table}{0}%
}

%%% Adding a selection of useful mathematics macros
\renewcommand{\vector}[1]{\ensuremath{\boldsymbol{#1}}\xspace}
\newcommand{\diff}{\ensuremath{\ \mathrm{d}}}

%%% Fixing certain math symbols
% Repairs the \neq symbol
\makeatletter
\newcommand{\neg@te}[2]{%
    \vphantom{/#2}%
    \ooalign{\hidewidth$\m@th#1/$\hidewidth\cr$\m@th#1#2$}%
}
\DeclareRobustCommand{\neq}{\mathrel{\mathpalette\neg@te{=}}}
\RenewCommandCopy{\ne}{\neq}
\makeatother

% Same for \notin
\makeatletter
\DeclareRobustCommand{\notin}{\mathrel{\mathpalette\neg@te{\in}}}
\makeatother
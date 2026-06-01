## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 300,
  dev = "ragg_png"
)


## ----basic, fig.height=0.8, fig.width=2, out.width="50%"----------------------
library(gridmicrotex)
library(grid)

g <- latex_grob("\\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}", gp = grid::gpar(fontsize = 24))
grid::grid.newpage()
grid::grid.draw(g)

## ----quick, fig.height=0.8, fig.width=3, out.width="40%"----------------------
grid::grid.newpage()
grid.latex("$\\sum_{i=1}^{n} x_i^2$", gp = grid::gpar(fontsize = 28))

## ----positioning, fig.height=1.2, fig.width=3.5, out.width="40%"--------------
grid::grid.newpage()
grid.latex("Famous $E = mc^2$", x = 0.1, y = 0.7, hjust = 0, gp = grid::gpar(fontsize = 24))
grid.latex("F = ma", x = 0.1, y = 0.3, hjust = 0, gp = grid::gpar(fontsize = 24), input_mode = "math")

## ----baseline-align, fig.height=0.8, fig.width=4.5, out.width="60%"-----------
grid::grid.newpage()
y <- 0.5
grid::grid.segments(unit(0, "npc"), unit(y, "npc"),
                    unit(1, "npc"), unit(y, "npc"),
                    gp = grid::gpar(col = "grey80"))
grid::grid.text("if ", x = 0.10, y = y, just = c(0, 0.5),
                gp = grid::gpar(fontsize = 16))
grid.latex("$x \\geq \\sqrt{2\\pi}$",
           x = 0.22, y = y,
           hjust = "left", vjust = "baseline",
           gp = grid::gpar(fontsize = 16))
grid::grid.text(", then proceed.", x = 0.62, y = y, just = c(0, 0.5),
                gp = grid::gpar(fontsize = 16))

## ----mark, fig.height=2.4, fig.width=5, out.width="70%"-----------------------
g <- latex_grob(
  r"($a^2 + b\mark{term}^2 \mark{equals}= c^2$)",
  x = 0.5, y = 0.4,
  gp = grid::gpar(fontsize = 28)
)
grid::grid.newpage()
grid::grid.draw(g)

# Callout 1: the "=" sign, pointed at from above.
mk_eq <- grobMark(g, "equals")
grid::grid.segments(mk_eq$x, mk_eq$y + unit(15, "mm"),
                    mk_eq$x, mk_eq$y + unit(3, "mm"),
                    arrow = grid::arrow(length = unit(2, "mm"), type = "closed"),
                    gp = grid::gpar(col = "red"))
grid::grid.text("equals", x = mk_eq$x, y = mk_eq$y + unit(18, "mm"),
                gp = grid::gpar(col = "red", fontsize = 11))

# Callout 2: the b^2 term, pointed at from below — the mark sits at the
# end of the term, including the superscript's smaller scale.
mk_bsq <- grobMark(g, "term")
grid::grid.segments(mk_bsq$x - unit(6, "mm"), mk_bsq$y - unit(15, "mm"),
                    mk_bsq$x - unit(2, "mm"), mk_bsq$y - unit(3, "mm"),
                    arrow = grid::arrow(length = unit(2, "mm"), type = "closed"),
                    gp = grid::gpar(col = "blue"))
grid::grid.text("b² term",
                x = mk_bsq$x - unit(7, "mm"),
                y = mk_bsq$y - unit(18, "mm"),
                just = "right",
                gp = grid::gpar(col = "blue", fontsize = 11))

## ----colors, fig.height=0.6, fig.width=2, out.width="40%"---------------------
latex_options(input_mode = "math") # Set math mode globally
grid::grid.newpage()
grid.latex(
  r"(\textcolor{red}{\alpha} + \textcolor{blue}{\beta} = \gamma)",
  gp = grid::gpar(fontsize = 28)
)

## ----fonts-list---------------------------------------------------------------
available_math_fonts()

## ----fonts-default, fig.height=0.8, fig.width=2, out.width="50%"--------------
latex_options(math_font = "stix")
grid::grid.newpage()
grid.latex(r"(\int_0^1 f(x)\,dx)", gp = grid::gpar(fontsize = 24))

# Switch back to the default (Lete Sans Math)
latex_options(math_font = "lete")

## ----fonts, fig.height=1.5, fig.width=2, out.width="50%"----------------------
grid::grid.newpage()
grid::pushViewport(grid::viewport(layout = grid::grid.layout(2, 1)))
grid::pushViewport(grid::viewport(layout.pos.row = 1))
grid.latex(r"(\int_0^1 f(x)\,dx)", gp = grid::gpar(fontsize = 24))
grid::upViewport()
grid::pushViewport(grid::viewport(layout.pos.row = 2))
grid.latex(r"(\int_0^1 f(x)\,dx)", gp = grid::gpar(fontsize = 24), math_font = "stix")
grid::upViewport(2)

## ----dims---------------------------------------------------------------------
dims <- latex_dims("\\frac{a}{b}", gp = grid::gpar(fontsize = 20))
dims

## ----cjk, fig.height = 0.8, fig.width = 2.5, out.width="50%"------------------
grid::grid.newpage()
grid.latex("x^2 + \\text{你好}", gp = grid::gpar(fontsize = 24, fontfamily = "sans"))

## ----font-pairing, fig.height = 0.4, fig.width = 2, out.width="70%"-----------
grid::grid.newpage()
grid.latex(
  "\\text{Theorem: } \\forall x \\in \\mathbb{R},\\; x^2 \\geq 0",
  math_font = "stix",
  gp = grid::gpar(fontfamily = "serif", fontsize = 12)
)

## ----complex-formula, fig.height = 3, fig.width=6, out.width="60%"------------
grid::grid.newpage()
grid.latex(paste0(
      "\\begin{array}{l}",
      "  \\forall\\varepsilon\\in\\mathbb{R}_+^*\\ \\exists\\eta>0",
      "\\ |x-x_0|\\leq\\eta\\Longrightarrow|f(x)-f(x_0)|\\leq\\varepsilon\\\\",
      "  \\det",
      "  \\begin{bmatrix}",
      "      a_{11}&a_{12}&\\cdots&a_{1n}\\\\",
      "      a_{21}&\\ddots&&\\vdots\\\\",
      "      \\vdots&&\\ddots&\\vdots\\\\",
      "      a_{n1}&\\cdots&\\cdots&a_{nn}",
      "  \\end{bmatrix}",
      "  \\overset{\\mathrm{def}}{=}\\sum_{\\sigma\\in\\mathfrak{S}_n}",
      "\\varepsilon(\\sigma)\\prod_{k=1}^n a_{k\\sigma(k)}\\\\",
      "  \\int_0^\\infty{x^{2n} e^{-a x^2}\\,dx} = \\frac{2n-1}{2a}",
      " \\int_0^\\infty{x^{2(n-1)} e^{-a x^2}\\,dx}",
      " = \\frac{(2n-1)!!}{2^{n+1}} \\sqrt{\\frac{\\pi}{a^{2n+1}}}\\\\",
      "\\end{array}"
), gp = grid::gpar(fontsize = 16))

## ----table-multicolumn, fig.height = 3, fig.width=8, out.width="60%"----------
grid::grid.newpage()

grid.latex(
  "
  \\newcolumntype{s}{>{\\color{#1234B6}}c}
\\begin{array}{|c|c|c|s|}
  \\hline
  \\rowcolor{Tan}\\multicolumn{4}{|c|}{\\textcolor{white}{\\bold{\\text{Table Head}}}}\\\\
  \\hline
  \\text{Matrix}&\\multicolumn{2}{|c|}{\\text{Multicolumns}}&\\text{Font size commands}\\\\
  \\hline
  \\begin{pmatrix}
      \\alpha_{11}&\\cdots&\\alpha_{1n}\\\\
      \\hdotsfor{3}\\\\
      \\alpha_{n1}&\\cdots&\\alpha_{nn}
  \\end{pmatrix}
  &\\large \\text{Left}&\\cellcolor{#00bde5}\\small \\textcolor{white}{\\text{\\bold{Right}}}
  &\\small \\text{small Small}\\\\
  \\hline
  \\multicolumn{4}{|c|}{\\text{Table Foot}}\\\\
  \\hline
\\end{array}
  ",
  gp = grid::gpar(fontsize = 22)
)

## ----complicated-equation, fig.height = 9, fig.width=9, out.width="60%"-------
grid::grid.newpage()
grid.latex(
  "\\definecolor{gris}{gray}{0.9}
\\definecolor{noir}{rgb}{0,0,0}
\\definecolor{bleu}{rgb}{0,0,1}
\\fatalIfCmdConflict{false}
\\newcommand{\\pa}{\\left|}
\\begin{array}{c}
  \\LaTeX\\\\
  \\begin{split}
      |I_2| &= \\pa\\int_0^T\\psi(t)\\left\\{ u(a,t)-\\int_{\\gamma(t)}^a \\frac{d\\theta}{k} (\\theta,t) \\int_a^\\theta c(\\xi)
          u_t (\\xi,t)\\,d\\xi\\right\\}dt\\right|\\\\
      &\\le C_6 \\Bigg|\\pa f \\int_\\Omega \\pa\\widetilde{S}^{-1,0}_{a,-}
          W_2(\\Omega, \\Gamma_1)\\right|\\ \\right|\\left| |u|\\overset{\\circ}{\\to} W_2^{\\widetilde{A}}(\\Omega\\Gamma_r,T)\\right|\\Bigg|\\\\
      &\\\\
      &\\begin{pmatrix}
          \\alpha&\\beta&\\gamma&\\delta\\\\
          \\aleph&\\beth&\\gimel&\\daleth\\\\
          \\mathfrak{A}&\\mathfrak{B}&\\mathfrak{C}&\\mathfrak{D}\\\\
          \\boldsymbol{\\mathfrak{a}}&\\boldsymbol{\\mathfrak{b}}&\\boldsymbol{\\mathfrak{c}}&\\boldsymbol{\\mathfrak{d}}
      \\end{pmatrix}
      \\quad{(a+b)}^{\\frac{n}{2}}=\\sqrt{\\sum_{k=0}^n\\tbinom{n}{k}a^kb^{n-k}}\\quad
          \\Biggl(\\biggl(\\Bigl(\\bigl(()\\bigr)\\Bigr)\\biggr)\\Biggr)\\\\
      &\\forall\\varepsilon\\in\\mathbb{R}_+^*\\ \\exists\\eta>0\\ |x-x_0|\\leq\\eta\\Longrightarrow|f(x)-f(x_0)|\\leq\\varepsilon\\\\
      &\\det
      \\begin{bmatrix}
          a_{11}&a_{12}&\\cdots&a_{1n}\\\\
          a_{21}&\\ddots&&\\vdots\\\\
          \\vdots&&\\ddots&\\vdots\\\\
          a_{n1}&\\cdots&\\cdots&a_{nn}
      \\end{bmatrix}
      \\overset{\\mathrm{def}}{=}\\sum_{\\sigma\\in\\mathfrak{S}_n}\\varepsilon(\\sigma)\\prod_{k=1}^n a_{k\\sigma(k)}\\\\
      &\\Delta f(x,y)=\\frac{\\partial^2f}{\\partial x^2}+\\frac{\\partial^2f}{\\partial y^2}\\qquad\\qquad \\fcolorbox{noir}{gris}
          {n!\\underset{n\\rightarrow+\\infty}{\\sim} {\\left(\\frac{n}{e}\\right)}^n\\sqrt{2\\pi n}}\\\\
      &\\sideset{_\\alpha^\\beta}{_\\gamma^\\delta}{
      \\begin{pmatrix}
          a&b\\\\
          c&d
      \\end{pmatrix}}
      \\xrightarrow[T]{n\\pm i-j}\\sideset{^t}{}A\\xleftarrow{\\overrightarrow{u}\\wedge\\overrightarrow{v}}
          \\underleftrightarrow{\\iint_{\\mathds{R}^2}e^{-\\left(x^2+y^2\\right)}\\,\\mathrm{d}x\\mathrm{d}y}
  \\end{split}\\\\
  \\rotatebox{30}{\\sum_{n=1}^{+\\infty}}\\quad\\mbox{Mirror rorriM}\\reflectbox{\\mbox{Mirror rorriM}}
\\end{array}",
  gp = grid::gpar(fontsize = 22),
  render_mode = "path"
)

## ----lists, fig.height=1.4, fig.width=3, out.width="45%"----------------------
grid::grid.newpage()
grid.latex(paste0(
  "\\begin{enumerate}",
  "  \\item e^{i\\pi} + 1 = 0",
  "  \\item \\begin{itemize}",
  "           \\item \\alpha \\item \\beta",
  "         \\end{itemize}",
  "\\end{enumerate}"
), gp = grid::gpar(fontsize = 20))

## ----options, eval=FALSE------------------------------------------------------
# latex_options(math_font = "stix", render_mode = "typeface")
# 
# # Later calls pick these up automatically
# grid.latex("\\sum_{i=1}^{n} i^{2}", gp = grid::gpar(fontsize = 14))
# 
# # Query current settings
# latex_options()
# 
# # Reset to built-in defaults
# reset_latex_options()

## ----macros, fig.height=0.7, fig.width=3, out.width="50%"---------------------
define_macro("RR", "\\mathbb{R}")
define_macro("eps", "\\varepsilon")

grid::grid.newpage()
grid.latex("\\forall \\eps > 0, \\eps \\in \\RR", gp = grid::gpar(fontsize = 24))

clear_macros()

## ----def-inline, fig.height=0.7, fig.width=4, out.width="60%"-----------------
grid::grid.newpage()
grid.latex(
  r"(\def\norm#1{\left\lVert #1 \right\rVert}
      \def\inner#1#2{\langle #1, #2 \rangle}
      \norm{\vec{v}} = \sqrt{\inner{\vec{v}}{\vec{v}}})",
  gp = grid::gpar(fontsize = 24)
)

## ----cache, eval=FALSE--------------------------------------------------------
# latex_cache_info()       # size / max_size / hits / misses
# latex_cache_limit(1024)  # raise or lower the LRU capacity
# latex_cache_clear()      # wipe the cache (e.g. after re-loading fonts)

## ----tree---------------------------------------------------------------------
tr <- latex_tree("\\frac{a}{b}")
tr
head(tr$records, 3)

## ----debug, fig.height=1, fig.width=3, out.width="60%"------------------------
grid::grid.newpage()
grid.latex("x^{2} + y_{i}", gp = grid::gpar(fontsize = 30), debug = TRUE)


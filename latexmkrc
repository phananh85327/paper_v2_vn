# latexmkrc for paper_v2_vn. latexmk reads this file when it runs in this folder: when VS Code
# (LaTeX Workshop) builds the paper, or when you type "latexmk" in a terminal here.

# Build with LuaLaTeX, which paper_v2_vn.tex needs (it stops at once under pdfLaTeX).
$pdf_mode = 4;

# "latexmk" with no file name builds the paper and then its supplementary document
# (supplement_vn.tex, N31), not plan_v2_vn.tex, glossary_vn.tex or numbers.tex, which are in the
# same folder.
@default_files = ('paper_v2_vn.tex', 'supplement_vn.tex');

# references.bib, notes_extra.bib and reading_list.bib: on Overleaf they are at the project
# root, one folder above this one. BibTeX looks in this folder first and then one folder up, so
# either place works. (ensure_path puts the folder named last first.)
ensure_path('BIBINPUTS', '..', '.');

# supplement_vn.tex prints the paper's section, table and figure numbers, which the xr package
# reads from paper_v2_vn.aux. This rule (Overleaf's recipe for xr) builds the paper first when
# that file is missing or older than paper_v2_vn.tex, also when Overleaf compiles the supplement
# as its main document. The test on $root_filename keeps a document from building itself.
add_cus_dep('tex', 'aux', 0, 'makeexternaldocument');
sub makeexternaldocument {
    if (!($root_filename eq $_[0])) {
        system("latexmk -cd -pdflua \"$_[0]\"");
    }
}

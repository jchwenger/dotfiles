# merging several pdfs into one, thanks to this reference
# https://stackoverflow.com/a/19358402
# used like so: $ pdfmerge outputname input1 input2 ...
# preserve links with -dPrinted, see:
# https://tex.stackexchange.com/a/458631
gs \
  -sDEVICE=pdfwrite \
  -dCompatibilityLevel=1.4 \
  -dPDFSETTINGS=/default \
  -dPrinted=false \
  -dNOPAUSE \
  -dQUIET \
  -dBATCH \
  -dDetectDuplicateImages \
  -dCompressFonts=true \
  -r150 \
  -sOutputFile=$1 ${@:2}

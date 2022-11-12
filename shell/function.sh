# utility functions
function _init-option-flags() {
    for char in {{a..z},{A..Z}}
    do
        eval OPT_FLAG_${char}=0;
    done
}

function _parse-options() {
    declare object=''
    HAS_OPT_FLAG=0
    object="$1"
    shift
    while getopts "$object" OPT
    do
        eval OPT_FLAG_${OPT}=1
        eval HAS_OPT_FLAG=1
    done
}

functon gcc-exec() {
    declare filename="$1"
    declare filename_without_ext="${filename%.*}"
    gcc-12 "$filename" -o "$filename_without_ext" \
        && "./${filename_without_ext}" \
        && rm "./${filename_without_ext}"
}

function _latest() {
    _init-option-flags
    _parse-options "al" "$@"
    [[ $HAS_OPT_FLAG == 1 ]] && shift

    declare arg=${1:-$PWD}
    declare options='-rt'
    declare number=1
    [[ $OPT_FLAG_a == 1 ]] && options+='a' && number=2
    [[ $OPT_FLAG_l == 1 ]] && options+='l'
    command ls "$options" "$arg" | tail -n "$number" | head -n 1
}

function latest() {
    declare arg=${1:-$PWD}
    declare opt=''
    getopts 'l' opt
    if [[ "$opt" == 'l' ]]; then
        command ls -rtl "$arg" | tail -n 1
    else
        command ls -rt "$arg" | tail -n 1
    fi
}

# function ocr() {
#     declare filename="$1"
#     declare output="${filename%.*}_ocr.pdf"
#     nohup ocrmypdf --clean -l eng+jpn+equ "$filename" "$output" > /dev/null 2>&1 &
# }


function pdf-compress() {
    declare object="$1"
    declare output="$2"

    gs -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        -dPDFSETTINGS=/default \
        -dEmbedAllFonts=true \
        -dSubsetFonts=true \
        -dcompressFonts=false \
        -dPrinted=false \
        -dNOPAUSE -dQUIET -dBATCH \
        -sOutputFile="$output" "$object"
}

function pdf-to-a4() {
    declare filename="$1"
    declare output="${filename%.*}_aligned.pdf"

    nohup gs -sDEVICE=pdfwrite \
        -dNOPAUSE -dQUIET -dBATCH \
        -dPDFFitPage \
        -sPAPERSIZE=a4 \
        -sOutputFile="$output" "$filename" > /dev/null 2>&1 &
}

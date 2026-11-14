# runiq (fast deduplication, in Rust)
# -------------------------
# https://github.com/whitfin/runiq
cargo install runiq

# pigz (parallel gzip)
# --------------------
# https://zlib.net/pigz/
# (download, untar & make manually)

# hck (rougher form of cut)
# -------------------------
# https://github.com/sstadick/hck
# (update rust if needed: https://www.rust-lang.org/tools/install)
export RUSTFLAGS='-C target-cpu=native'
cargo install hck

# selenium (webdriver): installing Firefox & Chrome drivers
# ---------------------------------------------------------

# chromedriver
# https://formulae.brew.sh/cask/chromedriver
# MacOS unquarantine required: https://stackoverflow.com/a/60374958
# brew install --cask chromedriver

# geckodriver
# https://formulae.brew.sh/formula/geckodriver#default
# brew install geckodriver

# httrack website copier
# http://www.httrack.com/
# sudo apt update && sudo apt install webhttrack

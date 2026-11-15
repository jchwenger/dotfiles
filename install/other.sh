# runiq (fast deduplication, in Rust)
# -------------------------
# https://github.com/whitfin/runiq
cargo install runiq

# hck (rougher form of cut)
# -------------------------
# https://github.com/sstadick/hck
# (update rust if needed: https://www.rust-lang.org/tools/install)
export RUSTFLAGS='-C target-cpu=native'
cargo install hck

# # Jekyll
# # ------
# # requires ruby, see 02.other.brewfile
# # https://jekyllrb.com/docs/installation/macos/
# gem install jekyll

# # Gatsby
# # ------
# # https://www.gatsbyjs.org/
# npm install -g gatsby-cli

# opencode
curl -fsSL https://opencode.ai/install | bash

# Imagemagick policy restrictions riddance
# https://askubuntu.com/a/1081907
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout
# to reverse:
# sudo mv /etc/ImageMagick-6/policy.xmlout /etc/ImageMagick-6/policy.xml

# markdown-viewer
# ---------------
# read markdown with Firefox (install from the browser
# https://github.com/KeithLRobertson/markdown-viewer
# install for Linux:
# https://github.com/KeithLRobertson/markdown-viewer#installing-on-linux
mkdir -p $HOME/.local/share/mime/packages
f="$HOME/.local/share/mime/packages/text-markdown.xml"
touch $f
echo '<?xml version="1.0"?>' >> $f
echo '<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">' >> $f
echo '  <mime-type type="text/plain">' >> $f
echo '    <glob pattern="*.md"/>' >> $f
echo '    <glob pattern="*.mkd"/>' >> $f
echo '    <glob pattern="*.mkdn"/>' >> $f
echo '    <glob pattern="*.mdwn"/>' >> $f
echo '    <glob pattern="*.mdown"/>' >> $f
echo '    <glob pattern="*.markdown"/>' >> $f
echo '  </mime-type>' >> $f
echo '</mime-info>' >> $f
update-mime-database ~/.local/share/mime


# aUI

This is a repository for storing a YAML-format dictionary of the [aUI language](https://en.wikipedia.org/wiki/AUI_(constructed_language), created by Dr. John Weilgart in the 1950s as the "Language of Space."

The file `fromwebonary.rb` can be used to reproduce the original scrape of [webonary.work](https://www.webonary.org/aui/overview/foreword/), the home of the most "official" version of the language's vocabulary. It might be able to be reused for scraping dictionaries of other languages from that site, but I haven't tested this yet. If you use it for this purpose, please respect the proprieters of Webonary and keep the request rate at or above 2 requests/second.

The file `aui.sh` is a quick example of a basic shell script (tested in Bash 5) to retrieve aUI definitions from the dictionary based on an English key. It requires [yq](https://mikefarah.github.io/yq/) and [fzf](https://github.com/junegunn/fzf).

---

*Disclaimer*: I am a hobbyist and in no way affiliated with the creators/maintainers of aUI, the non-profit [Cosmic Communication Foundation](https://auilanguage.org/). The intent of this repository is to present, in machine-readable format, an unaltered dictionary of the language that was compiled by the actual creators and presented by them for public consumption via the website webonary.work. To the best of my knowledge, there are no restrictions on the use or reproduction of this information in digital format. If you are a representative of CCF and object to this reproduction, contact me via Github and I will remove it from public availability.

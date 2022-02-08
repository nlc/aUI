<p align="center"><img src="https://github.com/nlc/aUI/blob/master/img/logo.png?raw=true" alt="Dictionary"></p>

# aUI

This is a repository for storing a [YAML](https://yaml.org/)-format dictionary of the [aUI language](https://en.wikipedia.org/wiki/AUI_(constructed_language)), created by Dr. John Weilgart in the 1950s as the "Language of Space." The complete dictionary, containing 7646 English terms mapped to 10K+ aUI translations, can be found in the file `aui.yaml`.

The file `fromwebonary.rb` can be used to reproduce the original retrieval of the data from [webonary.work](https://www.webonary.org/aui/overview/foreword/), which hosts the most "official" version of the language's vocabulary. It might be able to be reused for retrieving dictionaries of other languages from that site, but I haven't tested this yet. If you use it for this purpose, please respect the proprieters of Webonary and make sure the request rate is at most 2 requests/second.

The file `aui.sh` is a quick example of a basic shell script (tested in Bash 5) to retrieve aUI definitions from the dictionary based on an English key. It requires [yq](https://mikefarah.github.io/yq/) and [fzf](https://github.com/junegunn/fzf) to be installed.

<p align="center"><img src="https://github.com/nlc/aUI/blob/master/img/example2.gif?raw=true"></p>

---

**Disclaimer**: I am a hobbyist and in no way affiliated with the creators/maintainers of aUI, the non-profit [Cosmic Communication Foundation](https://auilanguage.org/) (CCF). The intent of this repository is to present the data in question in machine-readable format for the purpose of reference. No alterations have been made to the contents of the dictionary, which was compiled by the CCF and presented by them for public consumption via the website webonary.work. All rights are reserved by Andrea G. Weilgart Patten and the CCF. To the best of my knowledge as of this writing, there are no restrictions on the use or reproduction of this information in digital format. If you are a representative of the CCF and you object to this reproduction, contact me via Github and I will remove it from public availability.

<p align="center"><img src="https://github.com/nlc/aUI/blob/master/img/enjoy.png?raw=true" alt="Enjoy!"></p>

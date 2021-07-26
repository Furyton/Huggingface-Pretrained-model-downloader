# Huggingface-Pretrained-model-downloader
download the pretrained model published on huggingface.co. just a small script download file through Tsinghua mirrors(mirrors.tuna.tsinghua.edu.cn/hugging-face-models).

there are 4 options, 2 of them are must-required. you can check it out by `./downloader.sh -h`

`-r` (required): a repo id (e.g. a model id like julien-c/EsperBERTo-small i.e. a user or organization name and a repo name, separated by '/')

`-f` (required): a file list you want to download (e.g. pytorch_model.bin,config.json), note you need to seperate the files by comma, no space between.

`-o` : output directory, by default it will download it into a dir the same as the repo id (e.g. ./julien-c/EsperBERTo-small)

`-a` : save the files with another name, the format is the same as `-f`, the same order is required, some absence is ok.


TODO: 
- need more clearer prompt, like how many files are downloaded successfully..., note some files in huggingface.co are not sync on tuna, but these files are not that important i think.
- i should add an option for downloading a certain bunch of files at a time instead of typing in all the file names.


UPDATE:
- set default file list as "pytorch_model.bin,config.json,tokenizer.json,vocab.txt,tokenizer_config.json"
- wget -O will overwrite -P option. fixed it
- some files in tuna have redundant name prefix. fixed it
- remove the verbose in wget except progress bar, but the wget version in my lab server is lower than 1.16, so an auxiliary function is needed.

# Huggingface-Pretrained-model-downloader

## note

Since [tuna](https://tuna.moe/) has removed the support of `hugging-face-models` in Tsinghua mirror, this repo will no longer be useful.

> 由于 Hugging Face 官方不再提供 AWS S3 形式的模型存储，转而使用 Git LFS（详见 相关讨论），并且日常下载量逐渐下降，我们将于近期移除 hugging-face-models 仓库。
>
> 具体实施计划如下：
>
> - 2021/8/15：停止该仓库同步、移除使用帮助、从主页隐藏该仓库（已经执行）
> - 2021/8/31：从服务器中移除仓库内容
> 
> 请各位用户及时迁移至官方上游，以免给您的使用带来不便。

from [official notice](https://mirrors.tuna.tsinghua.edu.cn/news/remove-hugging-face/)

## old intro

download the pretrained model published on huggingface.co. just a small script download file through Tsinghua mirrors(mirrors.tuna.tsinghua.edu.cn/hugging-face-models).

there are 4 options, 1 of them are must-required. you can check it out by `./downloader.sh -h`

`-r` (required): a repo id (e.g. a model id like julien-c/EsperBERTo-small i.e. a user or organization name and a repo name, separated by '/')

`-f` : a file list you want to download (e.g. pytorch_model.bin,config.json), note you need to seperate the files by comma, no space between.

`-o` : output directory, by default it will download it into a dir the same as the repo id (e.g. ./julien-c/EsperBERTo-small)

`-a` : save the files with another name, the format is the same as `-f`, the same order is required, some absence is ok.


TODO: 
- need more clearer prompt, like how many files are downloaded successfully..., note some files in huggingface.co are not sync on tuna, but these files are not that important i think.
- i should add an option for downloading a certain bunch of files at a time instead of typing in all the file names.


UPDATE:
7-26-21
- set default file list as "pytorch_model.bin,config.json,tokenizer.json,vocab.txt,tokenizer_config.json", so -f option is not must-required.
- wget -O will overwrite -P option. fixed it
- some files in tuna have redundant name prefix. fixed it
- remove the verbose in wget except progress bar, but the wget version in my lab server is lower than 1.16, so an auxiliary function is needed.

**目录 (Table of Contents)**

[TOCM]

[TOC]



# Git >>
### .gitignore 文件

### 下载文件
- `git clone https://github.com/2NanA/php-simple-restful-api.git`

- firstgit
https://blog.csdn.net/pql925/article/details/72772660
- `git config --global user.name "2NanA"`
`git config --global user.email "494243364@qq.com"`

### 上传
- `git init`
- `git add README.md`
- `git commit -m "SECOND commit"`
- `git remote add origin https://github.com/2NanA/SimpleRestful.git `
 (远端仓库 和本地仓库的链接    只用执行一步)
- `git push -u origin master`
- `git pull --rebase origin master`
- `git add -A`  提交所有变化
- `git add -u`  提交被修改(modified)和被删除(deleted)文件，不包括新文件(new)
- `git add .`  提交新文件(new)和被修改(modified)文件，不包括被删除(deleted)文件
- git命令行 D:\Program Files\Git\mingw64\share\doc\git-doc
- `git merge` 有冲突的时候必须把两个文件改成一样的

- `git checkout myone` 测试
  - Switched to branch 'myone'
  - M       myone
  - 在master 分支修改文件之后，不add 也不commit 当文件名与branch name 同名时候 显示2条提示语
  - error: Your local changes to the following files would be overwritten by checkout:
        myone
  - Please commit your changes or stash them before you switch branches.
    Aborting
  - 这种情况  git checkout -- myone 先更新文件到上一版本的内容，或者先提交改动，在切换分支
- git reflog 可以查看到提交的版本号 如果reset 到之前的版本号了，可以用reflog 先找到reset 之前的版本然后在reset 回去

查看所有分支
删除分支

### 参考
- [git 详解](https://blog.csdn.net/chenshun123/article/details/51236423)
- [git教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001373962845513aefd77a99f4145f0a2c7a7ca057e7570000)
- [git 文档](https://git-scm.com/book/zh)
- [git checkout](https://www.cnblogs.com/kuyuecs/p/7111749.html)
- [git reset soft,hard,mixed之区别](https://www.cnblogs.com/kidsitcn/p/4513297.html)

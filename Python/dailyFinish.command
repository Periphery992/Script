#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import os
from os import popen
import socket

#全局参数
codeSnippetPath = '' #系统codeSnippet存储路径
sundaryPath = ''     #sundary github在电脑本地的路径
userDataPath = ''
githubPath = ''
scriptPath = ''

def main():

    getPath()

    commitCodeSnippets()
    commitScript()

def getPath():

    global codeSnippetPath  #系统codeSnippet存储路径
    global sundaryPath      #sundary github在电脑本地的路径
    global userDataPath      #sundary github在电脑本地的路径
    global githubPath
    global scriptPath


    hostname = popen('hostname').read()
    if 'chenshuaodeMacBook-Pro' in hostname: #自己的电脑
        print '#####自己的电脑#####'
        userDataPath = "/Users/chenshuao/Library/Developer/Xcode/UserData"
        sundaryPath = "/Users/chenshuao/Documents/workspaces/iOS/github/Sundary"
        githubPath = "/Users/chenshuao/Documents/workspaces/github"
        scriptPath = "/Users/chenshuao/Documents/workspaces/github/Script"
        codeSnippetPath = os.path.join(userDataPath,'CodeSnippets')
    elif 'chenshuaodeMac-mini.local' in hostname: #公司的电脑
        print '#####公司的电脑####'
        userDataPath = "/Users/chenshuao/Library/Developer/Xcode/UserData"
        sundaryPath = "/Users/chenshuao/Documents/workspaces/github/Sundary"
        githubPath = "/Users/chenshuao/Documents/workspaces/github"
        scriptPath = "/Users/chenshuao/Documents/workspaces/github/Script"
        codeSnippetPath = os.path.join(userDataPath,'CodeSnippets')

def commitCodeSnippets():
    print "#####提交codeSnippets到git"
    os.chdir(codeSnippetPath)
    os.system('git add .')
    os.system('git commit -m \'upload Codesnippets\'')
    os.system('git push')

def commitScript():
    print "#####提交Script到git"
    os.chdir(scriptPath)
    os.system('git add .')
    os.system('git commit -m \'upload Script\'')
    os.system('git push')

main()

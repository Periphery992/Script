#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import os
from os import popen
import socket

#全局参数
codeSnippetPath = '' #系统codeSnippet存储路径
userDataPath = ''    #系统codeSnippet上级路径
githubPath = ''      #github本地路径
scriptPath = ''      #script本地路径

def main():

    getPath()
    changeFileName()

    commitCodeSnippets()
    commitScript()

def getPath():

    global codeSnippetPath  #系统codeSnippet存储路径
    global userDataPath     #系统codeSnippet上级路径
    global githubPath       #github本地路径
    global scriptPath       #script本地路径ß


    hostname = popen('hostname').read()
    if 'chenshuaodeMacBook-Pro' in hostname: #自己的电脑
        print '#####自己的电脑#####'
        userDataPath = "/Users/chenshuao/Library/Developer/Xcode/UserData"
        githubPath = "/Users/chenshuao/Documents/workspaces/github"
        scriptPath = "/Users/chenshuao/Documents/workspaces/github/Script"
        codeSnippetPath = os.path.join(userDataPath,'CodeSnippets')
    elif 'chenshuaodeMac-mini.local' in hostname: #公司的电脑
        print '#####公司的电脑####'
        userDataPath = "/Users/chenshuao/Library/Developer/Xcode/UserData"
        githubPath = "/Users/chenshuao/Documents/workspaces/github"
        scriptPath = "/Users/chenshuao/Documents/workspaces/github/Script"
        codeSnippetPath = os.path.join(userDataPath,'CodeSnippets')


def changeFileName():

    for fpath,dirs,fs in os.walk(codeSnippetPath):
        for fname in fs:
            if ".codesnippet" in fname:
                f = open(os.path.join(codeSnippetPath,fname),'r')
                flist = f.readlines()
                i = 0
                for line in flist:
                    if "IDECodeSnippetCompletionPrefix" in line:
                        i = i+1
                        break
                    i = i+1
                tagline = flist[i]
                name = tagline[9:len(tagline)-10]
                newname = name+".codesnippet"
                os.rename(os.path.join(codeSnippetPath,fname),os.path.join(codeSnippetPath,newname))

#上传CodeSnippets
def commitCodeSnippets():
    print "#####提交codeSnippets到git"
    os.chdir(codeSnippetPath)
    os.system('git add .')
    os.system('git commit -m \'upload Codesnippets\'')
    os.system('git push')

#上传cript
def commitScript():
    print "#####提交Script到git"
    os.chdir(scriptPath)
    os.system('git add .')
    os.system('git commit -m \'upload Script\'')
    os.system('git push')

main()


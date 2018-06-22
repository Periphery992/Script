#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import os
from os import popen
import socket
import commands

#全局参数
codeSnippetPath = '' #系统codeSnippet存储路径
userDataPath = ''    #系统codeSnippet上级路径
githubPath = ''      #github本地路径
scriptPath = ''      #script本地路径

def main():

    getPath()
    gitCloneOrPullCodesnippet()
    gitCloneOrPullScript()

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

#clone或者更新本地Codesnippet
def gitCloneOrPullCodesnippet():

    gitFilePath = os.path.join(codeSnippetPath,'.git')
    if os.path.exists(gitFilePath):
        print '#####git CodeSnippets pull'
        os.chdir(codeSnippetPath)
        os.system('git pull origin master')
        print '#####git CodeSnippets pull done'
    else:
        print '#####git CodeSnippets clone'
        shutil.rmtree(codeSnippetPath)
        os.chdir(userDataPath)
        os.system('git clone https://github.com/Periphery992/CodeSnippets.git')
        print '#####git CodeSnippets clone done'

#clone或者更新本地Script
def gitCloneOrPullScript():

    gitFilePath = os.path.join(scriptPath,'.git')
    if os.path.exists(gitFilePath):
        print '#####git pull script'
        os.chdir(scriptPath)
        os.system('git pull origin master')
        print '#####git pull script done'
    else:
        print '#####git script clone'
        if os.path.exists(scriptPath):
            shutil.rmtree(scriptPath)
        os.chdir(githubPath)
        os.system('git clone https://github.com/Periphery992/Script.git')
        print '#####git script clone done'

main()


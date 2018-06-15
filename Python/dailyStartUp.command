#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import os
from os import popen
import socket
import commands

#全局参数
codeSnippetPath = '' #系统codeSnippet存储路径
sundaryPath = ''     #sundary github在电脑本地的路径
userDataPath = ''
githubPath = ''
scriptPath = ''

def main():

    getPath()
    gitCloneOrPullCodesnippet()
    gitCloneOrPullScript()



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


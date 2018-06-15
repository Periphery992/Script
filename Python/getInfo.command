#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import os
from os import popen
import socket

#全局参数
codeSnippetPath = '' #系统codeSnippet存储路径
sundaryPath = ''     #sundary github在电脑本地的路径


def main():

    getPath()



def getPath():

    hostname = popen('hostname').read()
    print hostname





main()


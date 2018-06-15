#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys,os


def main():

    path = '/Users/chenshuao/Documents/workspaces/SVN/Hik-Connect/v3.5'
    List_Newimage = [];
    for fpathe,dirs,fs in os.walk(path): #遍历整个资源文件夹
        for fname in fs: #遍历文件名称
            if os.path.splitext(fname)[1] == ".png" :  #如果文件是图片，进入替换判断流程
                if fname in List_Newimage:
                    print fname
                else:
                    List_Newimage.append(fname);


main()


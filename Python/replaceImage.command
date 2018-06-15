#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import shutil

def main():

    global path1
    global path2
    #新资源
    path1 = '/Users/chenshuao/Documents/data/custom/CC/3.3.1/18.5.21/basic'
    #老模板
    path2 = '/Users/chenshuao/Documents/workspaces/SVN/Hik-Connect/custom/3.3.1/Clare_Controls/VideoGo/SupportingFiles/imageRes'

    modify_picAll()


#修改除启动页和icon以外的所有图片
def modify_picAll():

    print ("#开始替换图片资源")
    List_Newimage = [];
    List_NewimagePath = [];
    List_OldImage = [];
    List_OldImagePath = [];

    for fpathe,dirs,fs in os.walk(path1): #遍历整个资源文件夹
        for fname in fs: #遍历文件名称
            if os.path.splitext(fname)[1] == ".png" :  #如果文件是图片，进入替换判断流程
                List_Newimage.append(fname);
                List_NewimagePath.append(os.path.join(fpathe,fname));
            else:
                continue;

    for fpathe,dirs,fs in os.walk(path2): #遍历整个资源文件夹
        for fname in fs: #遍历文件名称
            if os.path.splitext(fname)[1] == ".png" :  #如果文件是图片，进入替换判断流程
                List_OldImage.append(fname);
                List_OldImagePath.append(os.path.join(fpathe,fname));
            else:
                continue;

    for newfname in List_Newimage :
        for oldfname in List_OldImage:
            if newfname == oldfname:
                inew = List_Newimage.index(newfname);
                iold = List_OldImage.index(oldfname);
                shutil.copyfile(List_NewimagePath[inew],List_OldImagePath[iold])
    print ("#替换图片资源完成")


main()

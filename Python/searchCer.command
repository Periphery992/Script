#!/usr/local/bin/python
# -*- coding: utf-8 -*-
import os,sys
import shutil

def main():

    global targetPath
    targetPath = "/Users/chenshuao/Library/MobileDevice/Provisioning Profiles"
    projectName = raw_input("请输入应用名称：")

    global list
    list = []

    for fpathe,dirs,fs in os.walk(targetPath): #遍历整个资源文件夹
        for fname in fs:
            i = 0
            FlagUDID = False;
            FlagName = False;

            fInfoplist = open(os.path.join(targetPath,fname),'r+')
            flist = fInfoplist.readlines()
            for line in flist:
                i = i+1
                if projectName in line :
                    if FlagUDID == False:
                        FlagUDID = True
                        list.append(fname)
                if "<key>Name</key>" in line:
                    FlagName = True
                    fileName = flist[i]
                if FlagUDID&FlagName:
                    print fname+'\n'+fileName
                    break;
    if len(list) == 0:
        print "没有该应用的配置文件"
        return


    print list

    delete = raw_input("是否删除（清空输入all或ALL，删除其中一个输入名称，不删除输入n或N）")
    while delete != "n" and delete != "N":
        if delete == "all" or delete == "ALL":
            for fname in list:
                if os.path.exists(os.path.join(targetPath,fname)):
                    os.remove(os.path.join(targetPath,fname))
                    print os.path.join(targetPath,fname)+"已删除"
                else:
                    print os.path.join(targetPath,fname)+"不存在"
        elif delete in list:
            if os.path.exists(os.path.join(targetPath,delete)):
                os.remove(os.path.join(targetPath,delete))
                print os.path.join(targetPath,delete)+"已删除1"
            else:
                print os.path.join(targetPath,delete)+"不存在1"
        else:
            print "输入不合法"
        delete = raw_input("是否删除（清空输入all，删除其中一个输入名称，不删除输入n）")


def deleteAgain():
    delete = raw_input("是否删除（清空输入all或ALL，删除其中一个输入名称，不删除输入n或N）")

    if delete == "all":
        for fname in list:
            if os.path.exists(os.path.join(targetPath,fname)):
                os.remove(os.path.join(targetPath,fname))
                print os.path.join(targetPath,fname)+"已删除"
            else:
                print os.path.join(targetPath,fname)+"不存在"
    elif delete in list:
        if os.path.exists(os.path.join(targetPath,delete)):
            os.remove(os.path.join(targetPath,delete))
            print os.path.join(targetPath,delete)+"已删除"
        else:
            print os.path.join(targetPath,delete)+"不存在"
    elif delete == "no":
        print "执行完成"
    else:
        print "输入不合法"





main()

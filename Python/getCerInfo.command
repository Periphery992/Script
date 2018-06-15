#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os,sys
import shutil

def main():
    projectName = raw_input("请输入应用名称：")
    simpleName = raw_input("请输入分支名称：")

    ADHocfileName = projectName+'_ADHoc.mobileprovision'
    AppStorefileName = projectName+'_AppStore.mobileprovision'

    targetPath = '/Users/chenshuao/Documents/data/certificates/'+simpleName
    
    ADHocPath = os.path.join(targetPath,ADHocfileName)
    AppStorePath = os.path.join(targetPath,AppStorefileName)
    InfoPath = os.path.join(targetPath,projectName+'.txt')

    ADHocUDID = getUDID(ADHocPath)
    AppStoreUDID = getUDID(AppStorePath)
    AppTeamID = getTeamID(ADHocPath)
    AppTeamName = getTeamName(ADHocPath)
    BundleID = getBundleID(ADHocPath)
    
    f=open(InfoPath,'w+')
    f.write("########################"+simpleName+"########################"+"\n"
            +"release_"+simpleName+".configuration=Distribution\n"
            +"release_"+simpleName+".workspaceName=VideoGo.xcworkspace\n"
            +"release_"+simpleName+".scheme=Guarding Vision\n"
            +"release_"+simpleName+".codeSignIdentity="+"iPhone Distribution: "+AppTeamName+" ("+AppTeamID+")"+"\n"
            +"release_"+simpleName+".provisioningProfile="+AppStoreUDID+"\n"
            +"release_"+simpleName+".exportOptionsPlist=-exportOptionsPlist VideoGo/SupportingFiles/LocalData/AppStoreExportOptionsPlist.plist\n"
            +"release_"+simpleName+".bundleId="+BundleID[11:]+"\n"
            +"release_"+simpleName+".developeTeam="+AppTeamID+"\n"
            +"release_"+simpleName+".exportPath=../release/\n"
            +"release_"+simpleName+".log=../release.log\n"
            +"release_"+simpleName+".archivePath=../release/"+simpleName+".xcarchive\n"
            +"release_"+simpleName+".profileSpecifier="+projectName+"_AppStore"+"\n"
            +"release_"+simpleName+".certificate=hc_certificate/"+simpleName+"/"+projectName+".p12"+"\n"
            +"release_"+simpleName+".mobileprovision=hc_certificate/"+simpleName+"/"+projectName+"_AppStore.mobileprovision"+"\n"
            +"release_"+simpleName+".xcodebuild=/Applications/Xcode9.app/Contents/Developer/usr/bin/xcodebuild"+"\n\n\n"

            +"test_"+simpleName+".configuration=ADHoc\n"
            +"test_"+simpleName+".workspaceName=VideoGo.xcworkspace\n"
            +"test_"+simpleName+".scheme=Guarding Vision\n"
            +"test_"+simpleName+".codeSignIdentity="+"iPhone Distribution: "+AppTeamName+" ("+AppTeamID+")"+"\n"
            +"test_"+simpleName+".provisioningProfile="+ADHocUDID+"\n"
            +"test_"+simpleName+".exportOptionsPlist=-exportOptionsPlist VideoGo/SupportingFiles/LocalData/ADHocExportOptionsPlist.plist\n"
            +"test_"+simpleName+".bundleId="+BundleID[11:]+"\n"
            +"test_"+simpleName+".developeTeam="+AppTeamID+"\n"
            +"test_"+simpleName+".exportPath=../test/\n"
            +"test_"+simpleName+".log=../test.log\n"
            +"test_"+simpleName+".archivePath=../test/"+simpleName+".xcarchive\n"
            +"test_"+simpleName+".profileSpecifier="+projectName+"_ADHoc"+"\n"
            +"test_"+simpleName+".certificate=hc_certificate/"+simpleName+"/"+projectName+".p12"+"\n"
            +"test_"+simpleName+".mobileprovision=hc_certificate/"+simpleName+"/"+projectName+"_ADHoc.mobileprovision"+"\n"
            +"test_"+simpleName+".xcodebuild=/Applications/Xcode9.app/Contents/Developer/usr/bin/xcodebuild")
    f.close()

#    sourse = [ADHocPath,AppStorePath,InfoPath,targetPath+os.sep+projectName+'.p12']
#    target = targetPath + os.sep + simpleName+'.zip'
#    zip_command = "zip -qj -X \'{0}\' \'{1}\'". format(target, '\' \''.join(sourse))
#    os.system(zip_command)

def getBundleID(path):
    
    i = 0
    flag = False
    
    if os.path.exists(path):
        fInfoplist = open(path,'r+')
        flist = fInfoplist.readlines()
        
        for line in flist:
            if "<key>application-identifier</key>" in line:
                flag = True
                break
            
            i = i+1
    else:
        print "error:没有找到文件"
    
    if flag:
        BundleIDLine = flist[i+1]
        BundleIDStart = BundleIDLine.find('<string>')+8
        BundleIDEnd = BundleIDLine.find('</string>')
        BundleID = BundleIDLine[BundleIDStart:BundleIDEnd]
        return BundleID
    else:
        print "error:没有BundleID"

def getTeamID(path):
    
    i = 0
    flag = False
    
    if os.path.exists(path):
        fInfoplist = open(path,'r+')
        flist = fInfoplist.readlines()
        
        for line in flist:
            if "<key>com.apple.developer.team-identifier</key>" in line:
                flag = True
                break
            
            i = i+1
    else:
        print "error:没有找到文件"
    
    if flag:
        TeamIDLine = flist[i+1]
        TeamIDStart = TeamIDLine.find('<string>')+8
        TeamIDEnd = TeamIDLine.find('</string>')
        TeamID = TeamIDLine[TeamIDStart:TeamIDEnd]
        return TeamID
    else:
        print "error:没有TeamID"

def getTeamName(path):
   
    i = 0
    flag = False
    
    if os.path.exists(path):
        fInfoplist = open(path,'r+')
        flist = fInfoplist.readlines()
        
        for line in flist:
            if "<key>TeamName</key>" in line:
                flag = True
                break
            
            i = i+1
    else:
        print "error:没有找到文件"
    
    if flag:
        TeamNameLine = flist[i+1]
        TeamNameStart = TeamNameLine.find('<string>')+8
        TeamNameEnd = TeamNameLine.find('</string>')
        TeamName = TeamNameLine[TeamNameStart:TeamNameEnd]
        return TeamName
    else:
        print "error:没有TeamName"

def getUDID(path):
    
    i = 0
    flag = False
    
    if os.path.exists(path):
        fInfoplist = open(path,'r+')
        flist = fInfoplist.readlines()
        
        for line in flist:
            if "<key>UUID</key>" in line:
                flag = True
                break
            
            i = i+1
    else:
        print "error:没有找到文件"

    if flag:
        UDIDLine = flist[i+1]
        UDIDStart = UDIDLine.find('<string>')+8
        UDIDEnd = UDIDLine.find('</string>')
        UDID = UDIDLine[UDIDStart:UDIDEnd]
        return UDID
    else:
        print "error:没有UDID"


main()

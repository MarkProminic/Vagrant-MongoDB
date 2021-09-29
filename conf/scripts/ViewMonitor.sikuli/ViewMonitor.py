import unittest
import os
import sys
import logging
import traceback
import time
import smtplib
import shutil
from xmlrunner import *
from sikuli import *

cntr = 0
Debug.on(3)
try:
    jbuild = sys.argv[1]
except IndexError:
    jbuild = 'null'
Settings.UserLogs = True
Settings.UserLogTime = True
Settings.InfoLogs = True
Debug.user("Jenkins Build: " + jbuild )
setShowActions(True)
EdgeMatches  = False
ChromiumMatches  = False
FireFoxMatches  = False
IntelliJMatches  = False
viewApp = App("vmware-view -s desktop.prominic.work -u Mgilbert -p EK030791@!  -q --once  -n Prominic --desktopSize=full  --nomenubar")


##Close any old sessions so we do not get confused
if(App("Prominic").isRunning() == True):
  Debug.user("App found!"
)
  App("Prominic").close()
  if exists( "1623274459989.png" , 1):
    click( "1623274459989.png" )




##Open the Connection to the View Client and Verify the Screen Matches
viewApp.open()
sleep(10)
some_region = SCREEN 
screenshotsDir = "/backup/"
img = capture(some_region)
shutil.move(img, os.path.join(screenshotsDir, "some-name.png"))


if exists("1623320708763.png", 5):
  EdgeMatches  == True
  print("Desktop Matches!" )

App("Prominic").close()
if exists( "1623274459989.png" , 1):
  click( "1623274459989.png" )







class UnitTestA(unittest.TestCase):
    def testRunScript(self):
        self.assertTrue(True, "Empty succcess test")
        doInstall()
        try:
            doInstall()

        except Exception as e:
            self.assertTrue(False, str(e))
            popup(str(e))
    #def tearDown(self):
    #    popup("tearing things down")

tests = unittest.TestLoader().loadTestsFromTestCase(UnitTestA)
testResult = XMLTestRunner(file("unittest.xml", "w")).run(tests)
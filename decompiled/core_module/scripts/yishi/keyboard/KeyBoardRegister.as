package yishi.keyboard
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.GodDessManager;
   import map.campaign.CampaignManager;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import ui.maintoolbar.MainToolBar;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class KeyBoardRegister
   {
      
      private static var _instance:KeyBoardRegister;
      
      public var battleFlag:Boolean;
      
      private var _enableCount:int;
      
      public var functionEnable:Boolean = true;
      
      public var vehicleFlag:Boolean = false;
      
      private var _downKeys:Dictionary = new Dictionary(true);
      
      private var _leftFunction:Function;
      
      private var _rightFunction:Function;
      
      private var _topFunction:Function;
      
      private var _downFunction:Function;
      
      public function KeyBoardRegister()
      {
         super();
      }
      
      public static function get instance() : KeyBoardRegister
      {
         if(!_instance)
         {
            _instance = new KeyBoardRegister();
         }
         return _instance;
      }
      
      public function get keyEnable() : Boolean
      {
         return _enableCount >= 0;
      }
      
      public function set keyEnable(param1:Boolean) : void
      {
         param1 ? _enableCount++ : int(_enableCount--);
         _enableCount > 0 ? (_enableCount = 0) : _enableCount;
      }
      
      public function setup() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDownHandler);
         KeyboardManager.getInstance().addEventListener("keyUp",__keyUpHandler);
      }
      
      private function __keyUpHandler(param1:KeyboardEvent) : void
      {
         _downKeys[param1.keyCode] = false;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = _downKeys[param1.keyCode];
         var _loc4_:int = getTimer();
         if(_loc3_ && _loc3_.time)
         {
            _loc2_ = int(_loc3_.time);
            if(_loc4_ - _loc2_ < 30000)
            {
               return;
            }
         }
         _downKeys[param1.keyCode] = {"time":_loc4_};
         switch(param1.keyCode)
         {
            case KeyStroke.VK_L.getCode():
               showTask();
               break;
            case KeyStroke.VK_B.getCode():
               showEquip();
               break;
            case KeyStroke.VK_M.getCode():
               showMap();
               break;
            case KeyStroke.VK_F.getCode():
               showFriend();
               break;
            case KeyStroke.VK_G.getCode():
               showConsortia();
               break;
            case KeyStroke.VK_A.getCode():
               showPawn();
               break;
            case KeyStroke.VK_T.getCode():
               showStore();
               break;
            case KeyStroke.VK_O.getCode():
               showStop();
               break;
            case KeyStroke.VK_S.getCode():
               showSkill();
               break;
            case KeyStroke.VK_H.getCode():
               showStar();
               break;
            case KeyStroke.VK_ESCAPE.getCode():
               showSetting();
               break;
            case KeyStroke.VK_Z.getCode():
               showCampaign();
               break;
            case KeyStroke.VK_P.getCode():
               showMount();
               break;
            case KeyStroke.VK_I.getCode():
               if(ConfigManager.version_info.TAITAN_LOCK)
               {
                  showDragonTitan();
               }
               break;
            case KeyStroke.VK_Y.getCode():
               showPet();
               break;
            case KeyStroke.VK_Q.getCode():
               showInnerOrOuterCity();
               break;
            case KeyStroke.VK_R.getCode():
               showArchaeology();
               break;
            case KeyStroke.VK_C.getCode():
               showAncientArtifact();
               break;
            case KeyStroke.VK_N.getCode():
               showPetHallows();
               break;
            case KeyStroke.VK_U.getCode():
               showNursingSpirit();
               break;
            case KeyStroke.VK_D.getCode():
               showDragonTalker();
               break;
            case KeyStroke.VK_J.getCode():
               showGoddessFrame();
               break;
            case KeyStroke.VK_K.getCode():
               showMonsterFrame();
               break;
            case KeyStroke.VK_X.getCode():
               showAvengerFrame();
               break;
            case KeyStroke.VK_E.getCode():
               showThesesuolFrame();
               break;
            case KeyStroke.VK_F1.getCode():
               test();
         }
      }
      
      private function test() : void
      {
      }
      
      public function registerMapKey(param1:Function, param2:Function, param3:Function, param4:Function) : void
      {
         _leftFunction = param1;
         _rightFunction = param2;
         _topFunction = param3;
         _downFunction = param4;
         KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_LEFT,__leftKeyDownHandler);
         KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_RIGHT,__rightKeyDownHandler);
         KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_UP,__topKeyDownHandler);
         KeyboardManager.getInstance().registerKeyAction(KeyStroke.VK_DOWN,__downKeyDownHandler);
      }
      
      public function removeMapKey(param1:Function, param2:Function, param3:Function, param4:Function) : void
      {
         _leftFunction = null;
         _rightFunction = null;
         _topFunction = null;
         _downFunction = null;
         KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_LEFT,__leftKeyDownHandler);
         KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_RIGHT,__rightKeyDownHandler);
         KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_UP,__topKeyDownHandler);
         KeyboardManager.getInstance().unregisterKeyAction(KeyStroke.VK_DOWN,__downKeyDownHandler);
      }
      
      private function __leftKeyDownHandler() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!checkInputTxt() && _leftFunction != null)
         {
            _leftFunction();
         }
      }
      
      private function __rightKeyDownHandler() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!checkInputTxt() && _rightFunction != null)
         {
            _rightFunction();
         }
      }
      
      private function __topKeyDownHandler() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!checkInputTxt() && _topFunction != null)
         {
            _topFunction();
         }
      }
      
      private function __downKeyDownHandler() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!checkInputTxt() && _downFunction != null)
         {
            _downFunction();
         }
      }
      
      public function checkInputTxt() : Boolean
      {
         var _loc1_:TextField = StageReferance.stage.focus as TextField;
         if(_loc1_ && _loc1_.type == "input")
         {
            return true;
         }
         return false;
      }
      
      private function showEquip() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 15500)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
      }
      
      private function showSkill() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 19000)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL);
      }
      
      private function showPawn() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 22000)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         if(ArmyManager.instance.thane.grades >= 70)
         {
            ChildManager.instance.openChildFram();
         }
      }
      
      private function showStore() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 19000)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
      }
      
      private function showStop() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 10)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("shop");
      }
      
      private function showTask() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 11000)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("task");
      }
      
      private function showMap() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 16)
         {
            return;
         }
         if(CampaignManager.instance.mapModel && WorldBossHelper.checkPetLand(CampaignManager.instance.mapModel.mapId))
         {
            FrameControllerManager.instance.openControllerByInfo("space",3);
         }
         else if(CampaignManager.instance.mapModel && WorldBossHelper.checkMineral(CampaignManager.instance.mapModel.mapId))
         {
            FrameControllerManager.instance.openControllerByInfo("space",4);
         }
         else if(CampaignManager.instance.mapModel && WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapModel.mapId))
         {
            FrameControllerManager.instance.openControllerByInfo("space",7);
         }
         else
         {
            if(SceneManager.instance.currentType != "SPACE_SCENE")
            {
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("space");
         }
         SoundManager.instance.play("015",true);
      }
      
      private function showFriend() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 6)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.friendControler.startFrameByType(1);
      }
      
      private function showConsortia() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 13)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("consortia");
      }
      
      private function showStar() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < 18)
         {
            return;
         }
         SoundManager.instance.play("035",true);
         FrameControllerManager.instance.openControllerByInfo("star");
      }
      
      private function showSetting() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!Frame.hasOpenFrame)
         {
            SoundManager.instance.play("011",true);
            FrameControllerManager.instance.openControllerByInfo("setting");
         }
      }
      
      private function showCampaign() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(PlayerManager.instance.newbieProcess <= 23000)
         {
            return;
         }
         var _loc1_:String = SceneManager.instance.currentType;
         if(_loc1_ != "CASTLE_SCENE" && _loc1_ != "SPACE_SCENE")
         {
            return;
         }
         SoundManager.instance.play("035",true);
         FrameControllerManager.instance.openControllerByInfo("selectcampaign");
      }
      
      private function get mainToolBar() : MainToolBar
      {
         return MainToolBar.instance;
      }
      
      private function showInnerOrOuterCity() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(SceneManager.instance.lock == true)
         {
            return;
         }
         switch(SceneManager.instance.currentType)
         {
            case "CASTLE_SCENE":
               showOuterCity();
               break;
            case "OUTER_CITY_SCENE":
               showInnerCity();
               break;
            case "SPACE_SCENE":
               showOuterCity();
         }
      }
      
      private function showOuterCity() : void
      {
         SimpleAlertHelper.instance.data = [__showOuterCityResponse];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("yishi.keyboard.KeyBoardRegister.content01");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,false,false);
      }
      
      private function showInnerCity() : void
      {
         SimpleAlertHelper.instance.data = [__showInnerCityResponse];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("yishi.keyboard.KeyBoardRegister.content02");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,false,false);
      }
      
      private function __showOuterCityResponse(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            _loc3_ = WorldBossHelper.getCampaignTips();
            if(_loc3_ == "")
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.keyboard.KeyBoardRegister.command01");
            }
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(param1)
         {
            SceneManager.instance.setScene("OUTER_CITY_SCENE");
         }
      }
      
      private function __showInnerCityResponse(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(SceneManager.instance.currentType != "OUTER_CITY_SCENE")
         {
            _loc3_ = WorldBossHelper.getCampaignTips();
            if(_loc3_)
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.keyboard.KeyBoardRegister.command01");
            }
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(param1)
         {
            SceneManager.instance.setScene("CASTLE_SCENE");
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showMount() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(thane.grades < 40)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("mounts",1);
      }
      
      private function showDragonTitan() : void
      {
         if(ConfigManager.version_info.TAITAN_LOCK)
         {
            if(battleFlag)
            {
               return;
            }
            if(vehicleFlag)
            {
               return;
            }
            if(!keyEnable)
            {
               return;
            }
            if(!functionEnable)
            {
               return;
            }
            if(checkInputTxt())
            {
               return;
            }
            if(!thane.isChangeJob)
            {
               return;
            }
            SoundManager.instance.play("015",true);
            FrameControllerManager.instance.openControllerByInfo("dragontitan");
         }
      }
      
      private function showGoddessFrame() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!GodDessManager.instance.isOpen)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("goddess");
      }
      
      private function showPet() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(thane.grades < 50)
         {
            return;
         }
         if(!PlayerManager.instance.currentPlayerModel.petSystemIsOpened)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("pet");
      }
      
      private function showArchaeology() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(thane.grades < 15)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("archaeology");
      }
      
      private function showPetHallows() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!thane.isChangeJob)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("pethallows");
      }
      
      private function showAncientArtifact() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(thane.vocationGrades <= 0)
         {
            return;
         }
         if(!VersionSwitch.ANCIENTARTIFACT)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("ancientartifact");
      }
      
      private function showNursingSpirit() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!thane.isChangeJob)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit");
      }
      
      private function showDragonTalker() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         SoundManager.instance.play("015",true);
         SwitchPageHelp.openDragonTalkerFrame();
      }
      
      private function showMonsterFrame() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!VersionSwitch.MONSTER)
         {
            return;
         }
         if(thane.grades < 70)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("monster");
      }
      
      private function showAvengerFrame() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!VersionSwitch.AVENGER)
         {
            return;
         }
         if(!thane.isAvenger)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("avenger");
      }
      
      private function showProficiencyFrame() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!VersionSwitch.PROFICIENCY)
         {
            return;
         }
         if(!thane.isAvenger)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("proficiency");
      }
      
      private function showThesesuolFrame() : void
      {
         if(battleFlag)
         {
            return;
         }
         if(vehicleFlag)
         {
            return;
         }
         if(!keyEnable)
         {
            return;
         }
         if(!functionEnable)
         {
            return;
         }
         if(checkInputTxt())
         {
            return;
         }
         if(!VersionSwitch.THESESOUL)
         {
            return;
         }
         if(thane.vocationIndex <= 0)
         {
            return;
         }
         var _loc1_:Boolean = RoyaltyBossManager.instance.model.royaltyLevel > 0;
         if(!_loc1_)
         {
            return;
         }
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("theseussoul");
      }
   }
}


package managers
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.skillsys.helper.BloodHelper;
   import battle.view.battleresult.BaseBattleResultView;
   import battle.view.battleresult.FailedBattleResultViewSimple;
   import battle.view.battleresult.VicotyBattleResultViewSimple;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.battle.BattleViewMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.Event;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import mvc.module.battleView.BattleViewModel;
   import sandbox.SandboxManager;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.TimerUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class BattleViewManager
   {
      
      public static const CHECK_BATTLE_STATE:int = 0;
      
      public static const QUIT_OPERATION_TYPE:int = -1;
      
      public static const VIEW_ZS_OPERATION_TYPE:int = 1;
      
      public static const VIEW_TT_OPERATION_TYPE:int = 2;
      
      public static const FINAL_WARLORDS_OPERATION_TYPE:int = 101;
      
      public static const FINAL_MULTILORDS_OPERATION_TYPE:int = 102;
      
      public static const FINAL_MATELORDS_OPERATION_TYPE:int = 103;
      
      private static var _instance:BattleViewManager;
      
      private static var _closeFlg:Boolean = true;
      
      private var _curSceneType:String;
      
      private var _curCheckStateTimeStamp:int = 0;
      
      private var _curWarlordsTabIndex:int = -1;
      
      private var _model:BattleViewModel;
      
      private var _curCheckBattleArgs:Array;
      
      private var _curViewBattleArgs:Array;
      
      private const CLICK_THRESHOLD:uint = 300;
      
      public function BattleViewManager()
      {
         super();
         if(_closeFlg)
         {
            throw new Error("BattleViewManager is a singleton!");
         }
         init();
      }
      
      public static function get instance() : BattleViewManager
      {
         if(_instance == null)
         {
            _closeFlg = false;
            _instance = new BattleViewManager();
            _closeFlg = true;
         }
         return _instance;
      }
      
      private function init() : void
      {
         _model = new BattleViewModel();
      }
      
      public function setup() : void
      {
         if(!SocketManager.instance.hasEventListener((4803).toString()))
         {
            SocketManager.instance.listener(4803,onCloseBattleViewHandler);
         }
         if(!SocketManager.instance.hasEventListener((4804).toString()))
         {
            SocketManager.instance.listener(4804,onGetBattleInfoHandler);
         }
         if(!SocketManager.instance.hasEventListener((4806).toString()))
         {
            SocketManager.instance.listener(4806,onGetBattleViewListHandler);
         }
      }
      
      private function onGetBattleViewListHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = param1.type;
      }
      
      private function onGetBattleInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PropertyMsg;
         var _loc4_:int = _loc2_.param1 / 1000;
         var _loc3_:Boolean = _loc2_.param7;
         if(_loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.viewBattleViewListFrame.BattleOverTip"));
         }
         else if(_loc4_ <= 0)
         {
            sendOperationToServer.apply(null,_curViewBattleArgs);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("space",5,[_loc4_]);
         }
      }
      
      private function onCloseBattleViewHandler(param1:SLGSocketEvent) : void
      {
         var isNomalExit:Boolean;
         var loopCount:uint;
         var checkExecuteAbled:*;
         var finishBtn:IconButton;
         var event:SLGSocketEvent = param1;
         var pkg:PackageIn = event.data as PackageIn;
         var msg:PropertyMsg = new PropertyMsg();
         msg = pkg.readBody(msg) as PropertyMsg;
         var closeType:uint = uint(msg.param1);
         BattleManager.isExitingBattle = true;
         isNomalExit = msg.param7;
         if(PlayerManager.instance.loginState >= 0)
         {
            checkExecuteAbled = function():void
            {
               if(loopCount > 100 || BattleManager.getInstance().isAllSkillExecuted())
               {
                  exitBattleScene(closeType,isNomalExit);
               }
               else
               {
                  TimerUtils.setTimeout(checkExecuteAbled,30);
                  loopCount = loopCount + 1;
               }
            };
            checkExecuteAbled();
            loopCount = 0;
         }
         if(BattleManager.getInstance().battleUIView != null)
         {
            try
            {
               finishBtn = BattleManager.getInstance().battleUIView.finishNowBtn;
               if(finishBtn != null)
               {
                  finishBtn.enable = false;
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function exitBattleScene(param1:uint, param2:Boolean) : void
      {
         var isInBattleScene:Boolean;
         var resultView:BaseBattleResultView;
         var closeType:uint = param1;
         var isNomalExit:Boolean = param2;
         var toExitScene:* = function():void
         {
            NotificationManager.instance.dispatchEvent(new BattleEvent("battleCancel",null));
            BloodHelper.setup();
            if(BattleManager.getInstance().battleScene)
            {
               NotificationManager.instance.addEventListener("SCENE_SWITCH_CALL",function(param1:Event):void
               {
                  KeyBoardRegister.instance.battleFlag = false;
                  NotificationManager.instance.dispatchEvent(new BattleEvent("battleComplete",null));
                  NotificationManager.instance.removeEventListener("SCENE_SWITCH_CALL",arguments.callee);
                  toRecover(isNomalExit);
               });
            }
            else
            {
               NotificationManager.instance.dispatchEvent(new BattleEvent("battleComplete",null));
            }
            SceneManager.instance.lock = false;
            SceneManager.instance.setScene(_curSceneType,null,false,true);
            BattleManager.exitFlag = true;
            BattleManager.loginToBattleFlag = false;
         };
         BattleManager.getInstance().battleModel.isOver = true;
         SoundManager.instance.stopMusic();
         isInBattleScene = BattleManager.getInstance().battleScene ? true : false;
         if(isInBattleScene)
         {
            if(closeType == 1)
            {
               SoundManager.instance.play("033");
               resultView = new VicotyBattleResultViewSimple();
            }
            else if(closeType == 2)
            {
               resultView = new FailedBattleResultViewSimple();
            }
            else
            {
               toExitScene();
            }
            if(resultView != null)
            {
               resultView.autoCloseFun = toExitScene;
               resultView.show();
            }
         }
         else
         {
            toExitScene();
         }
      }
      
      private function toRecover(param1:Boolean) : void
      {
         if(_curViewBattleArgs != null)
         {
            var _loc2_:* = _curViewBattleArgs[0];
         }
         if(param1 && _curCheckBattleArgs != null)
         {
            sendOperationToServer.apply(null,_curCheckBattleArgs);
         }
      }
      
      public function sendOperationToServer(param1:int, param2:String = "", param3:int = 0, param4:String = "", param5:int = -1) : void
      {
         var _loc9_:PackageOut = null;
         var _loc7_:BattleViewMsg = null;
         var _loc10_:Boolean = param1 == 0;
         var _loc8_:int = getTimer();
         if(_loc10_ && _loc8_ - _curCheckStateTimeStamp < 300)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
         }
         else
         {
            _loc9_ = new PackageOut(8985);
            _loc7_ = new BattleViewMsg();
            if(param1 == -1)
            {
               _loc7_.type = param1;
            }
            else
            {
               _loc7_.type = param1;
               if(_loc10_)
               {
                  _curSceneType = SceneManager.instance.currentType;
                  _curCheckStateTimeStamp = _loc8_;
                  _curCheckBattleArgs = arguments;
                  _loc7_.sonType = param5;
                  _curViewBattleArgs = [param5,param2,param3,param4];
                  param1 = param5;
               }
               switch(param1 - 1)
               {
                  case 0:
                     _loc7_.userId = param3;
                     _loc7_.serverName = param4;
                     break;
                  case 1:
                     _loc7_.teamUuid = param2;
               }
            }
            SocketManager.instance.socket.sendProtobuffer(_loc9_,_loc7_);
         }
      }
      
      public function CDFinishHanlder() : void
      {
         sendOperationToServer.apply(null,_curViewBattleArgs);
      }
      
      public function set curWarlordsTabIndex(param1:int) : void
      {
         _curWarlordsTabIndex = param1;
      }
      
      public function checkCanViewBattle() : Boolean
      {
         var _loc1_:Boolean = true;
         var _loc4_:Boolean = !CampaignManager.instance.exit && CampaignManager.instance.mapModel;
         var _loc3_:Boolean = FreedomTeamManager.instance.hasTeam || GroupfbManager.instance.model.hasGroupTeam;
         var _loc2_:Boolean = !SandboxManager.instance.exit;
         if(_loc3_)
         {
            _loc1_ = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.WarlordsManager.str04"));
         }
         if(_loc4_)
         {
            _loc1_ = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.viewBattleViewListFrame.sceneTip"));
         }
         if(_loc2_)
         {
            _loc1_ = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.viewBattleViewListFrame.sceneTip"));
         }
         return _loc1_;
      }
   }
}


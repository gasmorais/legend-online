package mvc.controler
{
   import battle.BattleManager;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.BattleModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardControler extends FrameController
   {
      
      public var selectSenior:int;
      
      public var _isOutyardMapApply:Boolean = false;
      
      public var openOutyardMap6:Boolean = false;
      
      public var _isEnterTitanBattle:Boolean = false;
      
      private var _index:int;
      
      public function OutyardControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "outyard.OutyardMemberFrame";
         }
         if(_data.openType == 2)
         {
            return "outyard.OutyardBlessFrame";
         }
         if(_data.openType == 3)
         {
            return "outyard.scene.OutyardMapFrame";
         }
         if(_data.openType == 4)
         {
            return "outyard.event.OutyardEventFrame";
         }
         if(_data.openType == 5)
         {
            return "outyard.shuttle.OutyardArcaneFrame";
         }
         if(_data.openType == 6)
         {
            return "outyard.shuttle.OutyardShuttleFightPetFrame";
         }
         if(_data.openType == 7)
         {
            return "abysm.AbysmFrame";
         }
         if(_data.openType == 8)
         {
            return "childabysm.ChildAbysmFormationFrame";
         }
         if(_data.openType == 9)
         {
            return "outyard.titan.OutyardTitanFrame";
         }
         if(_data.openType == 10)
         {
            return "outyard.shuttle.OutyardShuttleFrame";
         }
         if(_data.openType == 11)
         {
            return "abysm.HellAbysmFrame";
         }
         return "outyard.OutyardFrame";
      }
      
      public function refreshBtnClick(param1:int) : void
      {
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var confirm1:String;
         var cancel1:String;
         var prompt1:String;
         var content1:String;
         var confirm2:String;
         var cancel2:String;
         var prompt2:String;
         var content2:String;
         var checkTxt:String;
         var content3:String;
         var payCallBack:*;
         var index:int = param1;
         _index = index;
         var resetArr:Array = ConfigInfoManager.instance.getShuttleReset();
         var freeCount:int = ConfigInfoManager.instance.getShuttleResetFree();
         var shuttleMsg:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         var resetNeedStone:int = int(resetArr[1]);
         if(isFreeCount)
         {
            if(!hasReceived)
            {
               if(_index > 0)
               {
                  SimpleAlertHelper.instance.data = [diffResponse];
               }
               else
               {
                  SimpleAlertHelper.instance.data = [resetResponse];
               }
               confirm = LanguageMgr.GetTranslation("public.confirm");
               cancel = LanguageMgr.GetTranslation("public.cancel");
               prompt = LanguageMgr.GetTranslation("public.prompt");
               content = LanguageMgr.GetTranslation("outyard.OutyardLevelItem.clickContent1");
               SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,true,false,false,2);
            }
            else
            {
               if(_index > 0)
               {
                  SimpleAlertHelper.instance.data = [diffResponse];
               }
               else
               {
                  SimpleAlertHelper.instance.data = [resetResponse];
               }
               confirm1 = LanguageMgr.GetTranslation("public.confirm");
               cancel1 = LanguageMgr.GetTranslation("public.cancel");
               prompt1 = LanguageMgr.GetTranslation("public.prompt");
               content1 = LanguageMgr.GetTranslation("outyard.OutyardLevelItem.clickContent2");
               SimpleAlertHelper.instance.popAlerFrame(prompt1,content1,confirm1,cancel1,true,false,false,2);
            }
         }
         else if(!hasReceived)
         {
            if(_index > 0)
            {
               SimpleAlertHelper.instance.data = [diffResponse];
            }
            else
            {
               SimpleAlertHelper.instance.data = [resetResponse];
            }
            confirm2 = LanguageMgr.GetTranslation("public.confirm");
            cancel2 = LanguageMgr.GetTranslation("public.cancel");
            prompt2 = LanguageMgr.GetTranslation("public.prompt");
            content2 = LanguageMgr.GetTranslation("outyard.OutyardLevelItem.clickContent1");
            SimpleAlertHelper.instance.popAlerFrame(prompt2,content2,confirm2,cancel2,true,false,false,2);
         }
         else
         {
            payCallBack = function():void
            {
               if(resetNeedStone > PlayerManager.instance.currentPlayerModel.playerInfo.point)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               if(_index > 0)
               {
                  diffResponse(true,true);
               }
               else
               {
                  resetResponse(true,true);
               }
            };
            if(shuttleMsg.resetCount >= freeCount + resetArr[0])
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardShuttleView.ResetMax"));
               return;
            }
            SoundManager.instance.play("022");
            checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            content3 = LanguageMgr.GetTranslation("outyard.OutyardShuttleView.addResetTxt",resetNeedStone,1);
            SharedManagerHelper.ins.needAlert("outyard.OutyardShuttleView.ResetAlert",payCallBack,checkTxt,content3);
         }
      }
      
      private function resetResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateShuttle(6);
         }
      }
      
      private function diffResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateShuttle(5,0,_index,0);
         }
      }
      
      private function get isFreeCount() : Boolean
      {
         var _loc2_:int = ConfigInfoManager.instance.getShuttleResetFree();
         var _loc3_:Array = ConfigInfoManager.instance.getShuttleReset();
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_loc1_)
         {
            return false;
         }
         return _loc2_ > _loc1_.resetCount;
      }
      
      private function get hasReceived() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.rewardState.length)
         {
            if(_loc1_.rewardState[_loc2_] == 1)
            {
               _loc3_ = true;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function set isOutyardMapApply(param1:Boolean) : void
      {
         _isOutyardMapApply = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_CHANNEL_CHANGE"));
      }
      
      public function get isOutyardMapApply() : Boolean
      {
         if(isInOutyardBattle)
         {
            return true;
         }
         return _isOutyardMapApply;
      }
      
      public function get isInOutyardBattle() : Boolean
      {
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc1_)
         {
            return false;
         }
         if(_loc1_.battleType == 3855 || _loc1_.battleType == 3858 || _loc1_.battleType == 3857)
         {
            return true;
         }
         return false;
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}


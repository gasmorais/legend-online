package war2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import war2023.item.SecretwarOpentimeItem;
   import war2023.ui.SecretWarEnterUI;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretWarEnterView extends SecretWarEnterUI
   {
      
      private var _openTimeVbox:VBox;
      
      private var _rewardTimeTxt:GradientText;
      
      private var _endCd:TimeDownView;
      
      private var _maxReward:int = 2;
      
      private var _endDate:Date;
      
      private const LAST_OVER_CD:int = 300000;
      
      public function SecretWarEnterView()
      {
         super();
         init();
         initEvent();
         updateBtnHandler();
         SecretWarManager.Instance.gameOp(0);
      }
      
      private function init() : void
      {
         var _loc12_:Array = null;
         var _loc6_:Array = null;
         var _loc9_:String = null;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:String = null;
         var _loc3_:SecretwarOpentimeItem = null;
         var _loc2_:Date = null;
         var _loc5_:Array = null;
         var _loc14_:Array = null;
         var _loc8_:* = 0;
         var _loc4_:Array = null;
         var _loc13_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secret_war_max_reward");
         if(_loc13_)
         {
            _maxReward = int(_loc13_.ConfigValue);
         }
         _rewardTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.rewardTimeGt");
         addChild(_rewardTimeTxt);
         _endCd = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.enterTimeCd");
         addChild(_endCd);
         _openTimeVbox = ComponentFactory.Instance.creatCustomObject("ui.secretwar.openTimeVbox");
         addChild(_openTimeVbox);
         var _loc10_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secret_war_open_time");
         var _loc15_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secret_war_keep_time");
         if(_loc10_ && _loc15_)
         {
            _openTimeVbox.beginChanges();
            _loc12_ = _loc10_.ConfigValue.split("|");
            _loc6_ = _loc15_.ConfigValue.split(",");
            _loc9_ = "";
            _loc7_ = 0;
            _loc11_ = int(_loc12_.length);
            _loc2_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            _loc14_ = [];
            if(_loc11_ <= 2)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc11_)
               {
                  _loc3_ = new SecretwarOpentimeItem();
                  _loc1_ = getLastTArr(_loc12_[_loc7_],int(_loc6_[1]));
                  _loc9_ = _loc12_[_loc7_] + "-" + _loc1_;
                  _loc14_.push([_loc9_,_loc3_]);
                  _loc7_++;
               }
            }
            else
            {
               _loc7_ = _loc11_ - 1;
               while(_loc7_ >= 0)
               {
                  _loc5_ = getTimeStr(_loc12_[_loc7_]);
                  if(_loc2_.hours >= _loc5_[0])
                  {
                     break;
                  }
                  _loc7_--;
               }
               if(_loc7_ <= -1)
               {
                  _loc7_ = 0;
                  while(_loc7_ < 2)
                  {
                     _loc3_ = new SecretwarOpentimeItem();
                     _loc1_ = getLastTArr(_loc12_[_loc7_],int(_loc6_[1]));
                     _loc9_ = _loc12_[_loc7_] + "-" + _loc1_;
                     _loc14_.push([_loc9_,_loc3_]);
                     _loc7_++;
                  }
               }
               else
               {
                  if(_loc7_ == _loc11_ - 1)
                  {
                     _loc7_--;
                  }
                  _loc8_ = _loc7_;
                  while(_loc8_ < _loc7_ + 2)
                  {
                     _loc3_ = new SecretwarOpentimeItem();
                     _loc1_ = getLastTArr(_loc12_[_loc8_],int(_loc6_[1]));
                     _loc9_ = _loc12_[_loc8_] + "-" + _loc1_;
                     _loc14_.push([_loc9_,_loc3_]);
                     _loc8_++;
                  }
               }
            }
            _loc7_ = 0;
            while(_loc7_ < _loc14_.length)
            {
               _loc4_ = _loc14_[_loc7_];
               _loc3_ = _loc4_[1];
               _loc3_.setText(_loc4_[0]);
               _openTimeVbox.addChild(_loc3_);
               _loc7_++;
            }
            _openTimeVbox.commitChanges();
            _overtimeFt.y = _openTimeVbox.y + _openTimeVbox.height + 3;
            _endCd.y = _overtimeFt.y;
            _enterTxtBg.height = _overtimeFt.y + 20;
         }
      }
      
      private function getTimeStr(param1:String) : Array
      {
         var _loc4_:int = param1.indexOf(":");
         var _loc2_:int = int(param1.substring(0,_loc4_));
         var _loc3_:int = int(param1.substring(_loc4_ + 1));
         return [_loc2_,_loc3_];
      }
      
      private function getLastTArr(param1:String, param2:int) : String
      {
         var _loc6_:int = param1.indexOf(":");
         var _loc4_:int = int(param1.substring(0,_loc6_));
         var _loc5_:int = int(param1.substring(_loc6_ + 1));
         var _loc3_:int = _loc5_ + param2;
         if(_loc3_ >= 60)
         {
            _loc4_ += 1;
         }
         return _loc4_ + ":" + _loc3_;
      }
      
      private function initEvent() : void
      {
         _enterBtn.addEventListener("click",enterHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",updateBtnHandler);
         NotificationManager.instance.addEventListener("secretwarRewardEvent",rewardChangeHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _enterBtn.removeEventListener("click",enterHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",updateBtnHandler);
         NotificationManager.instance.removeEventListener("secretwarRewardEvent",rewardChangeHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
      }
      
      private function updateBtnHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = Boolean(SecretWarManager.Instance.isOpen);
         _enterBtn.enable = _loc3_;
         if(_loc3_)
         {
            _endCd.visible = true;
            _overtimeFt.visible = true;
            _endDate = DateFormatter.parse(SecretWarManager.Instance.stopTime,"YYYY-MM-DD hh:mm:ss");
            _loc2_ = (_endDate.time - PlayerManager.instance.currentPlayerModel.nowDate) / 1000;
            if(_loc2_ > 0)
            {
               _endCd.timeCount = _loc2_;
            }
            else
            {
               _endCd.timeCount = 0;
            }
         }
         else
         {
            _overtimeFt.visible = false;
            _endCd.visible = false;
         }
      }
      
      private function rewardChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _maxReward - SecretWarManager.Instance.rewardCount;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         _rewardTimeTxt.text = LanguageMgr.GetTranslation("secretwar.rewardTime",_loc2_,_maxReward);
      }
      
      private function enterHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = _endDate.time - 300000 - PlayerManager.instance.currentPlayerModel.nowDate;
         if(_endDate && _loc4_ < 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.forbidenTip"));
            return;
         }
         if(SecretWarManager.Instance.rewardCount >= _maxReward)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("secretwar.noRewardEnterTip");
            SimpleAlertHelper.instance.data = [__alertResponse];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,true);
         }
         else
         {
            SecretWarManager.Instance.gameOp(1);
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            SecretWarManager.Instance.gameOp(1);
         }
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("secretwar",5);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_endCd);
         _endCd = null;
         ObjectUtils.disposeObject(_rewardTimeTxt);
         _rewardTimeTxt = null;
         ObjectUtils.disposeObject(_openTimeVbox);
         _openTimeVbox = null;
         super.dispose();
         _endDate = null;
      }
   }
}


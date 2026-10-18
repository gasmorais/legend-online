package ui.queuebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.activitydaily.ActivityDailyRspMsg;
   import events.ChildPatrolEvent;
   import events.DayGuideEvent;
   import events.PlanesWarEvent;
   import events.QueueBarEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import managers.DayGuideManager;
   import managers.NewActiveLeedManager;
   import managers.PetChallengeManager;
   import managers.TimeVortexManager;
   import managers.VIPManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.dayGuide.DayGuideCatecory;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.QueueBarManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class QueueItem extends Sprite implements Disposeable
   {
      
      public static const QUEUE_TYPE_NULL:int = 0;
      
      public static const QUEUE_TYPE_BUILD:int = 1;
      
      public static const QUEUE_TYPE_TEC:int = 2;
      
      public static const QUEUE_TYPE_ALCHEMY:int = 3;
      
      public static const QUEUE_TYPE_COLOSSEUM:int = 4;
      
      public static const QUEUE_TYPE_ACTIVE:int = 5;
      
      public static const QUEUE_TYPE_PET:int = 6;
      
      public static const QUEUE_TYPE_PLANES:int = 7;
      
      public static const QUEUE_TYPE_CHILDPATROL:int = 8;
      
      public static const QUEUE_TYPE_ACTIVEORDER:int = 9;
      
      public static const QUEUE_TYPE_SIGN_DAY:int = 10;
      
      public static const QUEUE_TYPE_TIMEVORTEX:int = 11;
      
      protected var _back:Scale9CornerImage;
      
      protected var _button:BaseButton;
      
      protected var _title:FilterFrameText;
      
      protected var _time:FilterFrameText;
      
      protected var _data:BuildingOrderInfo;
      
      protected var _getReward:FilterFrameText;
      
      protected var _getMask:Sprite;
      
      protected var _effect:MovieClip;
      
      public var type:int;
      
      private var _timeId:int;
      
      public function QueueItem()
      {
         super();
         initView();
         initEvent();
         this.x = 5;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ItemBack1");
         _button = ComponentFactory.Instance.creatComponentByStylename("queueBar.StartBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("queueBar.TitText");
         _time = ComponentFactory.Instance.creatComponentByStylename("queueBar.TimeText");
         _getReward = ComponentFactory.Instance.creatComponentByStylename("queueBar.GetRewardText");
         _effect = ComponentFactory.Instance.creatCustomObject("queueBar.ItemMc");
         _effect["pos"].addChild(_back);
         _effect["pos"].addChild(_title);
         _effect["pos"].addChild(_time);
         _effect["pos"].y = 0;
         _effect.gotoAndStop(1);
         addChild(_effect);
         _back.visible = false;
         _button.tipData = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QuickText");
         _getReward.text = LanguageMgr.GetTranslation("ui.queuebar.view.QueueItem.getReward.text1");
         _getMask = new Sprite();
         _getMask.x = _getReward.x;
         _getMask.y = _getReward.y;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         if(_button)
         {
            _button.addEventListener("click",__clickHandler);
         }
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PLAYER_INFO_UPDATE",__updateQueueMonoply);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("VOCATION_GRADES",__playerVocationUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         if(_data)
         {
            _data.removeEventListener("complete",__completeHandler);
            _data.removeEventListener("change",__changeHandler);
         }
         if(_button)
         {
            _button.removeEventListener("click",__clickHandler);
         }
         _getMask.removeEventListener("click",__getRewardHandler);
         dayGuideCate.removeEventListener("ExtractTimes_CHANGE",__activeChangeHandler);
         dayGuideCate.removeEventListener("ACTIVE_CHANGE",__activeChangeHandler);
         dayGuideCate.removeEventListener("LEED_PROGRESS_CHANGE",__activeChangeHandler);
         PlanesWarManager.instance.removeEventListener("UPDATE_QUEUE_ENERGY",__updateQueueEnergy);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__updateQueueMonoply);
         ChildPatrolManager.instance.removeEventListener("UPDATE_QUEUE_CHILDPATROL_TOWER",__updateQueueChildPatrolCount);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("VOCATION_GRADES",__playerVocationUpdate);
      }
      
      private function __playerVocationUpdate(param1:PlayerEvent) : void
      {
         updateView();
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         _back.visible = true;
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _back.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc5_:Function = null;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc10_:String = null;
         var _loc7_:VipCoolDownFrame = null;
         SoundManager.instance.play("022");
         stopEffect();
         param1.stopPropagation();
         var _loc4_:Array = TempleteManager.instance.getConfigInfoByConfigName("Challenge_Cool").ConfigValue.split(",");
         var _loc6_:Array = TempleteManager.instance.getConfigInfoByConfigName("Quick_Cool").ConfigValue.split(",");
         if(_data.remainTime > 0)
         {
            if(isActiveOrderid && data.orderId == 6)
            {
               _loc5_ = coolColosseBack;
            }
            if(isActiveOrderid && data.orderId == 5)
            {
               _loc5_ = coolColosseBackPet;
            }
            if(isChallengeAndChallengePet)
            {
               _loc9_ = Math.ceil(_data.remainTime / (60 * _loc4_[1])) * _loc4_[0];
            }
            if(VIPManager.Instance.model.vipCoolPrivilege)
            {
               _loc5_(true,_data.orderId);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.prompt");
               _loc10_ = LanguageMgr.GetTranslation("mainBar.SeminaryFrameRightView.content",_loc9_);
               _loc7_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
               _loc7_.initData(_loc8_,_loc10_,_data.orderId,_loc9_,_loc9_,_loc5_,_loc2_,_loc3_);
               _loc7_.show();
            }
         }
      }
      
      private function get isChallengeAndChallengePet() : Boolean
      {
         if(isActiveOrderid && (data.orderId == 6 || data.orderId == 5))
         {
            return true;
         }
         return false;
      }
      
      private function get isActiveOrderid() : Boolean
      {
         if(data.orderType == 4)
         {
            return true;
         }
         return false;
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendCoolColosseun(param3,param4);
         }
      }
      
      private function coolColosseBackPet(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            PetChallengeManager.instance.coolDownChallengeCD(param4);
         }
      }
      
      private function __completeHandler(param1:Event) : void
      {
         stopEffect();
         if(isChallengeAndChallengePet)
         {
            updateView();
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         updateView();
      }
      
      public function set data(param1:BuildingOrderInfo) : void
      {
         if(_data)
         {
            _data.removeEventListener("complete",__completeHandler);
            _data.removeEventListener("change",__changeHandler);
            if(_data.orderId == 2)
            {
               QueueBarManager.instance.removeEventListener("OFFER_REWARD_FRAME_CLOSE",__offerRewardFrameClose);
            }
         }
         _data = param1;
         if(_data)
         {
            _data.addEventListener("complete",__completeHandler);
            _data.addEventListener("change",__changeHandler);
            if(_data.orderId == 2)
            {
               QueueBarManager.instance.addEventListener("OFFER_REWARD_FRAME_CLOSE",__offerRewardFrameClose);
            }
         }
         updateView();
      }
      
      public function get data() : BuildingOrderInfo
      {
         return _data;
      }
      
      protected function updateView() : void
      {
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:ConfigInfosTempInfo = null;
         buttonMode = false;
         if(_button && _button.parent)
         {
            _button.parent.removeChild(_button);
         }
         _time.setFrame(2);
         _time.text = "";
         switch(type - 5)
         {
            case 0:
               buttonMode = true;
               setGetMask();
               break;
            case 4:
               switch(data.orderId - 1)
               {
                  case 0:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_CONSORTIA_ALTAR",data.currentCount,data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 1:
                     _loc5_ = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_OFFER_REWARD",data.currentCount,data.totalCount);
                     updateTxt(_loc5_,_loc5_);
                     buttonMode = true;
                     break;
                  case 2:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_OUTYARD",data.currentCount,data.totalCount);
                     if(data.currentCount > 0)
                     {
                        _title.setFrame(2);
                     }
                     else
                     {
                        _title.setFrame(3);
                     }
                     buttonMode = true;
                     break;
                  case 3:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_NAVIGATION",data.currentCount,data.totalCount);
                     if(data.currentCount > 0)
                     {
                        _title.setFrame(2);
                     }
                     else
                     {
                        _title.setFrame(3);
                     }
                     buttonMode = true;
                     break;
                  case 4:
                     _loc5_ = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_PET_CHALLENGE",data.currentCount,data.totalCount);
                     updateTxt(_loc5_,_loc5_);
                     buttonMode = true;
                     break;
                  case 5:
                     buttonMode = true;
                     if(_data.remainCount > 0)
                     {
                        _loc5_ = LanguageMgr.GetTranslation("mainBar.view.QueueItem.COLOSSEUM");
                        _loc1_ = _loc5_ + " " + _data.remainCount + "/" + _data.totalCount;
                     }
                     else if(_data.remainBuyCount > 0)
                     {
                        _loc5_ = LanguageMgr.GetTranslation("mainBar.view.QueueItem.COLOSSEUM2");
                        _loc1_ = _loc5_ + " " + _data.remainBuyCount + "/" + _data.totalBuyCount;
                     }
                     else
                     {
                        _loc1_ = LanguageMgr.GetTranslation("mainBar.view.QueueItem.COLOSSEUM1");
                        buttonMode = false;
                     }
                     updateTxt(_loc1_,_loc1_);
                     break;
                  case 6:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_CHILD_PVE",_data.currentCount,_data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 7:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_SKY_BOX_ROAD",_data.currentCount,_data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 8:
                     _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyMaxCount;
                     _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyCount;
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_MULTI_COPY",_loc2_,_loc4_);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 9:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_ARCHAEOLOGY",_data.currentCount,_data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 10:
                     ChildPatrolManager.instance.addEventListener("UPDATE_QUEUE_CHILDPATROL_TOWER",__updateQueueChildPatrolCount);
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.CHILDPATROL",childPatrolModel.idleTowerCount,childPatrolModel.totalTowerCount);
                     if(childPatrolModel.idleTowerCount > 0)
                     {
                        _title.setFrame(2);
                     }
                     else
                     {
                        _title.setFrame(3);
                     }
                     buttonMode = true;
                     break;
                  case 11:
                     PlanesWarManager.instance.addEventListener("UPDATE_QUEUE_ENERGY",__updateQueueEnergy);
                     _loc6_ = TempleteManager.instance.getConfigInfoByConfigName("planes_max_recover_energy");
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.PLANES",PlanesWarManager.instance.model.energyLeft,_loc6_.ConfigValue);
                     if(PlanesWarManager.instance.model.energyLeft > 0)
                     {
                        _title.setFrame(2);
                     }
                     else
                     {
                        _title.setFrame(3);
                     }
                     buttonMode = true;
                     break;
                  case 12:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_OUTYARD_EXPLORE",data.currentCount,data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 13:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.GLORY_ROAD",data.currentCount,data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 14:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_OUTYARD_SHUTTLE",data.currentCount,data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
                     break;
                  case 15:
                     _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.SPIRIT_EXPEDITION",data.currentCount,data.totalCount);
                     _title.setFrame(2);
                     buttonMode = true;
               }
               break;
            case 5:
               _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QUEUE_TYPE_SIGN_DAY");
               _title.setFrame(1);
               buttonMode = true;
               break;
            case 6:
               PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PLAYER_INFO_UPDATE",__updateQueueMonoply);
               _loc7_ = TimeVortexManager.instance.model.challengeMax - PlayerManager.instance.currentPlayerModel.playerInfo.timeVortexCount;
               if(_loc7_ <= 0)
               {
                  _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.TimeVortex02");
               }
               else
               {
                  _title.text = LanguageMgr.GetTranslation("mainBar.view.QueueItem.TimeVortex01",_loc7_,TimeVortexManager.instance.model.challengeMax);
               }
               _title.setFrame(2);
               buttonMode = true;
         }
         _back.width = _title.width - 5;
         _back.height = _title.height + 25;
      }
      
      protected function updateTxt(param1:String, param2:String) : void
      {
         if(_data && int(_data.remainTime) <= 0)
         {
            if(_button && _button.parent)
            {
               _button.parent.removeChild(_button);
            }
            _title.setFrame(2);
            _title.text = param1;
            _time.setFrame(2);
            _time.text = "";
         }
         else
         {
            if(_effect && _button && isChallengeAndChallengePet)
            {
               _effect["pos"].addChild(_button);
            }
            _title.setFrame(3);
            _title.text = param2;
            _time.setFrame(3);
            _time.text = DateFormatter.getCountDate(_data.remainTime);
         }
      }
      
      protected function setGetMask() : void
      {
         MsgMan.addObserver("NEW_ACTIVELEED_UPDATE",this,__updateNewActiveLeedHandler);
         var _loc4_:int = 1;
         if(thane.vocationGrades > 0)
         {
            _loc4_ = 2;
         }
         if(thane.isChangeJob)
         {
            _loc4_ = 3;
         }
         _title.htmlText = LanguageMgr.GetTranslation("ui.queuebar.view.QueueItem.activeTxt2_" + _loc4_);
         _title.setFrame(1);
         var _loc5_:SimpleDictionary = TempleteManager.instance.newActiveLeedDailyCate.getDropGoods(_loc4_);
         var _loc2_:Array = _loc5_.slice();
         _loc2_.sortOn("key",16);
         var _loc3_:Object = _loc2_[_loc2_.length - 1];
         var _loc6_:int = int(_loc3_.key);
         var _loc1_:ActivityDailyRspMsg = model.dailyArr[_loc4_];
         if(_loc1_)
         {
            if(_loc1_.totalNum < _loc6_)
            {
               _title.htmlText = LanguageMgr.GetTranslation("ui.queuebar.view.QueueItem.activeTxt1_" + _loc4_,_loc1_.totalNum,_loc6_);
            }
         }
      }
      
      private function __updateNewActiveLeedHandler(param1:String, param2:Object) : void
      {
         updateView();
      }
      
      private function get model() : NewActiveLeedModel
      {
         return NewActiveLeedManager.instance.model;
      }
      
      private function nextActive(param1:int) : int
      {
         if(param1 < 100)
         {
            return 100;
         }
         if(param1 < 150)
         {
            return 150;
         }
         if(param1 < 200)
         {
            return 200;
         }
         if(param1 < 250)
         {
            return 250;
         }
         if(param1 <= 300)
         {
            return 300;
         }
         return 0;
      }
      
      protected function __getRewardHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         FrameControllerManager.instance.openControllerByInfo("newactiveleed");
      }
      
      private function __activeChangeHandler(param1:DayGuideEvent) : void
      {
         updateView();
      }
      
      private function __updateQueueEnergy(param1:PlanesWarEvent) : void
      {
         updateView();
      }
      
      private function __updateQueueChildPatrolCount(param1:ChildPatrolEvent) : void
      {
         updateView();
      }
      
      private function __updateQueueMonoply(param1:PlayerEvent) : void
      {
         updateView();
      }
      
      private function __offerRewardFrameClose(param1:QueueBarEvent) : void
      {
         data.remainTime = QueueBarManager.instance.getRefreshRemainTime(data.beginTime);
      }
      
      public function playEffect() : void
      {
         _effect.play();
         _timeId = setTimeout(stopEffect,3000);
      }
      
      public function stopEffect() : void
      {
         clearTimeout(_timeId);
         if(_effect)
         {
            _effect.gotoAndStop(1);
         }
      }
      
      private function get dayGuideCate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      private function get childPatrolModel() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_button);
         _button = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         _getMask = null;
         ObjectUtils.disposeObject(_getReward);
         _getReward = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


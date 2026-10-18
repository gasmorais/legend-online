package offerreward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MagicSpringManager;
   import managers.OfferRewardManager;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import ui.gameroll.TaskGainMovie;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OfferTaskItem extends Sprite implements Disposeable
   {
      
      public var rewardPos:int;
      
      private var _bg:Image;
      
      private var _taskIcon:Bitmap;
      
      private var _rewardImg:Bitmap;
      
      private var _expIcon:Bitmap;
      
      private var _goldIcon:Bitmap;
      
      private var _taskTitle:FilterFrameText;
      
      private var _taskContent:FilterFrameText;
      
      private var _expValue:FilterFrameText;
      
      private var _goldValue:FilterFrameText;
      
      private var _acceptBtn:IconButton;
      
      private var _completedBtn:IconButton;
      
      private var _quickBtn:IconButton;
      
      private var _warningImage:Bitmap;
      
      private var _giveUp:FilterFrameText;
      
      private var _bufferText:FilterFrameText;
      
      private var msInfo:MagicSpringSlotInfo;
      
      private var _data:OfferRewardTemplate;
      
      private var _profile:int;
      
      private var _state:int;
      
      private var _hitSprite:Sprite;
      
      public function OfferTaskItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("offerReward.TaskItemBg");
         _taskIcon = ComponentFactory.Instance.creatBitmap("asset.offerReward.TaskIcon");
         _rewardImg = ComponentFactory.Instance.creatBitmap("asset.offerReward.RewardImg");
         _expIcon = ComponentFactory.Instance.creatBitmap("asset.offerReward.ExpIcon");
         _goldIcon = ComponentFactory.Instance.creatBitmap("asset.offerReward.GoldIcon");
         _taskTitle = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskTitle");
         _taskContent = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskContent");
         _expValue = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskExpValueTxt");
         _goldValue = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskGoldValueTxt");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskAcceptBtn");
         _completedBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskCompletedBtn");
         _quickBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferTaskQuickBtnBtn");
         _warningImage = ComponentFactory.Instance.creatBitmap("asset.offerReward.warningImage");
         _giveUp = ComponentFactory.Instance.creatComponentByStylename("offerReward.GiveBackText");
         _bufferText = ComponentFactory.Instance.creatComponentByStylename("offerRewardItem.bufferText");
         _completedBtn.enable = false;
         _giveUp.text = LanguageMgr.GetTranslation("offerreward.view.OfferTaskItem.giveUpText");
         _hitSprite = new Sprite();
         _hitSprite.buttonMode = true;
         addChild(_bg);
         addChild(_taskIcon);
         addChild(_rewardImg);
         addChild(_expIcon);
         addChild(_goldIcon);
         addChild(_taskTitle);
         addChild(_taskContent);
         addChild(_expValue);
         addChild(_goldValue);
         addChild(_bufferText);
         addChild(_acceptBtn);
         addChild(_completedBtn);
         addChild(_quickBtn);
         addChild(_warningImage);
         addChild(_giveUp);
         addChild(_hitSprite);
         setTextHit();
      }
      
      private function setTextHit() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(0,0,_giveUp.textWidth,_giveUp.height);
         _hitSprite.x = _giveUp.x;
         _hitSprite.y = _giveUp.y;
      }
      
      public function get acceptBtn() : IconButton
      {
         return _acceptBtn;
      }
      
      private function addEvent() : void
      {
         _acceptBtn.addEventListener("click",__onAcceptClick);
         _quickBtn.addEventListener("click",__onQuickClick);
         _hitSprite.addEventListener("click",__onGiveUpClick);
         MsgMan.addObserver("INFO_CHANGE_BACK",this,__updateBufferText);
      }
      
      private function removeEvent() : void
      {
         if(_acceptBtn)
         {
            _acceptBtn.removeEventListener("click",__onAcceptClick);
         }
         if(_quickBtn)
         {
            _quickBtn.removeEventListener("click",__onQuickClick);
         }
         if(_hitSprite)
         {
            _hitSprite.removeEventListener("click",__onGiveUpClick);
         }
         MsgMan.removeObserver("INFO_CHANGE_BACK",this,__updateBufferText);
      }
      
      private function __updateBufferText(param1:String, param2:Object) : void
      {
         msInfo = MagicSpringManager.instance.model.checkIsExistBuffer(6);
         if(!msInfo)
         {
            _bufferText.text = "";
         }
      }
      
      private function __onGiveUpClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_data)
         {
            SimpleAlertHelper.instance.data = [removeRewardTaskCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("task.TaskFrameII.content");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         }
      }
      
      private function removeRewardTaskCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            TaskGainMovie.isGiveUp = true;
            if(rewardModel.baseRewardDic[_data.TemplateId])
            {
               OfferRewardManager.instance.sendRemoveRewardTask(rewardModel.baseRewardDic[_data.TemplateId].rewardID);
            }
         }
      }
      
      private function __onQuickClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            if(kingInfo.leftTime <= 0 && todayNeedAlertForOpenKingContract)
            {
               showKingContractTip();
            }
         }
      }
      
      private function __onAcceptClick(param1:MouseEvent) : void
      {
         if(_data && checkCanAccept)
         {
            OfferRewardManager.instance.sendAddRewardTask(rewardPos);
         }
      }
      
      private function showKingContractTip() : void
      {
         var _loc2_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("offerreward.view.OfferTaskItem.showKingContractTip");
         var _loc3_:String = LanguageMgr.GetTranslation("offerreward.view.OfferTaskItem.KingContractTip");
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc2_.show(_loc3_,_loc1_,__showTipResult,null,"center",2,true);
      }
      
      private function __showTipResult(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.openKingContractAlertDate = new Date();
            SharedManager.instance.saveOpenKingContractAlertDate();
         }
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function get todayNeedAlertForOpenKingContract() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.openKingContractAlertDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function get kingInfo() : KingContractInfo
      {
         return KingContractManager.Instance.model.getInfoById(2);
      }
      
      private function get checkCanAccept() : Boolean
      {
         var _loc1_:String = "";
         if(rewardModel.baseRewardDic.getList().length >= 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command01");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(rewardModel.remainRewardCount <= 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command02");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(_data.isOutDate)
         {
            _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.outDateTip");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(!_data.isReachDate)
         {
            _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.unreachDateTip");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function setData(param1:OfferRewardTemplate, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _data = param1;
         _profile = param2;
         _state = param3;
         var _loc4_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.isChangeJob ? 80 : thane.vocationGrades);
         msInfo = MagicSpringManager.instance.model.checkIsExistBuffer(6);
         if(_data)
         {
            _taskTitle.text = _data.Title.substring(0,_data.Title.indexOf("("));
            _taskContent.text = _data.conditionList[0].CondictionTitle + " (0/" + _data.conditionList[0].Para2 + ")";
            _loc5_ = 0;
            if(_profile != 5)
            {
               _loc5_ = _data.RewardPlayGP * _profile * (thane.grades + _loc4_);
               _expValue.text = _loc5_ + "";
               _goldValue.text = (_data.RewardGold * _profile * (thane.grades + _loc4_)).toString();
            }
            else
            {
               _goldValue.text = (_data.RewardGold * (_profile + 1) * (thane.grades + _loc4_)).toString();
               _loc5_ = _data.RewardPlayGP * (_profile + 1) * (thane.grades + _loc4_);
               _expValue.text = _loc5_ + "";
            }
            if(msInfo)
            {
               _loc6_ = Math.floor(msInfo.tempInfo.AddValue * _loc5_ / 100);
               _bufferText.htmlText = LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc6_);
            }
            if(_profile <= 5 && _profile >= 1)
            {
               _taskTitle.setFrame(_profile);
            }
            _acceptBtn.enable = true;
            switch(_state - 1)
            {
               case 0:
                  _acceptBtn.visible = true;
                  _completedBtn.visible = false;
                  _quickBtn.visible = false;
                  _warningImage.visible = false;
                  _giveUp.visible = false;
                  _hitSprite.visible = false;
                  break;
               case 1:
                  _warningImage.visible = true;
                  _giveUp.visible = true;
                  _hitSprite.visible = true;
                  if(kingInfo.leftTime <= 0)
                  {
                     _acceptBtn.visible = false;
                     _completedBtn.visible = false;
                     _quickBtn.visible = true;
                  }
                  else
                  {
                     _acceptBtn.visible = true;
                     _acceptBtn.enable = false;
                     _completedBtn.visible = false;
                     _quickBtn.visible = false;
                  }
                  break;
               case 2:
                  _acceptBtn.visible = false;
                  _completedBtn.visible = true;
                  _quickBtn.visible = false;
                  _warningImage.visible = false;
                  _giveUp.visible = false;
                  _hitSprite.visible = false;
                  _taskContent.text = _data.conditionList[0].CondictionTitle + " (" + _data.conditionList[0].Para2 + "/" + _data.conditionList[0].Para2 + ")";
            }
         }
         else
         {
            _taskTitle.text = "";
            _taskContent.text = "";
            _expValue.text = "";
            _goldValue.text = "";
            _acceptBtn.visible = false;
            _completedBtn.visible = false;
            _quickBtn.visible = false;
            _warningImage.visible = false;
            if(_bufferText)
            {
               _bufferText.text = "";
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_taskIcon);
         _taskIcon = null;
         ObjectUtils.disposeObject(_rewardImg);
         _rewardImg = null;
         ObjectUtils.disposeObject(_expIcon);
         _expIcon = null;
         ObjectUtils.disposeObject(_goldIcon);
         _goldIcon = null;
         ObjectUtils.disposeObject(_taskTitle);
         _taskTitle = null;
         ObjectUtils.disposeObject(_taskContent);
         _taskContent = null;
         ObjectUtils.disposeObject(_expValue);
         _expValue = null;
         ObjectUtils.disposeObject(_goldValue);
         _goldValue = null;
         ObjectUtils.disposeObject(_acceptBtn);
         _acceptBtn = null;
         ObjectUtils.disposeObject(_completedBtn);
         _completedBtn = null;
         ObjectUtils.disposeObject(_hitSprite);
         _hitSprite = null;
         ObjectUtils.disposeObject(_giveUp);
         _giveUp = null;
         ObjectUtils.disposeObject(_quickBtn);
         _quickBtn = null;
         ObjectUtils.disposeObject(_warningImage);
         _warningImage = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


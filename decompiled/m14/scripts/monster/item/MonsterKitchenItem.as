package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterCookInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.MonsterManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterKitchenItem extends Component
   {
      
      private var _callText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _callImage:ScaleFrameImage;
      
      private var _back:Image;
      
      private var _upgradeBtn:IconButton;
      
      private var _makeBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _completeBtn:IconButton;
      
      private var _makeBar:ProgressCommon;
      
      private var _resolveBtn:IconButton;
      
      private var _rewardText:FilterFrameText;
      
      private var _lookRewardImage:Bitmap;
      
      private var _rewardContiner:Component;
      
      private var _data:MonsterCookInfo;
      
      private var needTime:int;
      
      private var resolvePoint:int;
      
      private var upgradePoint:int;
      
      private var completePoint:int;
      
      private var cookPointAry:Array;
      
      private var isOpenUpGrade:Boolean = false;
      
      public function MonsterKitchenItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _callText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.callText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.timeText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.nameText");
         _callImage = ComponentFactory.Instance.creatComponentByStylename("MonsterKitchenItem.cookIcon");
         _back = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.back");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.upgradeBtn");
         _makeBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.nakeBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.cancelBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.getBtn");
         _completeBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.completeBtn");
         _makeBar = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.callBar");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.resolveBtn");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterKitchenItem.descText");
         _rewardContiner = ComponentFactory.Instance.creatComponentByStylename("MonsterKitchenItem.rewardContiner");
         _lookRewardImage = ComponentFactory.Instance.creatBitmap("asset.MonsterKitchenItem.lookRewardImage");
         addChild(_back);
         addChild(_callImage);
         addChild(_rewardContiner);
         addChild(_rewardText);
         addChild(_timeText);
         addChild(_nameText);
         addChild(_callText);
         addChild(_makeBar);
         addChild(_getBtn);
         addChild(_makeBtn);
         addChild(_cancelBtn);
         addChild(_upgradeBtn);
         addChild(_completeBtn);
         addChild(_resolveBtn);
         _rewardContiner.addChild(_lookRewardImage);
         _rewardContiner.addChild(_rewardText);
         _rewardText.text = LanguageMgr.GetTranslation("MonsterCircleItem.descText.text");
         cookPointAry = ConfigInfoManager.instance.getMonsterCookPointConfig();
         completePoint = int(cookPointAry[0]);
         resolvePoint = int(cookPointAry[1]);
      }
      
      private function addEvent() : void
      {
         _completeBtn.addEventListener("click",_completeBtnClickHandler);
         _getBtn.addEventListener("click",_getBtnClickHandler);
         _cancelBtn.addEventListener("click",_cancelBtnClickHandler);
         _makeBtn.addEventListener("click",_makeBtnClickHandler);
         _upgradeBtn.addEventListener("click",_upgradeBtnClickHandler);
         _resolveBtn.addEventListener("click",_resolveBtnClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_completeBtn)
         {
            _completeBtn.removeEventListener("click",_completeBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",_getBtnClickHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",_cancelBtnClickHandler);
         }
         if(_makeBtn)
         {
            _makeBtn.removeEventListener("click",_makeBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",_upgradeBtnClickHandler);
         }
         if(_resolveBtn)
         {
            _resolveBtn.removeEventListener("click",_resolveBtnClickHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         if(data && data.state && data.stopDate && data.stopDate.time > playerModel.sysCurtime.time)
         {
            updateShowTime();
         }
      }
      
      private function _completeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterKitchenItem.complete.onAlert",completePoint);
         SimpleAlertHelper.instance.data = [completeComfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function completeComfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(completePoint,false))
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(9,data.index);
      }
      
      private function _getBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(11,data.index);
      }
      
      private function _cancelBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterKitchenItem.cookItem.cancelAlert");
         SimpleAlertHelper.instance.data = [cancelComfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function cancelComfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(10,data.index);
      }
      
      private function _makeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data && data.state != 0)
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(8,data.index);
      }
      
      private function _upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!isOpenUpGrade)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.fun.noOpen"));
            return;
         }
         if(!data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterKitchenItem.upgrade.onAlert" + data.level,upgradePoint);
         SimpleAlertHelper.instance.data = [upgradeComfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function upgradeComfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(upgradePoint,false))
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(12,data.index);
      }
      
      private function _resolveBtnClickHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterKitchenItem.resolve.onAlert",resolvePoint);
         SimpleAlertHelper.instance.data = [resolveComfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function resolveComfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(resolvePoint,false))
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(13);
      }
      
      public function get data() : MonsterCookInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterCookInfo) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:SimpleDictionary = null;
         _data = param1;
         clean();
         if(data)
         {
            _callImage.setFrame(data.level);
            _callImage.visible = true;
            upgradePoint = data.level == 1 ? cookPointAry[2] : cookPointAry[3];
            _loc2_ = ConfigInfoManager.instance.getMonsterCookConfig();
            needTime = int(_loc2_[data.level - 1]) * 60;
            _loc3_ = DateFormatter.getConsortiaCountDate(needTime);
            _nameText.text = LanguageMgr.GetTranslation("MonsterKitchenItem.nameText.text" + data.level);
            _nameText.setFrame(data.level);
            if(data.state == 0)
            {
               _makeBtn.visible = true;
               _rewardContiner.visible = true;
               _upgradeBtn.visible = data.level < 3;
               _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text",_loc3_);
               _loc4_ = TempleteManager.instance.monsterCookDropTempCate.getTemplatesByType(data.level);
               _rewardContiner.tipData = getRewardTips(_loc4_);
            }
            else
            {
               _makeBar.visible = true;
               updateShowTime();
            }
         }
         else
         {
            _callImage.setFrame(1);
            _callImage.visible = false;
            _resolveBtn.visible = true;
         }
      }
      
      private function getRewardTips(param1:SimpleDictionary) : String
      {
         var _loc3_:String = "";
         for(var _loc2_:String in param1)
         {
            _loc3_ += GoodsHelp.getGoodsName(int(_loc2_)) + ",";
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf(","));
      }
      
      private function updateShowTime() : void
      {
         var _loc1_:int = (data.stopDate.time - playerModel.sysCurtime.time) / 1000;
         if(_loc1_ > 0)
         {
            _callText.text = LanguageMgr.GetTranslation("MonsterCircleItem.makeText.text1");
            _cancelBtn.visible = true;
            _completeBtn.visible = true;
            _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text",DateFormatter.getConsortiaCountDate(_loc1_));
            _timeText.y = 45;
            _makeBar.value = _loc1_ / needTime;
         }
         else
         {
            _makeBar.value = 0;
            _getBtn.visible = true;
            _cancelBtn.visible = false;
            _callText.text = LanguageMgr.GetTranslation("MonsterCircleItem.makeText.text2");
            _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text","00:00:00");
         }
      }
      
      private function clean() : void
      {
         _nameText.text = "";
         _callText.text = "";
         _timeText.text = "";
         _cancelBtn.visible = false;
         _makeBtn.visible = false;
         _upgradeBtn.visible = false;
         _completeBtn.visible = false;
         _getBtn.visible = false;
         _resolveBtn.visible = false;
         _makeBar.visible = false;
         _rewardContiner.visible = false;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_callText);
         _callText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_callImage);
         _callImage = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_makeBtn);
         _makeBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_completeBtn);
         _completeBtn = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_makeBar);
         _makeBar = null;
         ObjectUtils.disposeObject(_rewardContiner);
         _rewardContiner = null;
         ObjectUtils.disposeObject(_lookRewardImage);
         _lookRewardImage = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         super.dispose();
      }
   }
}


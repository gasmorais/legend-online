package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monster.MonsterCallFrame;
   import mvc.module.monster.MonsterCallInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.MonsterManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterCircleItem extends Component
   {
      
      private var _callText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _callImage:ScaleFrameImage;
      
      private var _callBack:Image;
      
      private var _callBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _resolveBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _completeBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _callBar:ProgressCommon;
      
      private var _data:MonsterCallInfo;
      
      private var needTime:int;
      
      private var resolvePoint:int;
      
      private var upgradePoint:int;
      
      private var completePoint:int;
      
      private var callPointAry:Array;
      
      private var isOpenUpGrade:Boolean = false;
      
      public function MonsterCircleItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _callText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.callText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.timeText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.nameText");
         _callImage = ComponentFactory.Instance.creatComponentByStylename("MonsterCircleItem.callImage");
         _callBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.callBack");
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.callBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.upgradeBtn");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.resolveBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.cancelBtn");
         _completeBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.completeBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.getBtn");
         _callBar = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCircleItem.callBar");
         addChild(_callBack);
         addChild(_callImage);
         addChild(_nameText);
         addChild(_callText);
         addChild(_timeText);
         addChild(_callBar);
         addChild(_cancelBtn);
         addChild(_callBtn);
         addChild(_upgradeBtn);
         addChild(_completeBtn);
         addChild(_getBtn);
         addChild(_resolveBtn);
         callPointAry = ConfigInfoManager.instance.getMonsterCallPointConfig();
         completePoint = int(callPointAry[0]);
         resolvePoint = int(callPointAry[1]);
      }
      
      private function addEvent() : void
      {
         _completeBtn.addEventListener("click",_completeBtnClickHandler);
         _cancelBtn.addEventListener("click",_cancelBtnClickHandler);
         _resolveBtn.addEventListener("click",_resolveBtnClickHandler);
         _upgradeBtn.addEventListener("click",_upgradeBtnClickHandler);
         _callBtn.addEventListener("click",_callBtnClickHandler);
         _getBtn.addEventListener("click",_getBtnClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_completeBtn)
         {
            _completeBtn.removeEventListener("click",_completeBtnClickHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",_cancelBtnClickHandler);
         }
         if(_resolveBtn)
         {
            _resolveBtn.removeEventListener("click",_resolveBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",_upgradeBtnClickHandler);
         }
         if(_callBtn)
         {
            _callBtn.removeEventListener("click",_callBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",_getBtnClickHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         if(data && data.state && data.stopDate && data.stopDate.time >= playerModel.sysCurtime.time)
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
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterCircleItem.complete.onAlert",completePoint);
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
         MonsterManager.instance.sendMonsterCallAndCookRequest(3,data.index);
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
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterCircleItem.callItem.cancelAlert");
         SimpleAlertHelper.instance.data = [cancelComfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function cancelComfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(4,data.index);
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
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterCircleItem.resolve.onAlert",resolvePoint);
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
         MonsterManager.instance.sendMonsterCallAndCookRequest(7);
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
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterCircleItem.upgrade.onAlert" + data.level,upgradePoint);
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
         MonsterManager.instance.sendMonsterCallAndCookRequest(6,data.index);
      }
      
      private function _getBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         MonsterManager.instance.sendMonsterCallAndCookRequest(5,data.index);
      }
      
      private function _callBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MonsterCallFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterCallFrame");
         _loc2_.setCallInfo(data);
         _loc2_.show();
      }
      
      public function get data() : MonsterCallInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterCallInfo) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         _data = param1;
         clean();
         if(data)
         {
            _callImage.setFrame(data.level);
            _callImage.visible = true;
            upgradePoint = data.level == 1 ? callPointAry[2] : callPointAry[3];
            _loc2_ = ConfigInfoManager.instance.getMonsterCallConifg();
            _loc3_ = _loc2_[data.level - 1].split(",");
            needTime = int(_loc3_[1]) * 60;
            _loc4_ = DateFormatter.getConsortiaCountDate(needTime);
            _nameText.text = LanguageMgr.GetTranslation("MonsterCircleItem.nameText.text" + data.level);
            _nameText.setFrame(data.level);
            if(data.state == 0)
            {
               _callBtn.visible = true;
               _upgradeBtn.visible = data.level < 3;
               _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text",_loc4_);
               _timeText.y = 45;
            }
            else
            {
               _callBar.visible = true;
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
      
      private function updateShowTime() : void
      {
         var _loc1_:int = (data.stopDate.time - playerModel.sysCurtime.time) / 1000;
         if(_loc1_ > 0)
         {
            _callText.text = LanguageMgr.GetTranslation("MonsterCircleItem.callText.text1");
            _cancelBtn.visible = true;
            _completeBtn.visible = true;
            _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text",DateFormatter.getConsortiaCountDate(_loc1_));
            _timeText.y = 45;
            _callBar.value = _loc1_ / needTime;
         }
         else
         {
            _callText.text = LanguageMgr.GetTranslation("MonsterCircleItem.callText.text2");
            _timeText.htmlText = LanguageMgr.GetTranslation("MonsterCircleItem.timeText.text","00:00:00");
            _callBar.value = 0;
            _getBtn.visible = true;
            _cancelBtn.visible = false;
            _timeText.y = 45;
         }
      }
      
      private function clean() : void
      {
         _nameText.text = "";
         _callText.text = "";
         _timeText.text = "";
         _cancelBtn.visible = false;
         _callBtn.visible = false;
         _upgradeBtn.visible = false;
         _completeBtn.visible = false;
         _getBtn.visible = false;
         _resolveBtn.visible = false;
         _callBar.visible = false;
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
         ObjectUtils.disposeObject(_callBack);
         _callBack = null;
         ObjectUtils.disposeObject(_callBtn);
         _callBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_completeBtn);
         _completeBtn = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_callBar);
         _callBar = null;
         super.dispose();
      }
   }
}


package outyard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardForceInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardBlessFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _attactBg:DisplayObject;
      
      private var _attactNote:DisplayObject;
      
      private var _defenceBg:DisplayObject;
      
      private var _defenceNote:DisplayObject;
      
      private var _attackBtn:IconButton;
      
      private var _defenceBtn:IconButton;
      
      private var _attactNote1:DisplayObject;
      
      private var _defenceNote1:DisplayObject;
      
      private var _attackRateTxt:FilterFrameText;
      
      private var _defenceRateTxt:FilterFrameText;
      
      private var _attackNoteTxt:FilterFrameText;
      
      private var _defenceNoteTxt:FilterFrameText;
      
      private var _blessNumTxt:FilterFrameText;
      
      private var _config1:Array;
      
      private var _config2:Array;
      
      private var _config3:int;
      
      private var _clickTime:int = 0;
      
      public function OutyardBlessFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,542,484);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.blessBg");
         _attactBg = ComponentFactory.Instance.creatBitmap("asset.outyard.blessAttactBg");
         _attactNote = ComponentFactory.Instance.creatBitmap("asset.outyard.blessAttactNote");
         _defenceBg = ComponentFactory.Instance.creatBitmap("asset.outyard.blessDefenceBg");
         _defenceNote = ComponentFactory.Instance.creatBitmap("asset.outyard.blessDefenceNote");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.blessAttackBtn");
         _defenceBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.blessDefenceBtn");
         _attactNote1 = ComponentFactory.Instance.creatBitmap("asset.outyard.blessAttactNote1");
         _defenceNote1 = ComponentFactory.Instance.creatBitmap("asset.outyard.blessDefenceNote1");
         _attackRateTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardBlessFrame.attackRateTxt");
         _defenceRateTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardBlessFrame.defenceRateTxt");
         _attackNoteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardBlessFrame.attackNoteTxt");
         _defenceNoteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardBlessFrame.defenceNoteTxt");
         _blessNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardBlessFrame.blessNumTxt");
         addToContent(_bg);
         addToContent(_attactBg);
         addToContent(_attactNote);
         addToContent(_defenceBg);
         addToContent(_defenceNote);
         addToContent(_attackBtn);
         addToContent(_defenceBtn);
         addToContent(_attactNote1);
         addToContent(_defenceNote1);
         addToContent(_attackRateTxt);
         addToContent(_defenceRateTxt);
         addToContent(_attackNoteTxt);
         addToContent(_defenceNoteTxt);
         addToContent(_blessNumTxt);
         _config1 = ConfigInfoManager.instance.getStackHeadAttackBuff();
         _config2 = ConfigInfoManager.instance.getStackHeadDefenceBuff();
         _config3 = ConfigInfoManager.instance.getStackHeadReadyBuffMax();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _attackBtn.addEventListener("click",__onAttackHandler);
         _defenceBtn.addEventListener("click",__onDefenceHandler);
         NotificationManager.instance.addEventListener("OUTYARD_FULL_INFO",__selfInfoHandler);
         NotificationManager.instance.addEventListener("OUTYARD_SELF_INFO",__selfInfoHandler);
         __selfInfoHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _attackBtn.removeEventListener("click",__onAttackHandler);
         _defenceBtn.removeEventListener("click",__onDefenceHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_FULL_INFO",__selfInfoHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_SELF_INFO",__selfInfoHandler);
      }
      
      private function __selfInfoHandler(param1:NotificationEvent) : void
      {
         var _loc4_:OutyardForceInfo = OutyardManager.instance.crystalModel.myForce;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:int = int(OutyardManager.instance.model.getActiveRateByType(1));
         _attackRateTxt.text = "" + int(_loc4_.attackBuffLevel * _config1[1]) + "%";
         _defenceRateTxt.text = "" + int(_loc4_.defenceBuffLevel * _config2[1]) + "%";
         _attackNoteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.attackNoteTxt.text",Math.ceil(_config1[0] * (_loc5_ / 100)));
         _defenceNoteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.attackNoteTxt.text",Math.ceil(_config2[0] * (_loc5_ / 100)));
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         _blessNumTxt.visible = _loc2_.stackHeadState != 3;
         var _loc3_:StackHeadSelfMsg = OutyardManager.instance.crystalModel.selfMsg;
         _blessNumTxt.text = LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.blessNumTxt.text",_config3 - _loc3_.readyBuffCount);
      }
      
      private function __onAttackHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         if(!checkBlessing(1))
         {
            return;
         }
         var _loc2_:OutyardForceInfo = OutyardManager.instance.crystalModel.myForce;
         _loc2_.attackBuffLevel++;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_FULL_INFO"));
         OutyardManager.instance.OperateOutyard(5);
      }
      
      private function __onDefenceHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         if(!checkBlessing(2))
         {
            return;
         }
         var _loc2_:OutyardForceInfo = OutyardManager.instance.crystalModel.myForce;
         _loc2_.defenceBuffLevel++;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_FULL_INFO"));
         OutyardManager.instance.OperateOutyard(4);
      }
      
      private function checkBlessing(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:StackHeadSelfMsg = OutyardManager.instance.crystalModel.selfMsg;
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         var _loc5_:OutyardForceInfo = OutyardManager.instance.model.myForce;
         if(param1 == 1 && _config1[2] <= _loc5_.attackBuffLevel)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.StackHead.Buff.AttackMax"));
            return false;
         }
         if(param1 == 2 && _config2[2] <= _loc5_.defenceBuffLevel)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.StackHead.Buff.DefenceMax"));
            return false;
         }
         if(_loc2_.stackHeadState == 2)
         {
            if(param1 == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.cannotBlessingHandler"));
               return false;
            }
            if(_config2[0] > _loc3_.actionPoint)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.executionNotHandler"));
               return false;
            }
            if(_loc3_.readyBuffCount >= _config3)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.noBuffCountHandler"));
               return false;
            }
         }
         if(_loc2_.stackHeadState == 3)
         {
            _loc4_ = int(OutyardManager.instance.model.getActiveRateByType(1));
            if(param1 == 1 && Math.ceil(_config1[0] * (_loc4_ / 100)) > _loc3_.actionPoint || param1 == 2 && Math.ceil(_config2[0] * (_loc4_ / 100)) > _loc3_.actionPoint)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.executionNotHandler"));
               return false;
            }
         }
         if(_loc2_.stackHeadState == 4)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.balanceHandler"));
            return false;
         }
         if(_loc2_.stackHeadState == 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardBlessFrame.overHandler"));
            return false;
         }
         return true;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_attactBg);
         _attactBg = null;
         ObjectUtils.disposeObject(_attactNote);
         _attactNote = null;
         ObjectUtils.disposeObject(_defenceBg);
         _defenceBg = null;
         ObjectUtils.disposeObject(_defenceNote);
         _defenceNote = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_defenceBtn);
         _defenceBtn = null;
         ObjectUtils.disposeObject(_attactNote1);
         _attactNote1 = null;
         ObjectUtils.disposeObject(_defenceNote1);
         _defenceNote1 = null;
         ObjectUtils.disposeObject(_attackRateTxt);
         _attackRateTxt = null;
         ObjectUtils.disposeObject(_defenceRateTxt);
         _defenceRateTxt = null;
         ObjectUtils.disposeObject(_attackNoteTxt);
         _attackNoteTxt = null;
         ObjectUtils.disposeObject(_defenceNoteTxt);
         _defenceNoteTxt = null;
         ObjectUtils.disposeObject(_blessNumTxt);
         _blessNumTxt = null;
         super.dispose();
      }
   }
}


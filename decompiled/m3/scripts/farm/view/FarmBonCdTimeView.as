package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.DateFormatter;
   
   public class FarmBonCdTimeView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var uintBeginFlag:uint;
      
      private var uintBonFlag:uint;
      
      private var _invideBtn:BaseButton;
      
      private var _beginLeftTime:int;
      
      private var _bonLeftTime:int;
      
      public function FarmBonCdTimeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.farm.BonCDTimeBG");
         _txt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBonCdTimeView.Txt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BonCDTime.leftTimeTxt");
         _invideBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.InvideFirendBtn");
         _invideBtn.tipData = LanguageMgr.GetTranslation("farm.farmUILayer.InvideBtn");
         addChild(_bg);
         addChild(_txt);
         addChild(_leftTimeTxt);
         addChild(_invideBtn);
         this.visible = false;
         onBonBeginTimeLeft();
         onBonTimeLeft();
         _invideBtn.visible = false;
         onBonfireStatus();
      }
      
      private function showInvideBtn() : void
      {
         if(FarmManager.instance.model.masterId != thane.userId)
         {
            return;
         }
         _invideBtn.visible = true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         model.addEventListener("FARM_BONFIRE_LEFT_TIME",onBonTimeLeft);
         model.addEventListener("FARM_BONFIRE_BEGIN_TIME",onBonBeginTimeLeft);
         _invideBtn.addEventListener("click",onInvideBtnClick);
         FarmManager.instance.model.addEventListener("FARM_BIGBONFIRE_STATUS",onBonfireStatus);
         FarmManager.instance.model.addEventListener("FARM_SELECTED_CHANGE",onBonfireStatus);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("FARM_BONFIRE_LEFT_TIME",onBonTimeLeft);
         model.removeEventListener("FARM_BONFIRE_BEGIN_TIME",onBonBeginTimeLeft);
         _invideBtn.removeEventListener("click",onInvideBtnClick);
         FarmManager.instance.model.removeEventListener("FARM_BIGBONFIRE_STATUS",onBonfireStatus);
         FarmManager.instance.model.removeEventListener("FARM_SELECTED_CHANGE",onBonfireStatus);
      }
      
      private function onBonfireStatus(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         try
         {
            _loc2_ = Boolean(FarmManager.instance.model.bigBonFireIsOpen);
         }
         catch(e:Error)
         {
         }
         if(_loc2_)
         {
            showInvideBtn();
         }
         else
         {
            _invideBtn.visible = false;
         }
      }
      
      private function onInvideBtnClick(param1:MouseEvent) : void
      {
         FarmManager.instance.openFarmInvideFrame();
      }
      
      private function onBonBeginTimeLeft(param1:Event = null) : void
      {
         _txt.text = LanguageMgr.GetTranslation("farm.view.BonBeginTimeLeft");
         this.visible = true;
         clearInterval(uintBeginFlag);
         _beginLeftTime = model.beginLeftTime;
         if(_beginLeftTime > 0)
         {
            uintBeginFlag = setInterval(cdBeginTime,1000);
         }
         else if(_beginLeftTime < 0)
         {
            this.visible = false;
            clearInterval(uintBeginFlag);
         }
      }
      
      private function onBonTimeLeft(param1:Event = null) : void
      {
         if(param1 == null && _beginLeftTime > 0)
         {
            return;
         }
         _beginLeftTime = 0;
         clearInterval(uintBeginFlag);
         _txt.text = LanguageMgr.GetTranslation("farm.view.BonTimeLeft");
         this.visible = true;
         clearInterval(uintBonFlag);
         _bonLeftTime = model.leftTime;
         if(_bonLeftTime > 0)
         {
            uintBonFlag = setInterval(cdBonTime,1000);
         }
         else if(_bonLeftTime <= 0)
         {
            this.visible = false;
            clearInterval(uintBonFlag);
         }
      }
      
      private function cdBeginTime() : void
      {
         _beginLeftTime -= 1;
         if(_beginLeftTime >= 0)
         {
            _leftTimeTxt.text = DateFormatter.getCountDateByMS(_beginLeftTime);
            this.visible = true;
         }
         if(_beginLeftTime < 0)
         {
            this.visible = false;
            clearInterval(uintBeginFlag);
         }
      }
      
      private function cdBonTime() : void
      {
         _bonLeftTime -= 1;
         if(_bonLeftTime >= 0)
         {
            _leftTimeTxt.text = DateFormatter.getCountDateByMS(_bonLeftTime);
            this.visible = true;
         }
         if(_bonLeftTime < 0)
         {
            this.visible = false;
            clearInterval(uintBonFlag);
         }
      }
      
      public function get bgWidth() : Number
      {
         return _bg.width;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      override public function dispose() : void
      {
         clearInterval(uintBeginFlag);
         clearInterval(uintBonFlag);
         removeEvent();
         ObjectUtils.disposeObject(_invideBtn);
         _invideBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_invideBtn);
         _invideBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


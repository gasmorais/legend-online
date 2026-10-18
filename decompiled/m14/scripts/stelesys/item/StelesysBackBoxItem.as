package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.StelaUseFrame;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StelesysBackBoxItem extends StelesysBaseBoxItem
   {
      
      private var _numTxt:FilterFrameText;
      
      private var _useTxt:FilterFrameText;
      
      private var _useCount:int;
      
      public function StelesysBackBoxItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backHaseTxt");
         _useTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backUseTxt");
         addChild(_numTxt);
         addChild(_useTxt);
         _scaleSp.scaleX = _scaleSp.scaleY = 0.8;
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1)
         {
            _useCount = param1.tempUse;
            _numTxt.text = LanguageMgr.GetTranslation("stela.has",param1.exp);
            _useTxt.text = LanguageMgr.GetTranslation("stala.use",_useCount);
            this.tipData = _data.tempInfo.Description;
         }
      }
      
      override protected function addEvent() : void
      {
         _isEvt = true;
         this.addEventListener("click",doUsehandler);
         NotificationManager.instance.addEventListener("STELE_SYS_USE_FRAME",useChangeHandler);
      }
      
      override protected function delEvent() : void
      {
         _isEvt = false;
         this.removeEventListener("click",doUsehandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_USE_FRAME",useChangeHandler);
      }
      
      private function useChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         var _loc3_:StelesysInfo = _loc2_[0];
         _useCount = _loc2_[1];
         if(_loc3_ == _data && _data != null)
         {
            _data.tempUse = _useCount;
            _useTxt.text = LanguageMgr.GetTranslation("stala.use",_useCount);
            NotificationManager.instance.sendNotification("STELE_SYS_USE");
         }
      }
      
      override public function opUpdate() : void
      {
         if(_data)
         {
            _useCount = _data.tempUse;
            _useTxt.text = LanguageMgr.GetTranslation("stala.use",_useCount);
         }
      }
      
      private function doUsehandler(param1:MouseEvent) : void
      {
         var _loc2_:StelaUseFrame = null;
         if(model.currIntensifyInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.intensify.needChoose"));
            return;
         }
         if(_data && _data.exp > 0)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("stelesys.StelaUseFrame");
            _loc2_.data = _data;
            _loc2_.show();
         }
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_useTxt);
         _useTxt = null;
         super.dispose();
      }
      
      public function get useCount() : int
      {
         return _useCount;
      }
      
      public function set useCount(param1:int) : void
      {
         _useCount = param1;
      }
   }
}


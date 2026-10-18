package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StelesysMetrialBox extends StelesysBoxItem
   {
      
      private var _equipStateTxt:GradientText;
      
      protected var _chooseFlg:Bitmap;
      
      protected var _isChoose:Boolean;
      
      private var _isEvent:Boolean;
      
      public function StelesysMetrialBox()
      {
         super();
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            _colorImg.visible = false;
            tipData = null;
            removeEvent();
            return;
         }
         tipData = param1;
         isChoose = param1.isChoose;
         if(!_isEvent)
         {
            initEvent();
         }
         if(param1.isOnEquip)
         {
            _equipStateTxt.text = LanguageMgr.GetTranslation("stela.equip");
         }
         else
         {
            _equipStateTxt.text = "";
         }
      }
      
      override protected function initView() : void
      {
         super.initView();
         _equipStateTxt = ComponentFactory.Instance.creatComponentByStylename("stele.metrial.stateTxt");
         _chooseFlg = ComponentFactory.Instance.creatBitmap("asset.stelesys.chooseFkg");
         addChild(_equipStateTxt);
         addChild(_chooseFlg);
         _scaleSp.scaleX = _scaleSp.scaleY = 0.8;
         _chooseFlg.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipStateTxt);
         _equipStateTxt = null;
         ObjectUtils.disposeObject(_chooseFlg);
         _chooseFlg = null;
         ObjectUtils.disposeObject(_colorImg);
         _colorImg = null;
         super.dispose();
      }
      
      private function initEvent() : void
      {
         _isEvent = true;
         this.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _isEvent = false;
         this.removeEventListener("click",clickHandler);
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = !_isChoose;
         var _loc4_:StelesysInfo = model.currIntensifyInfo;
         if(_loc3_)
         {
            if(_loc4_ == null)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.intensify.needChoose"));
               return;
            }
            if(_loc4_.level == _loc4_.stepTempInfo.StrengthLimit)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.intensifyMax"));
               return;
            }
            _loc2_ = Boolean(model.intensifyCheckChoose());
            if(!_loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.intensify.full"));
            }
            else
            {
               isChoose = _loc3_;
            }
         }
         else
         {
            isChoose = _loc3_;
         }
      }
      
      public function get isChoose() : Boolean
      {
         return _isChoose;
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      public function set isChoose(param1:Boolean) : void
      {
         if(_isChoose == param1)
         {
            return;
         }
         _isChoose = param1;
         if(_data)
         {
            _data.isChoose = isChoose;
         }
         _chooseFlg.visible = _isChoose;
         NotificationManager.instance.sendNotification("STELE_SYS_METRIAL");
      }
      
      override public function opUpdate() : void
      {
         if(_data)
         {
            _isChoose = _data.isChoose;
            _chooseFlg.visible = _isChoose;
         }
      }
   }
}


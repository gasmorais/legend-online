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
   
   public class StelesysAdvanceBoxItem extends StelesysBoxItem
   {
      
      private var _equipStateTxt:GradientText;
      
      private var _isEvent:Boolean;
      
      private var _chooseFlg:Bitmap;
      
      private var _isChoose:Boolean;
      
      public function StelesysAdvanceBoxItem()
      {
         super();
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            tipData = null;
            removeEvent();
            return;
         }
         tipData = param1;
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
      
      private function clickHandler(param1:MouseEvent) : void
      {
         isChoose = !_isChoose;
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
         if(param1 && model.currAdvanceInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.advance.needChoose"));
            return;
         }
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
         NotificationManager.instance.sendNotification("STELE_SYS_METRIAL",rollBack);
      }
      
      private function rollBack() : void
      {
         _isChoose = false;
         if(_data)
         {
            _data.isChoose = _isChoose;
         }
         _chooseFlg.visible = _isChoose;
      }
   }
}


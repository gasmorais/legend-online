package finaldefense.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import managers.FinalDefenseManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FinalDefensePowerPrgView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _pressImg:Bitmap;
      
      private var _pressTxtBg:Bitmap;
      
      private var _powerTxt:FilterFrameText;
      
      private var _maskShape:Shape;
      
      public function FinalDefensePowerPrgView()
      {
         super();
         initView();
         addEvent();
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.gamebox.powerProgressBg");
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.powerProgressImg");
         _pressTxtBg = ComponentFactory.Instance.creatBitmap("asset.gamebox.powerProgressTxtBg");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("finaldefens.powerTxt");
         _maskShape = new Shape();
         addChild(_bg);
         addChild(_pressImg);
         addChild(_pressTxtBg);
         addChild(_powerTxt);
         _maskShape.graphics.beginFill(0);
         _maskShape.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _maskShape.graphics.endFill();
         _maskShape.x = _pressImg.x;
         _pressImg.mask = _maskShape;
         addChild(_maskShape);
      }
      
      private function onInfo(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onInfo);
      }
      
      public function updateView() : void
      {
         _powerTxt.text = FinalDefenseManager.ins.model.info.energy.toString();
         var _loc1_:Number = 1 - FinalDefenseManager.ins.model.info.energy / 900 < 0 ? 0 : 1 - FinalDefenseManager.ins.model.info.energy / 900;
         _maskShape.y = _pressImg.y + _loc1_ * _pressImg.height;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_pressTxtBg);
         _pressTxtBg = null;
         ObjectUtils.disposeObject(_powerTxt);
         _powerTxt = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
         super.dispose();
      }
   }
}


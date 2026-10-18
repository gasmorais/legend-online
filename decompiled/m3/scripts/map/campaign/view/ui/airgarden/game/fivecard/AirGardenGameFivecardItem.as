package map.campaign.view.ui.airgarden.game.fivecard
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.airgarden.game.FivecardData;
   
   public class AirGardenGameFivecardItem extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var imgR:ScaleFrameImage;
      
      private var imgB:ScaleFrameImage;
      
      private var imgC:ScaleFrameImage;
      
      public var isHold:Boolean = false;
      
      public var index:int;
      
      private var isLocked:Boolean = false;
      
      private var t:Number = 0.2;
      
      private var sp:Sprite;
      
      private var _data:FivecardData;
      
      public var showData:FivecardData;
      
      public function AirGardenGameFivecardItem(param1:int)
      {
         super();
         this.index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         sp = new Sprite();
         addChild(sp);
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.AirGardenGame.cardbg3");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.AirGardenGame.btnHold");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.AirGardenGame.cardbg4");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.AirGardenGame.cardS");
         sp.addChild(_bit0);
         sp.addChild(_bit1);
         sp.addChild(_bit2);
         sp.addChild(_bit3);
         imgR = ComponentFactory.Instance.creatComponentByStylename("airGarden.fivecard.numr");
         imgB = ComponentFactory.Instance.creatComponentByStylename("airGarden.fivecard.numb");
         imgC = ComponentFactory.Instance.creatComponentByStylename("airGarden.fivecard.color");
         sp.addChild(imgR);
         sp.addChild(imgB);
         sp.addChild(imgC);
         sp.x -= _bit0.width / 2;
         imgR.visible = imgB.visible = imgC.visible = false;
         _bit1.visible = false;
         _bit3.visible = false;
      }
      
      public function set data(param1:FivecardData) : void
      {
         _data = param1;
         buttonMode = true;
         index = param1.index;
         imgR.visible = imgB.visible = false;
         if(param1.color % 2)
         {
            imgR.setFrame(param1.number);
            imgR.visible = true;
         }
         else
         {
            imgB.setFrame(param1.number);
            imgB.visible = true;
         }
         imgC.visible = true;
         imgC.setFrame(param1.color);
      }
      
      public function lock(param1:Boolean) : void
      {
         buttonMode = !param1;
         isLocked = param1;
         isHold = param1;
         if(param1)
         {
            _bit1.visible = !param1;
            _bit3.visible = !param1;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         isHold = !isHold;
         _bit1.visible = isHold;
         _bit3.visible = isHold;
      }
      
      public function flip(param1:Boolean = false) : void
      {
         _bit0.visible = true;
         _bit2.visible = false;
         imgR.visible = imgB.visible = imgC.visible = false;
         if(param1)
         {
            TweenLite.to(this,t,{
               "scaleX":0,
               "onComplete":onBack,
               "delay":index * 0.2
            });
         }
         else
         {
            TweenLite.to(this,t,{
               "scaleX":0,
               "onComplete":onBack
            });
         }
      }
      
      private function onBack() : void
      {
         _bit0.visible = false;
         _bit2.visible = true;
         if(showData)
         {
            data = showData;
            showData = null;
         }
         else
         {
            data = _data;
         }
         TweenLite.to(this,t,{"scaleX":1});
      }
      
      override public function dispose() : void
      {
         TweenLite.killTweensOf(this);
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(imgR);
         imgR = null;
         ObjectUtils.disposeObject(imgB);
         imgB = null;
         ObjectUtils.disposeObject(imgC);
         imgC = null;
         ObjectUtils.disposeObject(sp);
         sp = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


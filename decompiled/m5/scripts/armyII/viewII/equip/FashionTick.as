package armyII.viewII.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FashionTick extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _tick:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _id:int;
      
      private var _pos:int;
      
      public function FashionTick()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fashionBack");
         _txt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fashionTickTxt");
         _tick = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fashionTick");
         addChild(_back);
         addChild(_txt);
         addChild(_tick);
         _txt.text = LanguageMgr.GetTranslation("fashion.hide");
         this.buttonMode = true;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set data(param1:Boolean) : void
      {
         _tick.visible = param1;
      }
      
      public function get data() : Boolean
      {
         return _tick.visible;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _tick.visible = !_tick.visible;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FASHION_CHANGE"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_tick);
         _tick = null;
      }
   }
}


package castle.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   
   public class CastleBackgroundLayer extends Sprite implements Disposeable
   {
      
      private var _back:Image;
      
      private var _blackGound:Sprite;
      
      public function CastleBackgroundLayer()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            if(_back.parent)
            {
               _back.parent.removeChild(_back);
            }
            _back = null;
            ObjectUtils.disposeObject(_blackGound);
            _blackGound = null;
         }
         _back = ComponentFactory.Instance.creatComponentByStylename("castle.InnerCityBg1");
         _back.cacheAsBitmap = true;
         _back.mouseChildren = _back.mouseEnabled = false;
         _blackGound = new Sprite();
         _blackGound.graphics.beginFill(0,1);
         _blackGound.graphics.drawRect(-_back.width,-_back.height,_back.width * 3,_back.height * 3);
         _blackGound.graphics.endFill();
         addChild(_blackGound);
         addChild(_back);
      }
      
      public function get resWidth() : int
      {
         return _back.width;
      }
      
      public function get resHeight() : int
      {
         return _back.height;
      }
      
      private function initEvent() : void
      {
         thane.addEventListener("THANE_LEVEL_UPDATE",__upgradeHandler);
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("THANE_LEVEL_UPDATE",__upgradeHandler);
      }
      
      private function __upgradeHandler(param1:PlayerEvent) : void
      {
         initView();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


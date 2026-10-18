package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mvc.module.planeswar.PlanesArmy;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesWarFogView extends Component implements IEnterFrame
   {
      
      private var _fogBitmap:Bitmap;
      
      private var _heroFog:Bitmap;
      
      private var holdObj:Object = {};
      
      private var _eraseBitmap:Bitmap;
      
      private var _eraseBitmapData:BitmapData;
      
      public function PlanesWarFogView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         this.blendMode = "layer";
         _fogBitmap = ComponentFactory.Instance.creatBitmap("asset.planesWar.planesWarFogView.FogType" + model.currentSize);
         _heroFog = ComponentFactory.Instance.creatBitmap("asset.planesWar.planesWarFogView.Fog");
         _eraseBitmap = new Bitmap(new BitmapData(_fogBitmap.width - 600,_fogBitmap.height - 600,true,0));
         _eraseBitmapData = ComponentFactory.Instance.creatBitmapData("asset.planesWar.planesWarFogView.Fog0");
         addChild(_fogBitmap);
         addChild(_heroFog);
         _heroFog.blendMode = "erase";
         addChild(_eraseBitmap);
         _eraseBitmap.blendMode = "erase";
         _eraseBitmap.x = _eraseBitmap.y = 300;
      }
      
      public function addHole(param1:int, param2:int) : void
      {
         var _loc5_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:Point = null;
         var _loc3_:Rectangle = null;
         var _loc7_:int = param1 * 100 + param2;
         var _loc4_:int = int(holdObj[_loc7_]);
         if(_loc4_ <= 0)
         {
            _loc5_ = _eraseBitmapData.clone();
            _loc8_ = (100 - _loc5_.width) * 0.5;
            _loc6_ = (100 - _loc5_.height) * 0.5;
            _loc9_ = _loc9_ = new Point(param1 * 100 + _loc8_,param2 * 100 + _loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,true);
            _eraseBitmap.bitmapData.copyPixels(_loc5_,_loc3_,_loc9_,null,null,true);
            holdObj[_loc7_] = 1;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:PlanesArmy = model.selfArmy;
         if(_loc1_.armyView is PlanesArmyView)
         {
            _heroFog.x = _loc1_.armyView.x + 220;
            _heroFog.y = _loc1_.armyView.y + 220;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fogBitmap);
         _fogBitmap = null;
         ObjectUtils.disposeObject(_heroFog);
         _heroFog = null;
         ObjectUtils.disposeObject(_eraseBitmap);
         _eraseBitmap = null;
         ObjectUtils.disposeObject(_eraseBitmapData);
         _eraseBitmapData = null;
         holdObj = null;
         super.dispose();
      }
   }
}


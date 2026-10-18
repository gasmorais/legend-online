package water.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.TreeInfo;
   
   public class FruteItem extends Sprite
   {
      
      private var _icon:Bitmap;
      
      public var index:int;
      
      private var _data:TreeInfo;
      
      public function FruteItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.water.FruteIcon");
         addChild(_icon);
      }
      
      public function set data(param1:TreeInfo) : void
      {
         _data = param1;
      }
      
      public function get data() : TreeInfo
      {
         return _data;
      }
   }
}


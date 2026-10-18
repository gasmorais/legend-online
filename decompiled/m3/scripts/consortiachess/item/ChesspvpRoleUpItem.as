package consortiachess.item
{
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ChesspvpRoleUpItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _roleBit:Bitmap;
      
      private var _type:int;
      
      private var _team:int;
      
      public function ChesspvpRoleUpItem(param1:int, param2:int)
      {
         super();
         _type = param1;
         _team = param2;
         initView();
      }
      
      private function initView() : void
      {
         _bg = new Bitmap();
         _roleBit = new Bitmap();
         if(_team == 1)
         {
            _bg.bitmapData = ChesspvpResourceUtil.ins.whiteBoxData;
            _roleBit.bitmapData = ChesspvpResourceUtil.ins.whiteRoleDataList[_type];
         }
         else
         {
            _bg.bitmapData = ChesspvpResourceUtil.ins.blackBoxData;
            _roleBit.bitmapData = ChesspvpResourceUtil.ins.blackRoleDataList[_type];
         }
         addChild(_bg);
         addChild(_roleBit);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


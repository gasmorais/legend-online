package theseus.war.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import managers.TheseussoulManager;
   import theseus.war.item.TheseusInsfBagCell;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   
   public class TheseusWarBitPool
   {
      
      private static var _ins:TheseusWarBitPool;
      
      private var _stars:Array = [];
      
      public function TheseusWarBitPool()
      {
         super();
      }
      
      public static function get Ins() : TheseusWarBitPool
      {
         if(_ins == null)
         {
            _ins = new TheseusWarBitPool();
         }
         return _ins;
      }
      
      public function init() : void
      {
         var _loc1_:int = 0;
         if(_stars.length == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 5)
            {
               _stars.push(ComponentFactory.Instance.creatBitmap("asset.theseus.warStar" + _loc1_).bitmapData);
               _loc1_++;
            }
         }
      }
      
      public function getStarBitmapData(param1:int) : BitmapData
      {
         if(_stars.length > param1)
         {
            return _stars[param1];
         }
         return null;
      }
      
      public function onSplitHandler(param1:Object) : void
      {
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(param1,{"icon":_loc3_});
         _loc2_.dropChecks = [TheseusInsfBagCell,Stage];
         _loc2_.onDrop = onSpliteDrop;
         CursorManagerII.instance.hide();
      }
      
      private function onSpliteDrop(param1:GameDrag) : void
      {
         param1.stopImmediatePropagation();
         CursorManagerII.instance.show();
         var _loc2_:TheseusInsfBagCell = param1.dropTarget as TheseusInsfBagCell;
         if(!_loc2_ || !_loc2_.data || _loc2_.data.num <= 1)
         {
            return;
         }
         TheseussoulManager.Instance.doWarsoulParam(21,-1,_loc2_.data.id);
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SpliteIconAsset");
         _loc1_.mouseEnabled = _loc1_.mouseChildren = true;
         return _loc1_;
      }
      
      public function clean() : void
      {
      }
   }
}


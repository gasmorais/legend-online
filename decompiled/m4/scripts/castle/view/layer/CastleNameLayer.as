package castle.view.layer
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class CastleNameLayer extends Sprite implements Disposeable
   {
      
      private var _nameDic:Dictionary;
      
      public function CastleNameLayer()
      {
         super();
         _nameDic = new Dictionary();
      }
      
      public function addChildByIndex(param1:DisplayObject, param2:Point) : void
      {
         addChild(param1);
         _nameDic[param1] = param2;
      }
      
      public function refreshChild(param1:Number) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:int = numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc4_) as DisplayObject;
            _loc3_.x = int(_nameDic[_loc3_].x * param1);
            _loc3_.y = int(_nameDic[_loc3_].y * param1);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:DisplayObject in _nameDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _nameDic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


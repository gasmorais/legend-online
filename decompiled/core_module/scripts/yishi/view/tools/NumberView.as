package yishi.view.tools
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NumberView extends Sprite
   {
      
      private var _styleName:String;
      
      private var _count:int;
      
      private var _paddingH:Number;
      
      public function NumberView(param1:int, param2:String, param3:Number = 20)
      {
         super();
         _count = param1;
         _styleName = param2;
         _paddingH = param3;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:MovieClip = null;
         removeAllChild();
         mouseChildren = mouseEnabled = false;
         var _loc2_:String = String(_count);
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = ClassUtils.CreatInstance(_styleName);
            _loc1_.x = _loc4_ * _paddingH;
            _loc1_.x = _loc4_ * _paddingH;
            _loc1_.gotoAndStop(int(_loc2_.charAt(_loc4_)) + 1);
            addChild(_loc1_);
            _loc4_++;
         }
      }
      
      private function removeAllChild() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         if(param1 == _count)
         {
            return;
         }
         _count = param1;
         refreshView();
      }
   }
}


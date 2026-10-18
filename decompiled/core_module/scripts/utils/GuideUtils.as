package utils
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class GuideUtils
   {
      
      public static var data:Dictionary = new Dictionary(true);
      
      private static var helper:Dictionary = new Dictionary(true);
      
      public function GuideUtils()
      {
         super();
      }
      
      public static function flash(param1:DisplayObject) : DisplayObject
      {
         var _loc4_:int = 0;
         var _loc3_:MovieClip = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
         _loc3_.pos.mouseEnabled = false;
         _loc3_.mouseEnabled = false;
         var _loc2_:DisplayObjectContainer = param1.parent;
         if(_loc2_)
         {
            _loc4_ = _loc2_.getChildIndex(param1);
            _loc2_.addChildAt(_loc3_,_loc4_);
         }
         _loc3_.pos.addChild(param1);
         helper[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function stopFlash(param1:DisplayObject) : void
      {
         var _loc2_:MovieClip = helper[param1] as MovieClip;
         if(!_loc2_)
         {
            return;
         }
         helper[param1] = null;
         delete helper[param1];
         _loc2_.gotoAndStop(1);
         if(!_loc2_.parent)
         {
            return;
         }
         var _loc3_:int = _loc2_.parent.getChildIndex(_loc2_);
         _loc2_.parent.addChildAt(param1,_loc3_);
         ObjectUtils.disposeObject(_loc2_);
      }
      
      public static function setGuideStep(param1:String, param2:int) : void
      {
         if(param2 <= 0)
         {
            delete data[param1];
         }
         else
         {
            data[param1] = param2;
         }
      }
      
      public static function checkGuideStep(param1:String, param2:int) : Boolean
      {
         if(param1 in data)
         {
            return data[param1] <= param2;
         }
         return false;
      }
   }
}


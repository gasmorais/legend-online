package yishi.view.tips
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.LayerManager;
   import flash.display.DisplayObject;
   
   public class MessageTipsIIManager
   {
      
      private static var _instance:MessageTipsIIManager;
      
      private const _timeName:String = "messageTipsII";
      
      private const _showTime:int = 5;
      
      private var _objAry:Array = [];
      
      public function MessageTipsIIManager()
      {
         super();
      }
      
      public static function instance() : MessageTipsIIManager
      {
         if(_instance == null)
         {
            _instance = new MessageTipsIIManager();
         }
         return _instance;
      }
      
      public function show(param1:DisplayObject) : void
      {
         _objAry[_objAry.length] = param1;
         if(_objAry.length == 1)
         {
            showTips();
         }
      }
      
      private function tween(param1:DisplayObject) : void
      {
         var _loc2_:int = param1.y;
         if(_loc2_ > 160)
         {
            _loc2_ = 160;
         }
         TweenMax.to(param1,5,{
            "y":_loc2_,
            "onComplete":onCompleted
         });
      }
      
      private function onCompleted() : void
      {
         var _loc1_:DisplayObject = null;
         if(_objAry.length > 0)
         {
            _loc1_ = _objAry.shift();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         showTips();
      }
      
      private function showTips() : void
      {
         if(_objAry.length > 0)
         {
            LayerManager.Instance.addToLayer(_objAry[0],0,true);
            tween(_objAry[0]);
         }
      }
   }
}


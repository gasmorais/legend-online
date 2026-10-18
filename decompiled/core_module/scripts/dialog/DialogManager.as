package dialog
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class DialogManager
   {
      
      private static var _dialogList:Array = [];
      
      public function DialogManager()
      {
         super();
      }
      
      public static function showDialog(param1:Function, param2:String, param3:DisplayObject, param4:Boolean = true) : void
      {
         var _loc6_:DialogModel = new DialogModel();
         var _loc5_:DialogControl = new DialogControl(param1,param3,param4);
         _loc5_.addEventListener("dispose",__dialogDisposeHandler);
         _dialogList.push(_loc5_);
         _loc6_.setXmlResources(param2);
         _loc5_.model = _loc6_;
      }
      
      private static function __dialogDisposeHandler(param1:Event) : void
      {
         if(param1.target)
         {
            param1.target.removeEventListener("dispose",__dialogDisposeHandler);
         }
         var _loc2_:int = _dialogList.indexOf(param1.target);
         if(_loc2_ >= 0)
         {
            _dialogList.splice(_loc2_,1);
         }
      }
      
      public static function get isExistDialog() : Boolean
      {
         return _dialogList && _dialogList.length > 0;
      }
   }
}


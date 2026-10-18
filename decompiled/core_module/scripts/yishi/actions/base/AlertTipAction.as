package yishi.actions.base
{
   import yishi.actions.map.MapBaseAction;
   
   public class AlertTipAction extends MapBaseAction
   {
      
      private var _callBack:Function;
      
      private var _result:Object;
      
      private var _scene:String;
      
      public function AlertTipAction(param1:Object, param2:Function, param3:String = "", param4:int = 0)
      {
         level = param4;
         _scene = param3;
         _result = param1;
         _callBack = param2;
         super();
      }
      
      override public function update() : void
      {
         if(_callBack != null)
         {
            _callBack(_result);
         }
         dispose();
         _callBack = null;
         _result = null;
      }
      
      public function get scene() : String
      {
         return _scene;
      }
   }
}


package yishi.actions.novice
{
   import yishi.actions.map.MapBaseAction;
   
   public class NoviceNewModuleAction extends MapBaseAction
   {
      
      private var _callBack:Function;
      
      public function NoviceNewModuleAction(param1:Function)
      {
         level = 0;
         _callBack = param1;
         super();
      }
      
      override public function update() : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
         dispose();
      }
   }
}


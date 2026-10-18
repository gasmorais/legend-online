package yishi.utils
{
   import flash.events.EventDispatcher;
   import yishi.interfaces.IAction;
   
   public class AsynActionManager extends EventDispatcher
   {
      
      private var _pool:Array = [];
      
      public function AsynActionManager()
      {
         super();
      }
      
      public function update() : void
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for each(_loc2_ in _pool)
         {
            if(_loc2_.finished)
            {
               _loc2_.dispose();
               _loc1_.push(_loc2_);
            }
            else
            {
               _loc2_.update();
            }
         }
         for each(_loc2_ in _loc1_)
         {
            _pool.splice(_pool.indexOf(_loc2_),1);
         }
         _loc1_ = null;
      }
      
      public function addAction(param1:IAction) : void
      {
         if(!_pool)
         {
            return;
         }
         param1.prepare();
         _pool.push(param1);
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:IAction in _pool)
         {
            _loc1_.dispose();
         }
         _pool = null;
      }
   }
}


package yishi.resolve
{
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class TemplateResolveQueue implements IEnterFrame
   {
      
      public static var step:int = 50;
      
      private var _list:Vector.<TemplateBaseResolve>;
      
      private var _callback:Function;
      
      private var _count:int = 0;
      
      private var _total:int = 0;
      
      private var _startTime:Number;
      
      public function TemplateResolveQueue(param1:Function)
      {
         super();
         _startTime = getTimer();
         _callback = param1;
         _list = new Vector.<TemplateBaseResolve>();
      }
      
      public function addResolve(param1:TemplateBaseResolve) : void
      {
         _list.push(param1);
         param1.checkCache();
         _total += param1.totalLength;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         if(_list.length == 0)
         {
            stop();
         }
         _loc2_ = 0;
         while(_loc2_ < step)
         {
            for each(var _loc1_:TemplateBaseResolve in _list)
            {
               if(_loc1_.isComplete)
               {
                  _list.splice(_list.indexOf(_loc1_),1);
               }
               else
               {
                  _loc1_.resolveImp();
                  _count = _count + 1;
               }
            }
            _loc2_++;
         }
      }
      
      public function start() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function stop() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _callback();
         _list = null;
         _callback = null;
         _count = 0;
         _total = 0;
      }
      
      public function get progress() : int
      {
         return _count / _total * 20;
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _callback = null;
      }
   }
}


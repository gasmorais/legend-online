package battle.actions.common
{
   import battle.actions.GameBaseAction;
   
   public class SimpleScriptAction extends GameBaseAction
   {
      
      public var onPrepare:Function;
      
      public var onUpdate:Function;
      
      public var frameCount:int = 0;
      
      private var _finishFun:Function;
      
      private var _autoFinishNum:int;
      
      public function SimpleScriptAction(param1:int = 0, param2:Function = null, param3:int = -1)
      {
         super(false);
         _liftTime = param1;
         _finishFun = param2;
         _autoFinishNum = param3;
      }
      
      override public function prepare() : void
      {
         if(onPrepare != null)
         {
            onPrepare();
         }
      }
      
      override public function update() : void
      {
         frameCount = frameCount + 1;
         if(onUpdate != null)
         {
            onUpdate();
         }
         if(_autoFinishNum > 0)
         {
            if(frameCount >= _autoFinishNum)
            {
               finish();
            }
         }
      }
      
      public function finish() : void
      {
         if(_finishFun != null)
         {
            _finishFun();
         }
         _finished = true;
      }
      
      override public function dispose() : void
      {
         onPrepare = null;
         onUpdate = null;
         _finishFun = null;
         super.dispose();
      }
   }
}


package battle.effect
{
   import flash.display.DisplayObject;
   
   public class TransSceneEffect1 implements ITransSceneEffect
   {
      
      private var _complete:Function;
      
      private var _completeFlag:Boolean;
      
      private var _cells:Array;
      
      protected var _cellSize:int;
      
      private var _tweenType:int;
      
      public function TransSceneEffect1(param1:Array, param2:int)
      {
         super();
         _cells = param1;
         _cellSize = param2;
      }
      
      public function start(param1:Function) : void
      {
         _complete = param1;
         _tweenType = Math.floor(Math.random() * 3) + 1;
         for each(var _loc2_:DisplayObject in _cells)
         {
            cellEffect(_loc2_);
         }
      }
      
      protected function cellEffect(param1:DisplayObject) : void
      {
         CellEffectUtils.zoomOut(param1,onTweenComplete);
      }
      
      protected function onTweenComplete() : void
      {
         if(!_completeFlag)
         {
            _completeFlag = true;
            if(_complete != null)
            {
               _complete();
            }
            _cells = null;
            _complete = null;
         }
      }
   }
}


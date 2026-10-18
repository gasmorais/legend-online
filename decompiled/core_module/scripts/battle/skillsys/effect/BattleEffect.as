package battle.skillsys.effect
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import yishi.utils.CallBacker;
   import yishi.utils.LogicObject;
   
   public class BattleEffect extends LogicObject implements Disposeable
   {
      
      private var _callBackComplete:CallBacker = new CallBacker(this);
      
      public function BattleEffect()
      {
         super();
      }
      
      protected function commitStop() : void
      {
         callBackComplete.dispatch();
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return null;
      }
      
      public function resume() : void
      {
      }
      
      public function remove() : void
      {
         if(getDisplayObject() && getDisplayObject().stage)
         {
            getDisplayObject().parent.removeChild(getDisplayObject());
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         remove();
         if(_callBackComplete)
         {
            _callBackComplete.removeAllListeners();
         }
         _callBackComplete = null;
      }
      
      public function get callBackComplete() : CallBacker
      {
         return _callBackComplete;
      }
   }
}


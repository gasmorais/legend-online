package battle.skillsys.effect
{
   import flash.display.Sprite;
   import yishi.manager.SharedManager;
   
   public class EffectContainer extends Sprite
   {
      
      public function EffectContainer()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      public function addEffect(param1:BattleEffect, param2:int = 1) : void
      {
         var effect:BattleEffect = param1;
         var repeat:int = param2;
         var currentRepeat:int = repeat;
         effect.callBackComplete.addListener(function():void
         {
            if(currentRepeat > 0)
            {
               currentRepeat -= 1;
            }
            if(currentRepeat == 0)
            {
               removeEffect(effect);
            }
            else
            {
               effect.resume();
            }
         });
         if(effect.getDisplayObject().stage == null)
         {
            effect.resume();
         }
         if(SharedManager.instance.allowAttactedEffect)
         {
            addChild(effect.getDisplayObject());
         }
      }
      
      public function removeEffect(param1:BattleEffect) : void
      {
         if(param1)
         {
            if(param1.getDisplayObject() && param1.getDisplayObject().parent)
            {
               param1.getDisplayObject().parent.removeChild(param1.getDisplayObject());
            }
            param1.dispose();
         }
      }
   }
}


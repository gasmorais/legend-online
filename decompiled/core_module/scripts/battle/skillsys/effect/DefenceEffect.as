package battle.skillsys.effect
{
   import battle.BattleManager;
   import flash.display.MovieClip;
   
   public class DefenceEffect extends MovieClipEffect
   {
      
      public function DefenceEffect(param1:String)
      {
         var _loc2_:MovieClip = BattleManager.getInstance().resourceModel.getOrCreateInstanse(param1);
         super(_loc2_);
      }
      
      override public function resume() : void
      {
         super.resume();
      }
   }
}


package battle.skillsys.effect
{
   import battle.BattleManager;
   import flash.display.MovieClip;
   
   public class SkillEffect extends MovieClipEffect
   {
      
      public function SkillEffect(param1:String)
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


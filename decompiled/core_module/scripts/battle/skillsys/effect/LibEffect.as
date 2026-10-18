package battle.skillsys.effect
{
   import battle.BattleManager;
   import flash.display.MovieClip;
   
   public class LibEffect extends MovieClipEffect
   {
      
      private var _effectName:String;
      
      public function LibEffect(param1:String)
      {
         _effectName = param1;
         super(getEffectMovieClip());
      }
      
      private function getEffectMovieClip() : MovieClip
      {
         return BattleManager.getInstance().resourceModel.getOrCreateInstanse(_effectName) as MovieClip;
      }
   }
}


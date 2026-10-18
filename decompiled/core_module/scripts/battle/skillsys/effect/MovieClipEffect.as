package battle.skillsys.effect
{
   import battle.BattleManager;
   import battle.quicken.IQuickenEffect;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import yishi.manager.SharedManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class MovieClipEffect extends BattleEffect implements IQuickenEffect
   {
      
      protected var _movie:MovieClip;
      
      private var _quickenMovie:QuickenMovieClip;
      
      public function MovieClipEffect(param1:MovieClip)
      {
         super();
         if(BattleManager.getInstance().quickenControl)
         {
            BattleManager.getInstance().quickenControl.register(this);
         }
         _movie = param1;
         _quickenMovie = new QuickenMovieClip(_movie);
         _quickenMovie.mouseChildren = _quickenMovie.mouseEnabled = false;
         _movie.soundTransform = SharedManager.instance.getSkillSoundTransform();
         _quickenMovie.addFrameScript(_quickenMovie.totalFrames - 1,onMovieClipStop);
         if(BattleManager.getInstance().quickenModel.speed > 1)
         {
            setSpeed(BattleManager.getInstance().quickenModel.speed);
         }
      }
      
      private function onMovieClipStop() : void
      {
         _quickenMovie.stop();
         commitStop();
      }
      
      override public function resume() : void
      {
         if(_quickenMovie.totalFrames > 1)
         {
            _quickenMovie.gotoAndPlay(1);
         }
      }
      
      override public function getDisplayObject() : DisplayObject
      {
         return _quickenMovie;
      }
      
      public function setSpeed(param1:int) : void
      {
         _quickenMovie.step = param1;
      }
      
      public function get movie() : MovieClip
      {
         return _movie;
      }
      
      override public function dispose() : void
      {
         if(BattleManager.getInstance().quickenControl)
         {
            BattleManager.getInstance().quickenControl.unregister(this);
         }
         if(_quickenMovie)
         {
            _quickenMovie.dispose();
         }
         _quickenMovie = null;
         _movie = null;
         super.dispose();
      }
   }
}


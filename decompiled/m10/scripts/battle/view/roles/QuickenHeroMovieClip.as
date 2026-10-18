package battle.view.roles
{
   import battle.BattleManager;
   import battle.quicken.IQuickenEffect;
   import flash.display.MovieClip;
   import yishi.view.tools.HeroMovieClip;
   import yishi.view.tools.QuickenMovieClip;
   
   public class QuickenHeroMovieClip extends MovieClip implements IQuickenEffect
   {
      
      private var _quickenHandler:QuickenMovieClip;
      
      public function QuickenHeroMovieClip(param1:HeroMovieClip)
      {
         super();
         _quickenHandler = new QuickenMovieClip(param1,false);
         if(BattleManager.getInstance().quickenControl)
         {
            BattleManager.getInstance().quickenControl.register(this);
         }
         addChild(param1);
      }
      
      public function setSpeed(param1:int) : void
      {
         _quickenHandler.step = param1;
      }
      
      public function getHeroMovieClip() : HeroMovieClip
      {
         return _quickenHandler.getMC() as HeroMovieClip;
      }
      
      override public function play() : void
      {
         _quickenHandler.play();
      }
      
      override public function stop() : void
      {
         _quickenHandler.stop();
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         _quickenHandler.gotoAndPlay(param1);
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         _quickenHandler.gotoAndStop(param1);
      }
      
      override public function get totalFrames() : int
      {
         return _quickenHandler.totalFrames;
      }
      
      override public function get currentFrame() : int
      {
         return _quickenHandler.currentFrame;
      }
      
      override public function get currentLabels() : Array
      {
         return getHeroMovieClip().currentLabels;
      }
      
      override public function get currentLabel() : String
      {
         return getHeroMovieClip().currentLabel;
      }
      
      override public function get currentFrameLabel() : String
      {
         return getHeroMovieClip().currentFrameLabel;
      }
      
      override public function addFrameScript(... rest) : void
      {
         _quickenHandler.addFrameScript(rest[0] + 1,rest[1]);
      }
      
      public function dispose() : void
      {
         if(BattleManager.getInstance().quickenControl)
         {
            BattleManager.getInstance().quickenControl.unregister(this);
         }
         _quickenHandler.dispose();
         _quickenHandler = null;
      }
   }
}


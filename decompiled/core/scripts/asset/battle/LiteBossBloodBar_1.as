package asset.battle
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol625")]
   public dynamic class LiteBossBloodBar_1 extends MovieClip
   {
      
      public var bloodBar_mc:MovieClip;
      
      public function LiteBossBloodBar_1()
      {
         super();
         addFrameScript(64,this.frame65);
      }
      
      internal function frame65() : *
      {
         stop();
      }
   }
}


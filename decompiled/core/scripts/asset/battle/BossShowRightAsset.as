package asset.battle
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol665")]
   public dynamic class BossShowRightAsset extends MovieClip
   {
      
      public var head:MovieClip;
      
      public var blood:MovieClip;
      
      public function BossShowRightAsset()
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


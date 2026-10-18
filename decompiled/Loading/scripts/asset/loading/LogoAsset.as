package asset.loading
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol106")]
   public dynamic class LogoAsset extends MovieClip
   {
      
      public function LogoAsset()
      {
         super();
         addFrameScript(95,this.frame96);
      }
      
      internal function frame96() : *
      {
         stop();
      }
   }
}


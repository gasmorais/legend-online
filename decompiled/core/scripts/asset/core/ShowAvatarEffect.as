package asset.core
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol458")]
   public dynamic class ShowAvatarEffect extends MovieClip
   {
      
      public var contain:MovieClip;
      
      public function ShowAvatarEffect()
      {
         super();
         addFrameScript(59,this.frame60);
      }
      
      internal function frame60() : *
      {
         stop();
      }
   }
}


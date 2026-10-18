package asset.smallloading
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol151")]
   public dynamic class RegisterLoadingMc extends MovieClip
   {
      
      public var tiptxt:TextField;
      
      public var bg1:MovieClip;
      
      public var bg2:MovieClip;
      
      public function RegisterLoadingMc()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}


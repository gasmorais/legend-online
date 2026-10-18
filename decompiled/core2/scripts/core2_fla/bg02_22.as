package core2_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol500")]
   public dynamic class bg02_22 extends MovieClip
   {
      
      public function bg02_22()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}


package asset.core
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol501")]
   public dynamic class GetGoodsEffect extends MovieClip
   {
      
      public var contain:MovieClip;
      
      public function GetGoodsEffect()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      internal function frame13() : *
      {
         dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}


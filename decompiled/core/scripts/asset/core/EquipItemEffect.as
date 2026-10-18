package asset.core
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1008")]
   public dynamic class EquipItemEffect extends MovieClip
   {
      
      public var content:MovieClip;
      
      public function EquipItemEffect()
      {
         super();
         addFrameScript(13,this.frame14);
      }
      
      internal function frame14() : *
      {
         stop();
      }
   }
}


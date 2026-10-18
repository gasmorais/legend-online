package asset.core
{
   import flash.display.BitmapData;
   
   [Embed(source="/_assets/365_asset.core.headFrameImg.png")]
   public dynamic class headFrameImg extends BitmapData
   {
      
      public function headFrameImg(param1:int = 70, param2:int = 69)
      {
         super(param1,param2);
      }
   }
}


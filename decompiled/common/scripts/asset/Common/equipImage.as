package asset.common
{
   import flash.display.BitmapData;
   
   [Embed(source="/_assets/3_asset.common.equipImage.png")]
   public dynamic class equipImage extends BitmapData
   {
      
      public function equipImage(param1:int = 32, param2:int = 31)
      {
         super(param1,param2);
      }
   }
}


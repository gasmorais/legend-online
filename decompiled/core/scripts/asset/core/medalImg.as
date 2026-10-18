package asset.core
{
   import flash.display.BitmapData;
   
   [Embed(source="/_assets/62_asset.core.medalImg.png")]
   public dynamic class medalImg extends BitmapData
   {
      
      public function medalImg(param1:int = 60, param2:int = 19)
      {
         super(param1,param2);
      }
   }
}


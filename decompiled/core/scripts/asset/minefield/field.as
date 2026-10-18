package asset.minefield
{
   import flash.display.BitmapData;
   
   [Embed(source="/_assets/10_asset.minefield.field.png")]
   public dynamic class field extends BitmapData
   {
      
      public function field(param1:int = 54, param2:int = 24)
      {
         super(param1,param2);
      }
   }
}


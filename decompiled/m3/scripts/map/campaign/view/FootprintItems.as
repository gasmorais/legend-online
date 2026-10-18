package map.campaign.view
{
   import flash.display.BitmapData;
   
   public class FootprintItems
   {
      
      public static var footprints:BitmapData;
      
      private static var _isSetup:Boolean;
      
      public function FootprintItems()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(_isSetup)
         {
            return;
         }
         _isSetup = true;
      }
      
      public static function dispose() : void
      {
         _isSetup = false;
         if(footprints)
         {
            footprints.dispose();
         }
         footprints = null;
      }
   }
}


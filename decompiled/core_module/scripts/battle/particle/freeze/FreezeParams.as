package battle.particle.freeze
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class FreezeParams
   {
      
      public var target:DisplayObject;
      
      public var direction:int;
      
      public var scaleRate:Number;
      
      public var particleArray:Array;
      
      public var particleBM:Bitmap;
      
      public var particleBMwidth:int;
      
      public var particleBMheight:int;
      
      public var scrapArray:Vector.<ScrapShape>;
      
      public var currentIndex:int;
      
      public var blackStep:int;
      
      public var shakeFlag:int;
      
      public function FreezeParams(param1:DisplayObject, param2:int, param3:Number)
      {
         super();
         target = param1;
         direction = param2;
         scaleRate = param3;
         particleBM = new Bitmap();
         currentIndex = 0;
         shakeFlag = -1;
      }
      
      public function dispose() : void
      {
         target = null;
         particleBM.bitmapData.dispose();
         particleBM = null;
         particleArray.splice(0,particleArray.length);
         particleArray = null;
         for each(var _loc1_:ScrapShape in scrapArray)
         {
            _loc1_.dispose();
         }
         scrapArray.splice(0,scrapArray.length);
         scrapArray = null;
      }
   }
}


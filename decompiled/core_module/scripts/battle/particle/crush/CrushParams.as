package battle.particle.crush
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public class CrushParams
   {
      
      public var target:DisplayObject;
      
      public var targetBitmapData:BitmapData;
      
      public var direction:int;
      
      public var scaleRate:Number;
      
      public var particleArray:Array;
      
      public var particleBM:Bitmap;
      
      public var particleBMwidth:int;
      
      public var particleBMheight:int;
      
      public var currentIndex:int;
      
      public var blackStep:int;
      
      public var shakeFlag:int;
      
      public function CrushParams(param1:DisplayObject, param2:int, param3:Number)
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
         if(particleBM.parent)
         {
            particleBM.parent.removeChild(particleBM);
         }
         particleBM.bitmapData.dispose();
         particleBM = null;
         particleArray.splice(0,particleArray.length);
         particleArray = null;
      }
   }
}


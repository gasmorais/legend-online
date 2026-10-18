package battle.data
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public class BattleBackGroundData
   {
      
      public var asset:DisplayObject;
      
      public var normalAsset:BitmapData;
      
      public var blurAsset:DisplayObject;
      
      public var moveCoefficient:Number;
      
      public var repeat:Boolean;
      
      public var moveSpeed:Number;
      
      public var transparent:Boolean;
      
      public function BattleBackGroundData()
      {
         super();
      }
   }
}


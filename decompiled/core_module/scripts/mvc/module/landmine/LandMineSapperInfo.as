package mvc.module.landmine
{
   import flash.geom.Point;
   
   public class LandMineSapperInfo
   {
      
      public var userId:int;
      
      public var nickName:String;
      
      public var arm:String;
      
      public var cloth:String;
      
      public var wing:String;
      
      public var hat:String;
      
      public var fashionArm:String;
      
      public var fashionCloth:String;
      
      public var hide:Boolean;
      
      public var posX:int = -1;
      
      public var posY:int = -1;
      
      public var state:int = 0;
      
      public var sex:int;
      
      public var job:int;
      
      public var templateId:int;
      
      public var isDragonTalker:Boolean;
      
      public var battleBeastId:int;
      
      public var index:int = 0;
      
      public var targetPosition:Point;
      
      public var centerPosition:Point;
      
      public function LandMineSapperInfo()
      {
         super();
      }
   }
}


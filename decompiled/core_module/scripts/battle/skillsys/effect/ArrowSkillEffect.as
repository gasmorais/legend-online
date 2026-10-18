package battle.skillsys.effect
{
   import flash.geom.Point;
   
   public class ArrowSkillEffect extends SkillEffect
   {
      
      public var startPoint:Point;
      
      public var travelPoints:Vector.<Point>;
      
      public var lastPoint:Point;
      
      public var travelDistance:Number = 0;
      
      public var rippleCount:int;
      
      public function ArrowSkillEffect(param1:String)
      {
         super(param1);
      }
   }
}


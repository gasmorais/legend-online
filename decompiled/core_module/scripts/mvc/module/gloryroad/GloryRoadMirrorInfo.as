package mvc.module.gloryroad
{
   public class GloryRoadMirrorInfo
   {
      
      public var userid:int;
      
      public var grade:int;
      
      public var job:int;
      
      public var sexs:int;
      
      public var fightCapacity:int;
      
      public var nickName:String;
      
      public var phyAttack:int;
      
      public var phyDefence:int;
      
      public var magAttack:int;
      
      public var magDefence:int;
      
      public var forceHit:int;
      
      public var penetrate:int;
      
      public var parry:int;
      
      public var hp:int;
      
      public var stunAttr:int;
      
      public var conat:int;
      
      public var reduceResi:int;
      
      public var fireResi:int;
      
      public var waterResi:int;
      
      public var electResi:int;
      
      public var windResi:int;
      
      public var darkResi:int;
      
      public var lightResi:int;
      
      public var arm:String;
      
      public var cloth:String;
      
      public var wing:String;
      
      public var hat:String;
      
      public var hideFashion:Boolean;
      
      public var fashionArm:String;
      
      public var fashionCloth:String;
      
      public var isDragonTalker:Boolean;
      
      public var battleBeastId:int;
      
      public function GloryRoadMirrorInfo()
      {
         super();
      }
      
      public function getAttValues() : Array
      {
         return [reduceResi,fireResi,waterResi,windResi,electResi,lightResi,darkResi,phyAttack,phyDefence,magAttack,magDefence,hp];
      }
   }
}


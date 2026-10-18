package battle.view.buffer
{
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.SkillEffect;
   
   public class BufferIconFactory
   {
      
      private static var _instance:BufferIconFactory;
      
      public function BufferIconFactory()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : BufferIconFactory
      {
         return _instance || new BufferIconFactory();
      }
      
      public function getBufferEffectII(param1:String) : BattleEffect
      {
         var _loc2_:* = null;
         return new SkillEffect(param1);
      }
      
      public function getBufferEffect(param1:int) : BattleEffect
      {
         var _loc3_:* = null;
         var _loc2_:int = 1;
         switch(param1 - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               _loc2_ = param1;
         }
         return new SkillEffect("slg.resource.BufferEffect" + _loc2_);
      }
   }
}


package battle.factorys
{
   import battle.BattleManager;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.MovieClipEffect;
   import battle.skillsys.effect.SkillEffect;
   import battle.utils.BattleUtils;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class ChargeSkillEffectFactory
   {
      
      public function ChargeSkillEffectFactory()
      {
         super();
      }
      
      public static function createEffect(param1:int) : BattleEffect
      {
         var _loc3_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = "slg.resource.effect.ChargeEffect1";
               break;
            case 1:
               _loc3_ = "slg.resource.effect.ChargeEffect1";
               break;
            case 2:
               _loc3_ = "slg.resource.effect.ChargeEffect3";
               break;
            default:
               return null;
         }
         var _loc2_:MovieClip = BattleManager.getInstance().resourceModel.getOrCreateInstanse(_loc3_) as MovieClip;
         _loc2_.x = 160;
         return new MovieClipEffect(_loc2_);
      }
      
      public static function createHitEffect(param1:int) : BattleEffect
      {
         var _loc3_:String = null;
         switch(param1 - 1)
         {
            case 0:
               return null;
            case 1:
               return null;
            case 2:
               _loc3_ = "slg.resource.effect.ChargeEffect3_SJ";
               var _loc2_:SkillEffect = new SkillEffect(_loc3_);
               var _loc4_:Point = BattleUtils.getRightTeamCenterPoint();
               _loc2_.getDisplayObject().x = _loc4_.x;
               _loc2_.getDisplayObject().y = _loc4_.y;
               return _loc2_;
            default:
               return null;
         }
      }
   }
}


package battle.view.battleresult
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   
   public class VicotyBattleResultViewSimple extends BaseBattleResultView
   {
      
      public function VicotyBattleResultViewSimple()
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.VictoryAssetII2");
         super(_loc1_);
      }
      
      override public function get width() : Number
      {
         return 0;
      }
      
      override public function get height() : Number
      {
         return 360;
      }
   }
}


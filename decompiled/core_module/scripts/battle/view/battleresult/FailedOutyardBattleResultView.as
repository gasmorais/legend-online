package battle.view.battleresult
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   
   public class FailedOutyardBattleResultView extends BaseBattleResultView
   {
      
      private var _tween:TweenMax;
      
      public function FailedOutyardBattleResultView()
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.FailedAsset3");
         super(_loc1_);
         mc.addFrameScript(14,playIcon);
      }
      
      private function playIcon() : void
      {
         if(mc && data && mc.txtMc && mc.txtMc.experienceTxt && mc.experienceMc)
         {
            mc.txtMc.experienceTxt.text = String(data[3]) + "%";
            mc.experienceMc.gotoAndStop(100 - data[3]);
            mc.addFrameScript(14,null);
         }
      }
      
      override public function get width() : Number
      {
         return 0;
      }
      
      override public function get height() : Number
      {
         return 350;
      }
   }
}


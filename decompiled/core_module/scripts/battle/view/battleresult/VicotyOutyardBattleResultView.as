package battle.view.battleresult
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   
   public class VicotyOutyardBattleResultView extends BaseBattleResultView
   {
      
      public var experience:int;
      
      private var _tween:TweenMax;
      
      public function VicotyOutyardBattleResultView()
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.VictoryAsset3");
         super(_loc1_);
      }
      
      override protected function updateStart() : void
      {
         super.updateStart();
         if(_tween)
         {
            _tween.currentProgress = 1;
         }
         if(data)
         {
            _tween = TweenMax.to(this,0.5,{
               "experience":data[2],
               "onUpdate":onChangeUpdate,
               "onComplete":tweenComplete
            });
         }
      }
      
      private function onChangeUpdate() : void
      {
         if(mc)
         {
            mc.experienceTxt.text = experience;
         }
      }
      
      private function tweenComplete() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
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


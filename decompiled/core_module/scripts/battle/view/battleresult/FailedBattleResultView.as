package battle.view.battleresult
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseIconView;
   
   public class FailedBattleResultView extends BaseBattleResultView
   {
      
      public var experience:int;
      
      private var _petIcon:BaseIconView;
      
      private var _tween:TweenMax;
      
      public function FailedBattleResultView()
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.battle.FailedAsset2");
         super(_loc1_);
         mc.addFrameScript(18,playIcon);
      }
      
      override protected function updateStart() : void
      {
         super.updateStart();
         if(_tween)
         {
            _tween.currentProgress = 1;
         }
         playIconEnd();
         if(data)
         {
            _tween = TweenMax.to(this,0.5,{
               "experience":data[0],
               "onUpdate":onChangeUpdate,
               "onComplete":tweenComplete
            });
         }
      }
      
      private function playIcon() : void
      {
         if(mc && mc.icon)
         {
            _tween = TweenMax.to(mc.icon,0.4,{
               "alpha":1,
               "x":-120,
               "onComplete":tweenComplete
            });
         }
      }
      
      private function playIconEnd() : void
      {
         if(mc && mc.icon)
         {
            mc.icon.alpha = 1;
            mc.icon.x = -120;
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
      
      private function onChangeUpdate() : void
      {
         if(mc)
         {
            mc.experienceTxt.text = experience;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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


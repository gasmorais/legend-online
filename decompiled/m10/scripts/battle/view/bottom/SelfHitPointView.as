package battle.view.bottom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import mainBar.StripView;
   import manager.LanguageMgr;
   
   public class SelfHitPointView extends Component
   {
      
      private var _hitPointMc:MovieClip;
      
      private var _tipView:StripView;
      
      private var _heroHitPointValue:int;
      
      public function SelfHitPointView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _hitPointMc = ComponentFactory.Instance.creat("asset.battle.HitPointMC");
         _tipView = ComponentFactory.Instance.creatCustomObject("battle.HitPointTip");
         _hitPointMc.gotoAndStop(1);
         _tipView.graphics.beginFill(0,0);
         _tipView.graphics.drawRect(0,-5,118,30);
         _tipView.graphics.endFill();
         _tipView.tipData = LanguageMgr.GetTranslation("battle.view.bottom.SelfHitPointView.tipView.tipData01") + LanguageMgr.GetTranslation("battle.view.bottom.SelfHitPointView.tipView.tipData02");
         addChild(_hitPointMc);
         addChild(_tipView);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_hitPointMc);
         _hitPointMc = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function addEvent() : void
      {
      }
      
      public function removeEvent() : void
      {
      }
      
      public function updateHeroHitPoint(param1:int) : void
      {
         if(_heroHitPointValue == param1)
         {
            return;
         }
         _heroHitPointValue = param1;
         _hitPointMc.gotoAndStop(_heroHitPointValue + 1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}


package battle.view.bottom
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class SelfBloodView extends Component
   {
      
      private var _container:Sprite;
      
      private var _heroHpNumContainer:Sprite;
      
      private var _heroHpNumBmd:BitmapData;
      
      private var _heroHpNumRect:Rectangle;
      
      private var _heroHpValue:int;
      
      private var _bloodPool:VesselBallComp;
      
      private var _tipView:StripView;
      
      private var _x:int;
      
      private var _y:int;
      
      public function SelfBloodView(param1:Sprite, param2:int = -338, param3:int = -116, param4:int = 0)
      {
         super();
         _container = param1;
         _x = param2;
         _y = param3;
         if(param4 == 1)
         {
            _heroHpNumRect = new Rectangle(-239,-12,93,18);
         }
         else
         {
            _heroHpNumRect = new Rectangle(-340,-14,88,18);
         }
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:Bitmap = ComponentFactory.Instance.creat("asset.battle.SelfHpNumAsset");
         _heroHpNumBmd = _loc4_.bitmapData;
         _heroHpNumContainer = new Sprite();
         var _loc3_:MovieClip = ComponentFactory.Instance.creat("asset.battle.VesselPoolLineMC");
         _loc3_.alpha = 0.6;
         var _loc2_:ColorTransform = new ColorTransform(0.7,0,0);
         _loc3_.transform.colorTransform = _loc2_;
         _bloodPool = new VesselBallComp(battleModel.selfHero.totalBloodA,battleModel.selfHero.bloodA,_loc3_);
         _bloodPool.getView().x = _x;
         _bloodPool.getView().y = _y;
         _container.addChildAt(_bloodPool.getView(),0);
         _tipView = ComponentFactory.Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_:Number = 46.5;
         _tipView.graphics.beginFill(0,0);
         _tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         _tipView.graphics.endFill();
         _tipView.x = _bloodPool.getView().x;
         _tipView.y = _bloodPool.getView().y;
         _tipView.tipData = LanguageMgr.GetTranslation("battle.view.bottomSelfBloodView.tip");
         _container.addChild(_tipView);
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(battleModel.isChildBattle)
         {
            return;
         }
         var _loc2_:Number = Number(battleModel.getMyHeroLeftHp());
         updateHeroHp(_loc2_);
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(_bloodPool)
         {
            _bloodPool.setRotation(param1);
         }
      }
      
      public function showBall(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("asset.battle.BloodPoolBallMC");
         var _loc3_:SimpleBitmapMovieClip = new SimpleBitmapMovieClip(MovieClip(_loc2_),"asset.battle.BloodPoolBallMC");
         _bloodPool.showBall(_loc3_,param1);
      }
      
      public function updateHeroHp(param1:int) : void
      {
         if(_heroHpValue == param1)
         {
            return;
         }
         _heroHpValue = param1;
         _bloodPool.max = battleModel.selfHero.totalBloodA;
         NumberViewUtils.getNumberView(_heroHpValue,_heroHpNumContainer,_heroHpNumBmd,15,16,10,15,"0123456789.",1);
         layoutHeroHpNum();
         _bloodPool.update(_heroHpValue);
      }
      
      private function layoutHeroHpNum() : void
      {
         _heroHpNumContainer.x = _heroHpNumRect.x + (_heroHpNumRect.width - _heroHpNumContainer.width) * 0.5;
         _heroHpNumContainer.y = _heroHpNumRect.y - 5;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function get heroHpNumContainer() : Sprite
      {
         return _heroHpNumContainer;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_heroHpNumBmd);
         _heroHpNumBmd = null;
         ObjectUtils.disposeObject(_heroHpNumContainer);
         _heroHpNumContainer = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         if(_bloodPool)
         {
            if(_bloodPool.getView() && _bloodPool.getView().parent)
            {
               _bloodPool.getView().parent.removeChild(_bloodPool.getView());
            }
            _bloodPool.dispose();
            _bloodPool = null;
         }
      }
   }
}


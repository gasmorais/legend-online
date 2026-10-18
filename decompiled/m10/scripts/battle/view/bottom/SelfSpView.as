package battle.view.bottom
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class SelfSpView
   {
      
      private var _container:Sprite;
      
      private var _spMax:Number = 0;
      
      private var _heroSpNumContainer:Sprite;
      
      private var _heroSpNumBmd:BitmapData;
      
      private var _heroSpNumRect:Rectangle;
      
      private var _heroSpValue:int = -1;
      
      private var _spPool:VesselBallComp;
      
      private var _tipView:StripView;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _visible:Boolean;
      
      public function SelfSpView(param1:Sprite, param2:Number = 100, param3:int = 246, param4:int = -115)
      {
         super();
         _container = param1;
         _spMax = param2;
         _x = param3;
         _y = param4;
         _heroSpNumRect = new Rectangle(248,-14,88,18);
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creat("asset.battle.SelfHpNumAsset");
         _heroSpNumBmd = _loc3_.bitmapData;
         _heroSpNumContainer = new Sprite();
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.battle.VesselPoolLineMC");
         _loc2_.alpha = 0.6;
         var _loc4_:int = int(battleModel.selfHero.awaken);
         _spPool = new VesselBallComp(_spMax,_loc4_,_loc2_);
         _spPool.getView().x = _x;
         _spPool.getView().y = _y;
         _container.addChildAt(_spPool.getView(),0);
         _tipView = ComponentFactory.Instance.creatCustomObject("battle.VesselBallTip");
         var _loc1_:Number = 46.5;
         _tipView.graphics.beginFill(0,0);
         _tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         _tipView.graphics.endFill();
         _tipView.x = _spPool.getView().x;
         _tipView.y = _spPool.getView().y;
         _tipView.tipData = LanguageMgr.GetTranslation("battle.view.bottom.SelfSpView.tipView.tipData01") + LanguageMgr.GetTranslation("battle.view.bottom.SelfSpView.tipView.tipData02");
         _container.addChild(_tipView);
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(_spPool)
         {
            _spPool.setRotation(param1);
         }
      }
      
      public function showBall(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("asset.battle.AngerPoolBallMC");
         var _loc3_:SimpleBitmapMovieClip = new SimpleBitmapMovieClip(MovieClip(_loc2_),"asset.battle.AngerPoolBallMC");
         _spPool.showBall(_loc3_,param1);
      }
      
      public function updateHeroSp(param1:int) : void
      {
         if(_heroSpValue == param1)
         {
            return;
         }
         _heroSpValue = param1;
         NumberViewUtils.getNumberView(_heroSpValue,_heroSpNumContainer,_heroSpNumBmd,15,16,10,15,"0123456789.",1);
         layoutHeroHpNum();
         _spPool.update(_heroSpValue);
      }
      
      private function layoutHeroHpNum() : void
      {
         _heroSpNumContainer.x = _heroSpNumRect.x + (_heroSpNumRect.width - _heroSpNumContainer.width) * 0.5;
         _heroSpNumContainer.y = _heroSpNumRect.y - 5;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
         if(_heroSpNumContainer)
         {
            _heroSpNumContainer.visible = param1;
         }
         if(_spPool && _spPool.getView())
         {
            _spPool.getView().visible = param1;
         }
         if(_tipView)
         {
            _tipView.visible = param1;
         }
      }
      
      public function get heroSpNumContainer() : Sprite
      {
         return _heroSpNumContainer;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_heroSpNumBmd);
         _heroSpNumBmd = null;
         ObjectUtils.disposeObject(_heroSpNumContainer);
         _heroSpNumContainer = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         if(_spPool)
         {
            if(_spPool.getView() && _spPool.getView().parent)
            {
               _spPool.getView().parent.removeChild(_spPool.getView());
            }
            _spPool.dispose();
            _spPool = null;
         }
      }
   }
}


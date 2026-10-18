package battle.view.bottom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.utils.NumberViewUtils;
   
   public class ChildAwakenView
   {
      
      public static const BALL_WIDTH:Number = 150;
      
      private var _container:Sprite;
      
      private var _awakenMax:Number = 0;
      
      private var _childAwakenNumContainer:Sprite;
      
      private var _childAwakenNumBmd:BitmapData;
      
      private var _childAwakenNumRect:Rectangle;
      
      private var _childAwakenValue:int = -1;
      
      private var _awakenMovie:MovieClip;
      
      private var _tipView:StripView;
      
      public function ChildAwakenView(param1:Sprite, param2:Number = 100)
      {
         super();
         _container = param1;
         _awakenMax = param2;
         _childAwakenNumRect = new Rectangle(190,-95,88,18);
         initView();
         updateChildAwaken(0);
      }
      
      private function initView() : void
      {
         var _loc2_:Bitmap = ComponentFactory.Instance.creat("asset.battle.SelfHpNumAsset");
         _childAwakenNumBmd = _loc2_.bitmapData;
         _childAwakenNumContainer = new Sprite();
         _awakenMovie = ComponentFactory.Instance.creatCustomObject("asset.battle.ChildAwakenMC");
         _awakenMovie.x = 214;
         _awakenMovie.y = -152;
         _container.addChildAt(_awakenMovie,0);
         _tipView = ComponentFactory.Instance.creatCustomObject("battle.ChildAwakenTip");
         var _loc1_:Number = 75;
         _tipView.graphics.beginFill(0,0);
         _tipView.graphics.drawCircle(_loc1_,_loc1_,_loc1_);
         _tipView.graphics.endFill();
         _tipView.x = _awakenMovie.x;
         _tipView.y = _awakenMovie.y;
         _tipView.tipData = LanguageMgr.GetTranslation("battle.view.bottom.ChildAwakenView.tipView.tipData01") + " " + LanguageMgr.GetTranslation("battle.view.bottom.ChildAwakenView.tipView.tipData02");
         _container.addChild(_tipView);
      }
      
      public function updateChildAwaken(param1:int) : void
      {
         if(_childAwakenValue == param1)
         {
            return;
         }
         _childAwakenValue = param1;
         NumberViewUtils.getNumberView(_childAwakenValue,_childAwakenNumContainer,_childAwakenNumBmd,15,16,10,15,"0123456789.",1);
         layoutHeroHpNum();
         var _loc2_:int = Math.ceil(_childAwakenValue * 100 / _awakenMax);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         gotoAndStop(_loc2_);
         if(_childAwakenValue >= _awakenMax)
         {
            effectVisible = true;
         }
         else
         {
            effectVisible = false;
         }
      }
      
      private function gotoAndStop(param1:int) : void
      {
         if(_awakenMovie)
         {
            _awakenMovie.gotoAndStop(param1);
            _awakenMovie["content"]["bg"].gotoAndStop(param1);
         }
      }
      
      public function set effectVisible(param1:Boolean) : void
      {
         if(_awakenMovie)
         {
            _awakenMovie["effect"].visible = param1;
         }
      }
      
      private function layoutHeroHpNum() : void
      {
         _childAwakenNumContainer.x = _childAwakenNumRect.x + (_childAwakenNumRect.width - _childAwakenNumContainer.width) * 0.5;
         _childAwakenNumContainer.y = _childAwakenNumRect.y - 5;
      }
      
      public function get childAwakenNumContainer() : Sprite
      {
         return _childAwakenNumContainer;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_childAwakenNumBmd);
         _childAwakenNumBmd = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_childAwakenNumContainer);
         _childAwakenNumContainer = null;
         ObjectUtils.disposeViolentMc(_awakenMovie);
         _awakenMovie = null;
      }
   }
}


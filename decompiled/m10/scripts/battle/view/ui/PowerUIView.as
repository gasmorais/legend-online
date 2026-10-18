package battle.view.ui
{
   import battle.BattleManager;
   import battle.utils.Helpers;
   import battle.view.animation.SpStripIncreaseAnimation;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import yishi.events.RoleEvent;
   
   public class PowerUIView extends Component
   {
      
      private var _asset:MovieClip;
      
      private var _powerStripAsset:MovieClip;
      
      private var _stripView:StripUIView;
      
      private var _frontView:DisplayObject;
      
      private var _spIncreaseAnimation:SpStripIncreaseAnimation;
      
      public function PowerUIView()
      {
         super();
         SpTip;
         initView();
         addEvent();
         tipStyle = "battle.view.ui.SpTip";
         tipDirctions = "1";
         tipGapV = 0;
         isFollowMouse = false;
         onHeroSpChanged(null);
      }
      
      private function addEvent() : void
      {
         BattleManager.getInstance().battleModel.selfHero.addEventListener("sp",onHeroSpChanged);
      }
      
      private function onHeroSpChanged(param1:RoleEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int;
         var _loc5_:int = _loc4_ = int(BattleManager.getInstance().battleModel.selfHero.sp);
         if(param1)
         {
            _loc2_ = Boolean(param1.data.increase);
            _loc3_ = Boolean(param1.data.showTip);
            _loc5_ = int(param1.data.sp);
         }
         if(!_spIncreaseAnimation || !_spIncreaseAnimation.isRunning())
         {
            _loc6_ = _loc4_ - _stripView.currentValue;
            _loc5_ -= _stripView.currentValue;
            spChangedHandler(_stripView.currentValue,_loc6_,_loc2_,_loc3_,_loc5_);
         }
         else
         {
            _loc6_ = _loc4_ - _spIncreaseAnimation.getDestCurrent();
            _loc5_ -= _spIncreaseAnimation.getDestCurrent();
            spChangedHandler(_spIncreaseAnimation.getDestCurrent(),_loc6_,_loc2_,_loc3_,_loc5_);
            _spIncreaseAnimation.dispose();
            _spIncreaseAnimation = null;
         }
      }
      
      private function initView() : void
      {
         _asset = ClassUtils.CreatInstance("asset.battle.PowerUIViewAsset");
         addChild(_asset);
         _powerStripAsset = ClassUtils.CreatInstance("asset.battle.PowerStripAsset");
         var _loc1_:int = int(BattleManager.getInstance().battleModel.selfHero.sp);
         _stripView = new StripUIView(_powerStripAsset,100,_loc1_,0,true,true);
         _stripView.currentValue = 0;
         addChild(_stripView);
         _frontView = ComponentFactory.Instance.creatBitmap("asset.battle.PowerUIFrontView");
         _frontView.x = 66;
         _frontView.y = 10;
         addChild(_frontView);
         Helpers.setChildPos(_stripView,_asset.power_pos);
      }
      
      public function getStripCurrentX() : Number
      {
         return _stripView.maskWidth;
      }
      
      private function spChangedHandler(param1:int, param2:int, param3:Boolean = true, param4:Boolean = true, param5:int = 0) : void
      {
         if(param2 > 0)
         {
            spIncrease(param1,param2,param3);
            if(param4)
            {
               addChild(new AddSpNumAnimation(param5));
            }
         }
         else if(param2 < 0)
         {
            _stripView.currentValue = BattleManager.getInstance().battleModel.selfHero.sp;
         }
         tipData = BattleManager.getInstance().battleModel.selfHero.sp + "";
      }
      
      private function spIncrease(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         if(param1 + param2 > _stripView.maxValue)
         {
            param2 = _stripView.maxValue - param1;
         }
         if(param2 > 0)
         {
            if(param3)
            {
               addSnIncreaseAnimation(param1,param2);
            }
            else
            {
               _loc4_ = param1 + param2;
               if(_loc4_ > 100)
               {
                  _loc4_ = 100;
               }
               _stripView.currentValue = _loc4_;
            }
         }
      }
      
      private function addSnIncreaseAnimation(param1:int, param2:int) : void
      {
         _spIncreaseAnimation = new SpStripIncreaseAnimation(this,_stripView);
         _spIncreaseAnimation.start(param1,param2);
      }
      
      override public function dispose() : void
      {
         BattleManager.getInstance().battleModel.selfHero.removeEventListener("sp",onHeroSpChanged);
         ObjectUtils.disposeViolentMc(_asset);
         _asset = null;
         ObjectUtils.disposeViolentMc(_powerStripAsset);
         _powerStripAsset = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_frontView);
         _frontView = null;
         _spIncreaseAnimation.dispose();
         _spIncreaseAnimation = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

import com.greensock.TweenLite;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import yishi.utils.NumberViewUtils;
import yishi.utils.TimerUtils;

class AddSpNumAnimation extends Sprite
{
   
   private var _titleBm:Bitmap;
   
   private var _numView:Sprite;
   
   private var _numBitmapData:BitmapData;
   
   private var _num:int;
   
   public function AddSpNumAnimation(param1:int)
   {
      super();
      _num = param1;
      initView();
      tween();
   }
   
   private function initView() : void
   {
      _titleBm = ComponentFactory.Instance.creatBitmap("asset.battle.PowerUIAddSp");
      addChild(_titleBm);
      if(!_numBitmapData)
      {
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_01");
      }
      _numView = new Sprite();
      NumberViewUtils.refreshValue(_num,_numView,_numBitmapData,13,17,14,13);
      _numView.x = _titleBm.width;
      _numView.y = 2;
      addChild(_numView);
      this.x = 230;
      this.y = -73;
      alpha = 0;
   }
   
   private function tween() : void
   {
      TweenLite.to(this,0.5,{
         "y":this.y - 43,
         "alpha":1,
         "onComplete":onTweenComplete
      });
   }
   
   private function onTweenComplete() : void
   {
      TweenLite.killTweensOf(this);
      TimerUtils.setTimeout(removeView,1000);
   }
   
   private function removeView() : void
   {
      ObjectUtils.disposeObject(_numBitmapData);
      _numBitmapData = null;
      ObjectUtils.disposeObject(_titleBm);
      _titleBm = null;
      ObjectUtils.removeChildAllChildren(_numView);
      _numView = null;
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
}

package battle.view.ui
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import yishi.utils.TimerUtils;
   
   public class StripUIView extends Sprite implements IHpStrip
   {
      
      private var _maxValue:Number;
      
      private var _currentValue:Number;
      
      private var _backBackGround:DisplayObject;
      
      private var _backRect:Rectangle;
      
      private var _asset:MovieClip;
      
      private var _colorOffset:uint;
      
      private var _hasBackGroundFade:Boolean;
      
      private var _maskWidth:Number;
      
      private var _twoWayTween:Boolean;
      
      private var _changeFlag:int;
      
      private var _background:Bitmap;
      
      private var _fullDefault:Boolean;
      
      private var _needLight:Boolean;
      
      private var _lightMc:MovieClip;
      
      public function StripUIView(param1:MovieClip, param2:Number = 0, param3:int = 0, param4:uint = 0, param5:Boolean = true, param6:Boolean = false, param7:Bitmap = null, param8:Boolean = true, param9:Boolean = false)
      {
         super();
         _asset = param1;
         _maxValue = param2;
         _currentValue = param3;
         _maskWidth = _asset.width;
         _colorOffset = param4;
         _hasBackGroundFade = param5;
         _twoWayTween = param6;
         _background = param7;
         _fullDefault = param8;
         _needLight = param9;
         addChild(_asset);
         if(_needLight)
         {
            _lightMc = ComponentFactory.Instance.creat("asset.battle.BossHpStripLightMc");
            _lightMc.height = param1.height;
            _lightMc.y -= 2;
         }
         TimerUtils.setTimeout(delayInitFade,30);
      }
      
      public function initCurrentValue(param1:Number) : void
      {
         if(_currentValue == param1)
         {
            return;
         }
         _changeFlag = _currentValue > param1 ? -1 : 1;
         _currentValue = param1;
         refreshView(false);
      }
      
      private function delayInitFade() : void
      {
         if(!_asset || _asset.width == 0 || _asset.height == 0)
         {
            return;
         }
         initBackGround(_background);
         refreshView(false);
      }
      
      private function initBackGround(param1:Bitmap) : void
      {
         var _loc2_:BitmapData = null;
         if(param1)
         {
            _backBackGround = param1;
         }
         else
         {
            _loc2_ = new BitmapData(_asset.width,_asset.height,true,16777215);
            _loc2_.draw(_asset,null,new ColorTransform(1,1,1,1,(_colorOffset & 0xFF0000) >>> 16,(_colorOffset & 0xFF00) >>> 8,_colorOffset & 0xFF));
            _backBackGround = new Bitmap(_loc2_);
            _backBackGround.alpha = 0.5;
         }
         _asset.addChildAt(_backBackGround,0);
         _backBackGround.scrollRect = _backRect = new Rectangle(0,0,_backBackGround.width,_backBackGround.height);
      }
      
      private function refreshView(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(_maxValue <= 0)
         {
            if(!_fullDefault && _backRect)
            {
               _asset.maskmc.width = 0;
               _backRect.width = 0;
               _backBackGround.scrollRect = _backRect;
            }
         }
         else
         {
            _loc2_ = _currentValue / _maxValue * _maskWidth;
            if(_loc2_ > _maskWidth)
            {
               _loc2_ = _maskWidth;
            }
            _loc3_ = _loc2_ - 5;
            _asset.maskmc.width = _loc2_;
            if(_needLight && _lightMc)
            {
               _lightMc.visible = _maskWidth - _loc2_ > 5;
               TweenLite.killTweensOf(_lightMc);
               if(_lightMc.parent == null)
               {
                  addChild(_lightMc);
               }
               TweenLite.to(_lightMc,0.5,{
                  "x":_loc3_,
                  "delay":1,
                  "onUpdate":tweenUpdate2,
                  "onComplete":tweenComplete2
               });
            }
            if(_backBackGround)
            {
               TweenLite.killTweensOf(_backRect);
               if(param1)
               {
                  TweenLite.to(_backRect,0.5,{
                     "width":_loc2_,
                     "delay":1,
                     "onUpdate":tweenUpdate1
                  });
               }
               else
               {
                  _backRect.width = _asset.maskmc.width;
                  if(_lightMc)
                  {
                     _lightMc.x = _loc3_;
                  }
                  _backBackGround.scrollRect = _backRect;
               }
            }
         }
      }
      
      public function resetView() : void
      {
         _backRect.width = _maskWidth;
         _backBackGround.scrollRect = _backRect;
      }
      
      public function tweenUpdate1() : void
      {
         _backBackGround.scrollRect = _backRect;
      }
      
      private function tweenUpdate2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         if(_lightMc && _lightMc.x <= 0)
         {
            _loc1_ = _currentValue / _maxValue * _maskWidth;
            if(_loc1_ > _maskWidth)
            {
               _loc1_ = _maskWidth;
            }
            _loc2_ = _loc1_ - 5;
            TweenLite.killTweensOf(_lightMc);
            if(_lightMc && _lightMc.parent)
            {
               _lightMc.parent.removeChild(_lightMc);
            }
            _lightMc.visible = _maskWidth - _loc1_ > 5;
            _lightMc.x = _maskWidth - 5;
            TweenLite.to(_lightMc,0.5,{
               "x":_loc2_,
               "delay":1,
               "onUpdate":tweenUpdate2,
               "onComplete":tweenComplete2
            });
         }
      }
      
      private function tweenComplete2() : void
      {
         if(_lightMc)
         {
            TweenLite.killTweensOf(_lightMc);
            _lightMc.gotoAndPlay(1);
         }
      }
      
      public function get maskWidth() : Number
      {
         return _asset.maskmc.width;
      }
      
      public function get maxValue() : Number
      {
         return _maxValue;
      }
      
      public function set maxValue(param1:Number) : void
      {
         if(_maxValue == param1)
         {
            return;
         }
         _maxValue = param1;
         _currentValue = _currentValue < 0 ? 0 : _currentValue;
         _currentValue = _currentValue > _maxValue ? _maxValue : _currentValue;
         refreshView(false);
      }
      
      public function get currentValue() : Number
      {
         return _currentValue;
      }
      
      public function set currentValue(param1:Number) : void
      {
         if(_currentValue == param1)
         {
            return;
         }
         _changeFlag = _currentValue > param1 ? -1 : 1;
         _currentValue = param1;
         refreshView();
      }
      
      public function get asset() : MovieClip
      {
         return _asset;
      }
      
      public function getView() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_asset);
         _asset = null;
         ObjectUtils.disposeObject(_backBackGround);
         _backBackGround = null;
         ObjectUtils.disposeObject(_background);
         _background = null;
         if(_backRect)
         {
            TweenLite.killTweensOf(_backRect);
         }
         _backRect = null;
         if(_lightMc)
         {
            TweenLite.killTweensOf(_lightMc);
         }
         _lightMc = null;
         ObjectUtils.disposeViolentMc(_lightMc);
         _lightMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


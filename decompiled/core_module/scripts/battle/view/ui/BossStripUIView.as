package battle.view.ui
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import map.campaign.CampaignManager;
   import yishi.manager.BaseManager;
   import yishi.utils.NumberViewUtils;
   
   public class BossStripUIView extends Sprite implements IHpStrip
   {
      
      protected var _stripNum:int;
      
      protected var _currentStripIndex:int;
      
      protected var _maxValue:Number;
      
      protected var _currentValue:Number;
      
      protected var _upStripView:StripUIView;
      
      protected var _underStripView:StripUIView;
      
      protected var _myWidth:Number;
      
      protected var _showNextStriping:Boolean;
      
      protected var _switchIntervalId:uint;
      
      protected var _currentStripNumView:Sprite;
      
      protected var _numBitmapData:BitmapData;
      
      private var _inited:Boolean;
      
      protected var _scaleX:Number;
      
      public var isDie:Boolean;
      
      protected var _viewStyleName:String;
      
      private var _stripNumViewPoint:Point = new Point();
      
      public var _toSetWidth:Boolean = false;
      
      public function BossStripUIView(param1:int, param2:Number = 0, param3:uint = 0, param4:Boolean = true, param5:Number = -1, param6:String = "asset.battle.BossHpStripAsset", param7:String = "asset.battle.BossHpStripBgAsset")
      {
         super();
         _stripNum = _currentStripIndex = param1;
         _scaleX = param5;
         _maxValue = param2;
         _currentValue = _maxValue;
         _viewStyleName = param6;
         initView(param6,param7);
      }
      
      protected function initView(param1:String, param2:String) : void
      {
         var _loc4_:MovieClip = null;
         if(_stripNum > 1)
         {
            _loc4_ = ComponentFactory.Instance.creat(param1) as MovieClip;
            _underStripView = new StripUIView(_loc4_,0,0,16275472);
            _underStripView.asset.upStrip.gotoAndStop(_stripNum - 1);
            this.addChild(_underStripView.getView());
            _currentStripNumView = new Sprite();
            _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.battle.BossStripNumAsset");
            setStripNumViewByIndex(_stripNum);
         }
         var _loc5_:MovieClip = ComponentFactory.Instance.creat(param1) as MovieClip;
         _myWidth = _loc5_.width;
         var _loc3_:Bitmap = param2 != null ? ComponentFactory.Instance.creatBitmap(param2) : null;
         _upStripView = new StripUIView(_loc5_,0,0,16275472,true,false,_loc3_,true,true);
         _upStripView.asset.upStrip.gotoAndStop(_stripNum);
         this.addChild(_upStripView.getView());
         if(_currentStripNumView)
         {
            _currentStripNumView.scaleX = _scaleX;
            if(_scaleX < 0)
            {
               _currentStripNumView.x = 400;
            }
            else
            {
               _currentStripNumView.x = 350;
            }
            _currentStripNumView.y = -13;
            _stripNumViewPoint.x = _currentStripNumView.x;
            _stripNumViewPoint.y = _currentStripNumView.y;
            this.addChild(_currentStripNumView);
         }
      }
      
      public function setStrpNumPos(param1:int, param2:int) : void
      {
         if(_currentStripNumView != null)
         {
            _currentStripNumView.x = param1;
            _currentStripNumView.y = param2;
            _stripNumViewPoint.x = _currentStripNumView.x;
            _stripNumViewPoint.y = _currentStripNumView.y;
         }
      }
      
      public function initCurrentValue(param1:Number) : void
      {
      }
      
      public function set maxValue(param1:Number) : void
      {
         _maxValue = param1;
         if(!_upStripView)
         {
            return;
         }
         var _loc2_:Number = calculateCurrentMaxValue();
         _upStripView.currentValue = _loc2_;
         _upStripView.maxValue = _loc2_;
         setStripNumViewByIndex(_currentStripIndex);
      }
      
      public function get maxValue() : Number
      {
         return _maxValue;
      }
      
      public function set currentValue(param1:Number) : void
      {
         _currentValue = param1;
         if(!_upStripView)
         {
            return;
         }
         if(!_inited)
         {
            _inited = true;
            updateCurrentCurrentValue(false);
         }
         else
         {
            updateCurrentCurrentValue();
         }
      }
      
      public function get currentValue() : Number
      {
         return _currentValue;
      }
      
      private function updateCurrentCurrentValue(param1:Boolean = true) : void
      {
         var _loc4_:* = 0;
         var _loc2_:Number = _maxValue / _stripNum;
         var _loc3_:Number = calculateCurrnetCurrentValue(_loc2_);
         var _loc5_:Boolean = _loc3_ <= 0;
         if(_loc5_)
         {
            if(_stripNum > 1)
            {
               showNextStrip(param1);
            }
            else if(param1)
            {
               _upStripView.currentValue = 0;
            }
            else
            {
               _upStripView.initCurrentValue(0);
            }
         }
         else if(_loc3_ <= _loc2_)
         {
            if(param1)
            {
               _upStripView.currentValue = _loc3_;
            }
            else
            {
               _upStripView.initCurrentValue(_loc3_);
            }
         }
         else
         {
            _loc4_ = uint(Math.floor(_loc3_ / _loc2_));
            _currentStripIndex += _loc4_;
            showPreStrip(false);
         }
      }
      
      private function calculateCurrentMaxValue() : Number
      {
         return _maxValue / _stripNum;
      }
      
      protected function setStripNumViewByIndex(param1:int) : void
      {
         if(_currentStripNumView)
         {
            _currentStripNumView.visible = false;
            NumberViewUtils.refreshValue(param1,_currentStripNumView,_numBitmapData,50,50,48,50,"23456");
            if(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.battleType == 17 && BaseManager.instance.wordBossInvincibleState)
            {
               _currentStripNumView.visible = false;
            }
            else if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.campaignTemplate && CampaignManager.instance.mapModel.campaignTemplate.Types == 1 && BaseManager.instance.wordBossInvincibleState)
            {
               _currentStripNumView.visible = false;
            }
            else
            {
               _currentStripNumView.visible = true;
            }
         }
      }
      
      private function calculateCurrnetCurrentValue(param1:Number) : Number
      {
         if(_currentValue <= 0)
         {
            return 0;
         }
         return param1 - (param1 * _currentStripIndex - _currentValue);
      }
      
      private function showPreStrip(param1:Boolean = false) : void
      {
         var tween:Boolean = param1;
         var switchPreStrip:* = function():void
         {
            var _loc2_:MovieClip = null;
            var _loc1_:Number = calculateCurrentMaxValue();
            _upStripView.maxValue = _loc1_;
            if(tween)
            {
               _upStripView.currentValue = _loc1_;
            }
            else
            {
               _upStripView.initCurrentValue(_loc1_);
            }
            _upStripView.asset.upStrip.gotoAndStop(_currentStripIndex);
            updateCurrentCurrentValue(tween);
            if(_currentStripIndex < 2)
            {
               removeUnderStrip();
               removeStripNumView();
            }
            else
            {
               if(_underStripView == null && _stripNum > 1)
               {
                  _loc2_ = ComponentFactory.Instance.creat(_viewStyleName) as MovieClip;
                  _underStripView = new StripUIView(_loc2_,0,0,16275472);
                  addChild(_underStripView.getView());
                  addChild(_upStripView.getView());
               }
               if(_currentStripNumView == null)
               {
                  _currentStripNumView = new Sprite();
                  _currentStripNumView.scaleX = _scaleX;
                  _currentStripNumView.x = _stripNumViewPoint.x;
                  _currentStripNumView.y = _stripNumViewPoint.y;
                  addChild(_currentStripNumView);
               }
               _underStripView.asset.upStrip.gotoAndStop(_currentStripIndex - 1);
               setStripNumViewByIndex(_currentStripIndex);
            }
         };
         if(tween)
         {
            _upStripView.currentValue = 0;
            _switchIntervalId = setTimeout(switchPreStrip,1500);
         }
         else
         {
            _upStripView.initCurrentValue(0);
            switchPreStrip();
         }
      }
      
      private function showNextStrip(param1:Boolean = true) : void
      {
         if(!_showNextStriping)
         {
            _showNextStriping = true;
            if(param1)
            {
               _upStripView.currentValue = 0;
               _switchIntervalId = setTimeout(switchStrip,1500);
            }
            else
            {
               _upStripView.initCurrentValue(0);
               switchStrip(false);
            }
         }
      }
      
      private function switchStrip(param1:Boolean = true) : void
      {
         var _loc2_:Number = NaN;
         _showNextStriping = false;
         _currentStripIndex = _currentStripIndex - 1;
         if(_currentStripIndex > 0)
         {
            _loc2_ = calculateCurrentMaxValue();
            _upStripView.maxValue = _loc2_;
            if(param1)
            {
               _upStripView.currentValue = _loc2_;
            }
            else
            {
               _upStripView.initCurrentValue(_loc2_);
            }
            _upStripView.asset.upStrip.gotoAndStop(_currentStripIndex);
            updateCurrentCurrentValue(param1);
         }
         if(_currentStripIndex < 2)
         {
            removeUnderStrip();
            removeStripNumView();
         }
         else if(_underStripView)
         {
            _underStripView.asset.upStrip.gotoAndStop(_currentStripIndex - 1);
            setStripNumViewByIndex(_currentStripIndex);
         }
      }
      
      private function removeUnderStrip() : void
      {
         if(_underStripView && _underStripView.getView().parent)
         {
            this.removeChild(_underStripView.getView());
            _underStripView = null;
         }
      }
      
      private function removeStripNumView() : void
      {
         if(_currentStripNumView)
         {
            if(_currentStripNumView.parent)
            {
               _currentStripNumView.parent.removeChild(_currentStripNumView);
            }
            _currentStripNumView = null;
         }
      }
      
      override public function get width() : Number
      {
         return _myWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         _myWidth = param1;
         if(_toSetWidth)
         {
            super.width = param1;
         }
      }
      
      public function getView() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         isDie = true;
         if(_switchIntervalId > 0)
         {
            clearTimeout(_switchIntervalId);
         }
         ObjectUtils.disposeObject(_upStripView);
         _upStripView = null;
         ObjectUtils.disposeObject(_underStripView);
         _underStripView = null;
         ObjectUtils.removeChildAllChildren(_currentStripNumView);
         _currentStripNumView = null;
         ObjectUtils.disposeObject(_numBitmapData);
         _numBitmapData = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


package com.pickgliss.ui
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.core.ITransformableTipedDisplay;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.ui.vo.DirectionPos;
   import com.pickgliss.utils.DisplayUtils;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public final class ShowTipManager
   {
      
      private static var _instance:ShowTipManager;
      
      public static var TEST_CMD_SWITCH_HIDE:Boolean;
      
      public static const StartPoint:Point = new Point(0,0);
      
      private var _currentTipObject:ITipedDisplay;
      
      private var _simpleTipset:Object;
      
      private var _tipContainer:DisplayObjectContainer;
      
      private var _tipedObjects:Vector.<ITipedDisplay>;
      
      private var _tips:Dictionary;
      
      private var _currentTip:ITip;
      
      private var _needLoad:int = 2;
      
      private var _currentLoad:int = 0;
      
      private var isloading:Boolean = false;
      
      public function ShowTipManager()
      {
         super();
         _tips = new Dictionary();
         _tipedObjects = new Vector.<ITipedDisplay>();
      }
      
      public static function get Instance() : ShowTipManager
      {
         if(_instance == null)
         {
            _instance = new ShowTipManager();
         }
         return _instance;
      }
      
      public function addTip(param1:ITipedDisplay) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeTipedObject(param1);
         _tipedObjects.push(param1);
         param1.addEventListener("rollOver",__onOver);
         param1.addEventListener("rollOut",__onOut);
         if(_currentTipObject == param1)
         {
            showTip(_currentTipObject);
         }
      }
      
      public function getTipPosByDirction(param1:ITip, param2:ITipedDisplay, param3:int) : Point
      {
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Point = new Point();
         if(param2 is IManualTipTargetSize)
         {
            _loc6_ = (param2 as IManualTipTargetSize).manualWidth;
            _loc4_ = (param2 as IManualTipTargetSize).manualHeight;
         }
         else if(param2 is IManualSize)
         {
            _loc6_ = (param2 as IManualSize).viewRectangle.width;
            _loc4_ = (param2 as IManualSize).viewRectangle.height;
         }
         else
         {
            _loc6_ = Number(param2.width);
            _loc4_ = Number(param2.height);
         }
         if(param3 == 0)
         {
            _loc5_.y = -param1.height - param2.tipGapV;
            _loc5_.x = (_loc6_ - param1.width) / 2;
         }
         else if(param3 == 1)
         {
            _loc5_.x = -param1.width - param2.tipGapH;
            _loc5_.y = (_loc4_ - param1.height) / 2;
         }
         else if(param3 == 2)
         {
            _loc5_.x = _loc6_ + param2.tipGapH;
            _loc5_.y = (_loc6_ - param1.height) / 2;
         }
         else if(param3 == 3)
         {
            _loc5_.y = _loc4_ + param2.tipGapV;
            _loc5_.x = (_loc6_ - param1.width) / 2;
         }
         else if(param3 == 4)
         {
            _loc5_.y = -param1.height - param2.tipGapV;
            _loc5_.x = -param1.width - param2.tipGapH;
         }
         else if(param3 == 5)
         {
            _loc5_.y = -param1.height - param2.tipGapV;
            _loc5_.x = _loc6_ + param2.tipGapH;
         }
         else if(param3 == 6)
         {
            _loc5_.y = _loc4_ + param2.tipGapV;
            _loc5_.x = -param1.width - param2.tipGapH;
         }
         else if(param3 == 7)
         {
            _loc5_.y = _loc4_ + param2.tipGapV;
            _loc5_.x = _loc6_ + param2.tipGapH;
         }
         return _loc5_;
      }
      
      public function hideTip(param1:ITipedDisplay) : void
      {
         if(param1 == null || !_tipContainer)
         {
            return;
         }
         var _loc2_:ITip = _tips[param1.tipStyle];
         if(_loc2_ == null)
         {
            return;
         }
         StageReferance.stage.removeEventListener("mouseMove",__moveTip);
         _loc2_.visible = false;
         if(_tipContainer.contains(_loc2_.asDisplayObject()))
         {
            _tipContainer.removeChild(_loc2_.asDisplayObject());
         }
         _currentTipObject = null;
         _currentTip = null;
      }
      
      public function removeCurrentTip() : void
      {
         hideTip(_currentTipObject);
      }
      
      public function removeAllTip() : void
      {
         for each(var _loc1_:ITip in _tips)
         {
            if(_loc1_.asDisplayObject().parent)
            {
               _loc1_.asDisplayObject().parent.removeChild(_loc1_.asDisplayObject());
            }
         }
         StageReferance.stage.removeEventListener("mouseMove",__moveTip);
         _currentTipObject = null;
         _currentTip = null;
      }
      
      public function removeTip(param1:ITipedDisplay) : void
      {
         removeTipedObject(param1);
         if(_currentTipObject == param1)
         {
            hideTip(_currentTipObject);
         }
      }
      
      public function setSimpleTip(param1:ITipedDisplay, param2:String = "") : void
      {
         if(_simpleTipset == null)
         {
            return;
         }
         if(param1 is Component)
         {
            Component(param1).beginChanges();
         }
         param1.tipStyle = _simpleTipset.tipStyle;
         param1.tipData = param2;
         param1.tipDirctions = _simpleTipset.tipDirctions;
         param1.tipGapV = _simpleTipset.tipGapV;
         param1.tipGapH = _simpleTipset.tipGapH;
         if(param1 is Component)
         {
            Component(param1).commitChanges();
         }
      }
      
      public function setup() : void
      {
         _tipContainer = LayerManager.Instance.getLayerByType(0);
      }
      
      public function showTip(param1:*) : void
      {
         var _loc2_:ITransformableTip = null;
         if(!param1.tipData || !_tipContainer)
         {
            return;
         }
         if(!_tips[param1.tipStyle])
         {
            try
            {
               _tips[param1.tipStyle] = ComponentFactory.Instance.creat(param1.tipStyle);
            }
            catch(e:Error)
            {
               startLoader();
               return;
            }
         }
         if(param1 is ITipedDisplay)
         {
            showNormalTip(param1);
         }
         if(param1 is ITransformableTipedDisplay)
         {
            _loc2_ = _tips[param1.tipStyle];
            _loc2_.tipWidth = param1.tipWidth;
            _loc2_.tipHeight = param1.tipHeight;
         }
         if(param1 && param1.tipStyle && _tips[param1.tipStyle] && _tips[param1.tipStyle].asDisplayObject())
         {
            _tipContainer.addChild(_tips[param1.tipStyle].asDisplayObject());
         }
      }
      
      public function startLoader() : void
      {
         if(isloading)
         {
            return;
         }
         isloading = true;
         var _loc1_:String = ComponentSetting.getProjectSourcePath("16.png");
         LoaderManagerII.instance.load(_loc1_,3,8,__loadCompleteHandler);
         _loc1_ = ComponentSetting.getUISourcePath("tips");
         LoaderManagerII.instance.load(_loc1_,3,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _currentLoad = _currentLoad + 1;
         if(_currentLoad >= _needLoad)
         {
         }
      }
      
      private function showNormalTip(param1:ITipedDisplay) : void
      {
         var _loc6_:Point = null;
         var _loc5_:Point = null;
         var _loc3_:DirectionPos = null;
         var _loc2_:Point = null;
         var _loc4_:ITip = _tips[param1.tipStyle];
         _currentTipObject = param1;
         if(_loc4_ == null)
         {
            if(param1.tipStyle == null)
            {
               return;
            }
            _loc4_ = _tips[param1.tipStyle] = ComponentFactory.Instance.creat(param1.tipStyle);
            if(_loc4_ == null)
            {
               return;
            }
         }
         if(param1 is ITransformableTipedDisplay && _loc4_ is ITransformableTip)
         {
            ITransformableTip(_loc4_).tipWidth = ITransformableTipedDisplay(param1).tipWidth;
            ITransformableTip(_loc4_).tipHeight = ITransformableTipedDisplay(param1).tipHeight;
         }
         _loc4_.visible = true;
         _loc4_.tipData = param1.tipData;
         if(param1.isFollowMouse)
         {
            _currentTip = _loc4_;
            StageReferance.stage.addEventListener("mouseMove",__moveTip);
            __moveTip(null);
         }
         else
         {
            _loc6_ = _tipContainer.globalToLocal(param1.localToGlobal(param1.startPoint));
            _loc5_ = new Point();
            _loc3_ = getTipPriorityDirction(_loc4_,param1,param1.tipDirctions);
            _loc5_ = getTipPosByDirction(_loc4_,param1,_loc3_.direction);
            _loc4_.direction = _loc3_.direction;
            if(_loc3_.offsetX < 1073741823)
            {
               _loc4_.x = _loc5_.x + _loc6_.x + _loc3_.offsetX;
            }
            else
            {
               _loc4_.x = _loc5_.x + _loc6_.x;
            }
            if(_loc3_.offsetY < 1073741823)
            {
               _loc4_.y = _loc5_.y + _loc6_.y + _loc3_.offsetY;
            }
            else
            {
               _loc4_.y = _loc5_.y + _loc6_.y;
            }
            if(_loc4_.width > 860 && param1.tipStyle != "yishi.view.tips.OneLineTip")
            {
               _loc2_ = _tipContainer.localToGlobal(new Point(_tipContainer.x,_tipContainer.y));
               _loc4_.x = (StageReferance.stageWidth - _loc4_.width) * 0.5 - _loc2_.x;
               _loc4_.y = (StageReferance.stageHeight - _loc4_.height) * 0.5 - _loc2_.y;
            }
            _loc4_.x = Math.round(_loc4_.x);
            _loc4_.y = Math.round(_loc4_.y);
         }
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         var _loc2_:ITipedDisplay = param1.currentTarget as ITipedDisplay;
         if(DisplayLoader.isDebug)
         {
            if(TEST_CMD_SWITCH_HIDE)
            {
               return;
            }
         }
         hideTip(_loc2_);
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         var _loc2_:ITipedDisplay = param1.currentTarget as ITipedDisplay;
         if(_loc2_.tipData)
         {
            showTip(_loc2_);
         }
      }
      
      private function getTipPriorityDirction(param1:ITip, param2:ITipedDisplay, param3:String) : DirectionPos
      {
         var _loc10_:DirectionPos = null;
         var _loc9_:int = 0;
         var _loc6_:Point = null;
         var _loc5_:Point = null;
         var _loc4_:Point = null;
         var _loc11_:DirectionPos = null;
         var _loc7_:Array = param3.split(",");
         var _loc8_:Vector.<DirectionPos> = new Vector.<DirectionPos>();
         var _loc12_:Point = _tipContainer.globalToLocal(param2.localToGlobal(param2.startPoint));
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc6_ = getTipPosByDirction(param1,param2,_loc7_[_loc9_]);
            _loc5_ = new Point(_loc6_.x + _loc12_.x,_loc6_.y + _loc12_.y);
            _loc4_ = new Point(_loc6_.x + _loc12_.x + param1.width,_loc6_.y + _loc12_.y + param1.height);
            _loc11_ = creatDirectionPos(_loc5_,_loc4_,int(_loc7_[_loc9_]));
            if(_loc11_.offsetX == 0 && _loc11_.offsetY == 0)
            {
               _loc10_ = _loc11_;
               break;
            }
            _loc8_.push(_loc11_);
            _loc9_++;
         }
         if(_loc10_ == null)
         {
            _loc10_ = searchFixedDirectionPos(_loc8_);
         }
         return _loc10_;
      }
      
      private function searchFixedDirectionPos(param1:Vector.<DirectionPos>) : DirectionPos
      {
         var _loc2_:DirectionPos = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Vector.<DirectionPos> = param1.reverse();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if(_loc2_ == null)
            {
               _loc2_ = _loc6_[_loc5_];
            }
            else
            {
               _loc3_ = Math.abs(_loc6_[_loc5_].offsetX) + Math.abs(_loc6_[_loc5_].offsetY);
               _loc4_ = Math.abs(_loc2_.offsetX) + Math.abs(_loc2_.offsetY);
               if(_loc3_ <= _loc4_)
               {
                  _loc2_ = _loc6_[_loc5_];
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function creatDirectionPos(param1:Point, param2:Point, param3:int) : DirectionPos
      {
         var _loc4_:DirectionPos = new DirectionPos();
         _loc4_.direction = param3;
         if(param3 == 0)
         {
            if(param1.y < 0)
            {
               _loc4_.offsetY = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
            if(param1.x < 0)
            {
               _loc4_.offsetX = -param1.x;
            }
            else if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = StageReferance.stageWidth - param2.x;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
         }
         else if(param3 == 1)
         {
            if(param1.x < 0)
            {
               _loc4_.offsetX = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
            if(param1.y < 0)
            {
               _loc4_.offsetY = -param1.y;
            }
            else if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = StageReferance.stageHeight - param2.y;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
         }
         else if(param3 == 2)
         {
            if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
            if(param1.y < 0)
            {
               _loc4_.offsetY = -param1.y;
            }
            else if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = StageReferance.stageHeight - param2.y;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
         }
         else if(param3 == 3)
         {
            if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
            if(param1.x < 0)
            {
               _loc4_.offsetX = -param1.x;
            }
            else if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = StageReferance.stageWidth - param2.x;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
         }
         else if(DisplayUtils.isInTheStage(param1) && DisplayUtils.isInTheStage(param2))
         {
            _loc4_.offsetX = 0;
            _loc4_.offsetY = 0;
         }
         else
         {
            _loc4_.offsetY = 2147483647 / 2;
            _loc4_.offsetX = 2147483647 / 2;
         }
         return _loc4_;
      }
      
      private function removeTipedObject(param1:ITipedDisplay) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = _tipedObjects.indexOf(param1);
         param1.removeEventListener("rollOver",__onOver);
         param1.removeEventListener("rollOut",__onOut);
         if(_loc2_ != -1)
         {
            _tipedObjects.splice(_loc2_,1);
         }
      }
      
      protected function __moveTip(param1:Event = null) : void
      {
         _currentTip.x = StageReferance.stage.mouseX + _currentTipObject.tipGapH;
         _currentTip.y = StageReferance.stage.mouseY + _currentTipObject.tipGapV;
         if(_currentTip.x + _currentTip.width > StageReferance.stageWidth)
         {
            _currentTip.x = StageReferance.stageWidth - _currentTip.width;
         }
         if(_currentTip.y + _currentTip.height > StageReferance.stageHeight)
         {
            _currentTip.y = StageReferance.stageHeight - _currentTip.height;
         }
      }
   }
}


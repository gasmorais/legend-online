package com.pickgliss.ui
{
   import com.greensock.TweenLite;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.SpriteLayer;
   import com.pickgliss.ui.core.UISpriteLayer;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class LayerManager
   {
      
      public static const STAGE_BOTTOM_LAYER:int = 8;
      
      public static const STAGE_TOP_LAYER:int = 0;
      
      public static const STAGE_DYANMIC_LAYER:int = 1;
      
      public static const GAME_TOP_LAYER:int = 2;
      
      public static const GAME_DYNAMIC_LAYER:int = 3;
      
      public static const GAME_UI_LAYER:int = 4;
      
      public static const GAME_BASE_LAYER:int = 5;
      
      public static const GAME_BOTTOM_LAYER:int = 6;
      
      public static const GAME_MENU_LAYER:int = 7;
      
      public static const GAME_DYNAMIC_LAYER2:int = 9;
      
      public static const NONE_BLOCKGOUND:int = 0;
      
      public static const BLCAK_BLOCKGOUND:int = 1;
      
      public static const ALPHA_BLOCKGOUND:int = 2;
      
      public static const SMALL_TO_BIG:int = 1;
      
      public static const EFFECT_MOVE:int = 2;
      
      private static var _instance:LayerManager;
      
      private var _stageTopLayer:SpriteLayer;
      
      private var _stageDynamicLayer:SpriteLayer;
      
      private var _stageBottomLayer:SpriteLayer;
      
      private var _gameTopLayer:SpriteLayer;
      
      private var _gameDynamicLayer:SpriteLayer;
      
      private var _gameUILayer:SpriteLayer;
      
      private var _gameBaseLayer:SpriteLayer;
      
      private var _gameBottomLayer:SpriteLayer;
      
      private var _gameMenuLayer:SpriteLayer;
      
      private var _gameDynamicLayer2:SpriteLayer;
      
      public var mutiContainer:Component;
      
      public var clickPos:Point;
      
      private var _settingMap:Dictionary = new Dictionary();
      
      private var _settingMap2:Dictionary = new Dictionary();
      
      private var _sourceList:Array = [];
      
      public function LayerManager()
      {
         super();
      }
      
      public static function get Instance() : LayerManager
      {
         if(_instance == null)
         {
            _instance = new LayerManager();
         }
         return _instance;
      }
      
      public function setup(param1:Stage) : void
      {
         _stageTopLayer = new SpriteLayer();
         _stageDynamicLayer = new SpriteLayer();
         _stageBottomLayer = new SpriteLayer();
         _gameTopLayer = new SpriteLayer();
         _gameDynamicLayer = new SpriteLayer();
         _gameDynamicLayer2 = new SpriteLayer();
         _gameMenuLayer = new SpriteLayer();
         _gameUILayer = new UISpriteLayer();
         _gameBaseLayer = new SpriteLayer();
         _gameBottomLayer = new SpriteLayer();
         param1.addChild(_stageBottomLayer);
         param1.addChild(_stageDynamicLayer);
         param1.addChild(_stageTopLayer);
         _gameDynamicLayer.autoClickTotop = true;
         _stageBottomLayer.addChild(_gameBottomLayer);
         _stageBottomLayer.addChild(_gameBaseLayer);
         _stageBottomLayer.addChild(_gameUILayer);
         _stageBottomLayer.addChild(_gameDynamicLayer);
         _stageBottomLayer.addChild(_gameDynamicLayer2);
         _stageBottomLayer.addChild(_gameMenuLayer);
         _stageBottomLayer.addChild(_gameTopLayer);
         mutiContainer = new Component();
         StageReferance.stage.addEventListener("mouseDown",__stageMouseDown);
      }
      
      private function __stageMouseDown(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc7_:Disposeable = null;
         var _loc2_:uint = uint(_gameMenuLayer.numChildren);
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = _gameMenuLayer.getChildAt(_loc4_);
            if(!_loc6_.hitTestPoint(param1.stageX,param1.stageY,true))
            {
               _loc3_.push(_loc6_);
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc5_] as Disposeable;
            if(_loc7_)
            {
               _loc7_.dispose();
            }
            _loc5_++;
         }
      }
      
      public function clearGameMenuLayer() : void
      {
         cleanSprite(_gameMenuLayer);
      }
      
      public function getLayerByType(param1:int) : SpriteLayer
      {
         switch(param1)
         {
            case 0:
               return _stageTopLayer;
            case 1:
               return _stageDynamicLayer;
            case 2:
               return _gameTopLayer;
            case 3:
               return _gameDynamicLayer;
            case 4:
               return _gameUILayer;
            case 5:
               return _gameBaseLayer;
            case 6:
               return _gameBottomLayer;
            case 7:
               ObjectUtils.disposeAllChildren(_gameMenuLayer);
               return _gameMenuLayer;
            case 8:
               return _stageBottomLayer;
            case 9:
               return _gameDynamicLayer2;
            default:
               return null;
         }
      }
      
      public function cleanLayerByType(param1:int) : void
      {
         cleanSprite(getLayerByType(param1));
      }
      
      public function get settingMap() : Dictionary
      {
         return _settingMap;
      }
      
      public function addToSpecial(param1:DisplayObject, param2:int, param3:Boolean = false, param4:Boolean = false, param5:int = -1, param6:Number = 0, param7:Number = 0, param8:int = 0, param9:Boolean = false) : void
      {
         var _loc13_:Rectangle = null;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         if(!param1)
         {
            return;
         }
         var _loc10_:SpriteLayer = getLayerByType(param2);
         _settingMap[param1] = param4;
         if(param1 is IManualSize)
         {
            _loc13_ = (param1 as IManualSize).viewRectangle;
         }
         else
         {
            _loc12_ = ObjectUtils.getObjectWidth(param1);
            _loc14_ = ObjectUtils.getObjectHeight(param1);
            _loc13_ = param9 ? DisplayUtils.getVisibleSize(param1) : param1.getBounds(StageReferance.stage);
         }
         var _loc11_:Number = StageReferance.gameStageWidth;
         var _loc15_:Number = StageReferance.gameStageHeight;
         param1.y = (_loc15_ - _loc13_.height) / 2 + param7;
         if(param5 == 1)
         {
            param1.x = _loc11_ - _loc13_.width + param6;
         }
         else if(param5 == 0)
         {
            param1.x = (_loc11_ - _loc13_.width) / 2 + param6;
         }
         _loc10_.addTolayer(param1,param8);
         if(param1 as Frame)
         {
            param1.alpha = 0;
            TweenLite.to(param1,0.5,{
               "alpha":1,
               "onComplete":onComplete,
               "onCompleteParams":[param1]
            });
         }
      }
      
      public function addToLayer(param1:DisplayObject, param2:int, param3:Boolean = false, param4:Boolean = false, param5:int = 0, param6:int = 0, param7:Boolean = false, param8:int = 0) : void
      {
         var _loc9_:SpriteLayer = getLayerByType(param2);
         _settingMap[param1] = param4;
         if(param3)
         {
            centerToStage(param1,_settingMap2[param1]);
            param1.addEventListener("addedToStage",__onAddedToStage);
            _settingMap2[param1] = param7;
         }
         if(param2 == 7)
         {
            if(param1.x + param1.width > StageReferance.gameStageWidth)
            {
               param1.x = StageReferance.gameStageWidth - param1.width;
            }
            if(param1.y + param1.height > StageReferance.gameStageHeight)
            {
               param1.y = StageReferance.gameStageHeight - param1.height;
            }
            StageReferance.stage.focus = param1 as InteractiveObject;
         }
         _loc9_.addTolayer(param1,param5,param6);
         if(param1 as Frame || param8 == 1)
         {
            param1.alpha = 0;
            TweenLite.to(param1,0.5,{
               "alpha":1,
               "onComplete":onComplete,
               "onCompleteParams":[param1]
            });
         }
      }
      
      private function onComplete(param1:DisplayObject) : void
      {
         if(param1)
         {
            TweenLite.killTweensOf(param1);
         }
      }
      
      private function __onAddedToStage(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _sourceList.push(_loc2_);
         _loc2_.removeEventListener("addedToStage",__onAddedToStage);
         StageReferance.stage.removeEventListener("resize",__onStageResize);
         if(StageReferance.stage.stageWidth == 0 && StageReferance.stage.stageHeight == 0)
         {
            StageReferance.stage.addEventListener("resize",__onStageResize);
         }
         else
         {
            centerToStage(_loc2_,_settingMap2[_loc2_]);
            _sourceList.pop();
            delete _settingMap2[_loc2_];
         }
      }
      
      private function __onStageResize(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(StageReferance.stage.stageWidth > 0 && StageReferance.stage.stageHeight > 0)
         {
            StageReferance.stage.removeEventListener("resize",__onStageResize);
            _loc2_ = 0;
            while(_loc2_ < _sourceList.length)
            {
               centerToStage(_sourceList[_loc2_],_settingMap2[_sourceList[_loc2_]]);
               _loc2_++;
            }
            _sourceList = [];
            _settingMap2 = null;
            _settingMap2 = new Dictionary();
         }
      }
      
      private function centerToStage(param1:DisplayObject, param2:Boolean = false) : void
      {
         var _loc3_:Rectangle = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(param1 is IManualSize)
         {
            _loc3_ = (param1 as IManualSize).viewRectangle;
         }
         else
         {
            _loc4_ = ObjectUtils.getObjectWidth(param1);
            _loc5_ = ObjectUtils.getObjectHeight(param1);
            _loc3_ = param2 ? DisplayUtils.getVisibleSize(param1) : param1.getBounds(StageReferance.stage);
         }
         param1.x = (StageReferance.gameStageWidth - _loc3_.width) / 2;
         param1.y = (StageReferance.gameStageHeight - _loc3_.height) / 2;
      }
      
      public function addTolayerRelated(param1:DisplayObject, param2:DisplayObject, param3:int, param4:Boolean = true, param5:Boolean = false, param6:int = 0, param7:int = 35) : void
      {
         var _loc8_:SpriteLayer = getLayerByType(param3);
         var _loc9_:int = (StageReferance.gameStageWidth - ObjectUtils.getObjectWidth(param1)) / 2;
         param1.x = _loc9_ - ObjectUtils.getObjectWidth(param2) / 2;
         param2.x = param1.x + ObjectUtils.getObjectWidth(param1) + param7;
         param2.y = param1.y;
         _loc8_.addTolayer(param1,param6);
         _loc8_.addTolayer(param2,0);
      }
      
      public function clearnStageDynamic() : void
      {
         cleanSprite(_stageDynamicLayer);
      }
      
      public function clearnGameDynamic() : void
      {
         StageReferance.stage.focus = null;
         cleanSprite(_gameDynamicLayer);
      }
      
      public function cleanGameTop() : void
      {
         cleanSprite(_gameTopLayer);
      }
      
      private function cleanSprite(param1:Sprite) : void
      {
         var _loc2_:DisplayObject = null;
         while(param1.numChildren > 0)
         {
            _loc2_ = param1.getChildAt(0);
            ObjectUtils.disposeObject(_loc2_);
         }
      }
   }
}


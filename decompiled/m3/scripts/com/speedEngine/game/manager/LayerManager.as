package com.speedEngine.game.manager
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.error.ErrorManager;
   import com.speedEngine.game.view.BaseSprite;
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.display.Quad;
   import com.speedEngine.speedBones.display.Stage;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   
   use namespace basegame_internal;
   
   public class LayerManager
   {
      
      private static var _instance:LayerManager;
      
      private var _layers:Dictionary;
      
      private var _stage3d:com.speedEngine.speedBones.display.Stage;
      
      private var _stage2d:flash.display.Stage;
      
      private var _quad:Quad;
      
      private var _shape:Sprite;
      
      private var _maskDic:Dictionary = new Dictionary(true);
      
      public function LayerManager(param1:SingleHelper)
      {
         super();
         if(param1 == null)
         {
            ErrorManager.instance.throwSingletonError();
         }
         else
         {
            _layers = new Dictionary();
         }
      }
      
      public static function get instance() : LayerManager
      {
         if(_instance == null)
         {
            _instance = new LayerManager(new SingleHelper());
         }
         return _instance;
      }
      
      basegame_internal function init3d(param1:Array) : void
      {
         var _loc2_:* = 0;
         if(param1 == null)
         {
            Director.instance.throwError("游戏3d层初始化数据错误！！");
            return;
         }
         _stage3d = Director.instance.stage3d;
         _quad = new Quad(Director.instance.stage3d.stageWidth,Director.instance.stage3d.stageHeight,0);
         _shape = new Sprite();
         _maskDic[_quad] = [];
         _maskDic[_shape] = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] != null || param1[_loc2_] != "")
            {
               _layers[param1[_loc2_]] = new DisplayObjectContainer();
               _stage3d.addChild(_layers[param1[_loc2_]]);
            }
            _loc2_++;
         }
         Director.instance.trace(4,"LayerManager","初始{invalid_utf8=229}{invalid_utf8=140}?3d层，共创{invalid_utf8=229}{invalid_utf8=187}?" + param1.length + "层！");
      }
      
      basegame_internal function init2d(param1:Array) : void
      {
         var _loc2_:BaseSprite = null;
         var _loc3_:* = 0;
         if(param1 == null)
         {
            Director.instance.throwError("游戏2d层初始化数据错误！！");
            return;
         }
         _stage2d = Director.instance.stage2d;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != null || param1[_loc3_] != "")
            {
               _loc2_ = new BaseSprite();
               _layers[param1[_loc3_]] = _stage2d.addChild(_loc2_);
            }
            _loc3_++;
         }
         Director.instance.trace(4,"LayerManager","初始{invalid_utf8=229}{invalid_utf8=140}?2d层，共创{invalid_utf8=229}{invalid_utf8=187}?" + param1.length + "层！");
      }
      
      basegame_internal function addToLayer(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:Number = 0.5) : void
      {
         var _loc6_:Object = _layers[param1];
         if(_loc6_ != null)
         {
            if(param3)
            {
               param2.x = (Director.instance.stage2d.stageWidth - param2.width) / 2;
               param2.y = (Director.instance.stage2d.stageHeight - param2.height) / 2;
            }
            if(param4)
            {
               if(_loc6_ is DisplayObjectContainer)
               {
                  _quad.alpha = param5;
                  _loc6_.addChild(_quad);
                  _maskDic[_quad].push({
                     "child":param2,
                     "layer":_loc6_
                  });
               }
               else if(_loc6_ is Sprite)
               {
                  _shape.graphics.clear();
                  _shape.graphics.beginFill(0,param5);
                  _shape.graphics.drawRect(0,0,Director.instance.stage2d.stageWidth,Director.instance.stage2d.stageHeight);
                  _shape.graphics.endFill();
                  _loc6_.addChild(_shape);
                  _maskDic[_shape].push({
                     "child":param2,
                     "layer":_loc6_
                  });
               }
            }
            _loc6_.addChild(param2);
         }
      }
      
      basegame_internal function removeToLayer(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc9_:Array = null;
         var _loc7_:Object = null;
         var _loc11_:Object = null;
         var _loc6_:Object = null;
         var _loc8_:Object = null;
         var _loc10_:int = 0;
         var _loc4_:Object = _layers[param1];
         if(param2.parent != _loc4_)
         {
            return;
         }
         var _loc5_:int = -1;
         if(_loc4_ != null)
         {
            if(_loc4_ is DisplayObjectContainer)
            {
               _loc9_ = _maskDic[_quad];
               _loc8_ = _quad;
            }
            else if(_loc4_ is Sprite)
            {
               _loc9_ = _maskDic[_shape];
               _loc8_ = _shape;
            }
            _loc3_ = _loc9_ ? _loc9_.length : 0;
            if(_loc3_ > 0)
            {
               _loc7_ = _loc9_[_loc3_ - 1];
               _loc11_ = _loc7_["child"];
               _loc6_ = _loc7_["layer"];
               if(_loc11_ == param2 && _loc6_ == _loc4_)
               {
                  _loc9_.pop();
                  _loc6_.removeChild(_loc8_);
                  if(_loc3_ > 1)
                  {
                     _loc7_ = _loc9_[_loc3_ - 2];
                     _loc11_ = _loc7_["child"];
                     _loc6_ = _loc7_["layer"];
                     if(_loc11_.parent == _loc6_)
                     {
                        _loc5_ = int(_loc6_.getChildIndex(_loc11_));
                        if(_loc5_ > -1)
                        {
                           _loc6_.addChildAt(_loc8_,_loc5_);
                        }
                     }
                  }
               }
               else
               {
                  _loc10_ = 0;
                  while(_loc9_ && _loc10_ < _loc9_.length)
                  {
                     _loc7_ = _loc9_[_loc10_];
                     _loc11_ = _loc7_["child"];
                     _loc6_ = _loc7_["layer"];
                     if(_loc11_ == param2)
                     {
                        _loc9_.splice(_loc10_,1);
                     }
                     _loc10_++;
                  }
               }
            }
            _loc4_.removeChild(param2);
         }
      }
      
      basegame_internal function clearLayerChild(param1:String, param2:Object = null) : void
      {
         var _loc3_:Object = null;
         if(param1 != null)
         {
            _loc3_ = _layers[param1];
            if(param2 == null)
            {
               _loc3_.removeChildren();
            }
            if(_loc3_ != null && _loc3_.contains(param2))
            {
               _loc3_.removeChild(param2);
            }
         }
      }
      
      basegame_internal function clearAllLayerChild() : void
      {
         for each(var _loc1_:Object in _layers)
         {
            _loc1_.removeChildren();
         }
      }
      
      basegame_internal function getLayerByName(param1:String) : Object
      {
         var _loc2_:Object = _layers[param1];
         if(_loc2_ == null)
         {
            ErrorManager.instance.throwErrorMsg("没有这个层[[" + param1 + "]]");
         }
         return _loc2_;
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}

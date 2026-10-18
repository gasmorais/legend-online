package com.pickgliss.ui.core
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpriteLayer extends Sprite
   {
      
      private var _blackGoundList:Vector.<DisplayObject>;
      
      private var _alphaGoundList:Vector.<DisplayObject>;
      
      private var _blackGound:Sprite;
      
      private var _alphaGound:Sprite;
      
      private var _autoClickTotop:Boolean;
      
      public function SpriteLayer(param1:Boolean = false)
      {
         init(param1);
         super();
      }
      
      private function init(param1:Boolean) : void
      {
         _blackGoundList = new Vector.<DisplayObject>();
         _alphaGoundList = new Vector.<DisplayObject>();
         mouseEnabled = param1;
         StageReferance.stage.addEventListener("resize",__onResize);
         __onResize();
      }
      
      protected function __onResize(param1:Event = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < this.numChildren)
         {
            _loc5_ = this.getChildAt(_loc4_);
            if(LayerManager.Instance.settingMap[_loc5_])
            {
               _loc2_ = StageReferance.stageWidth;
               _loc3_ = StageReferance.stageHeight;
               _loc5_.x = (_loc2_ - ObjectUtils.getObjectWidth(_loc5_)) / 2;
               _loc5_.y = (_loc3_ - ObjectUtils.getObjectHeight(_loc5_)) / 2;
            }
            _loc4_++;
         }
      }
      
      public function addTolayer(param1:DisplayObject, param2:int, param3:int = 0) : void
      {
         if(param2 == 1)
         {
            if(_blackGoundList.indexOf(param1) != -1)
            {
               _blackGoundList.splice(_blackGoundList.indexOf(param1),1);
            }
            _blackGoundList.push(param1);
         }
         else if(param2 == 2)
         {
            if(_alphaGoundList.indexOf(param1) != -1)
            {
               _alphaGoundList.splice(_alphaGoundList.indexOf(param1),1);
            }
            _alphaGoundList.push(param1);
         }
         param1.addEventListener("removedFromStage",__onChildRemoveFromStage);
         if(_autoClickTotop)
         {
            param1.addEventListener("mouseDown",__onClickToTop);
         }
         addToContainer(param1,param3);
         arrangeBlockGound();
      }
      
      protected function addToContainer(param1:DisplayObject, param2:int = 0) : void
      {
         addChild(param1);
      }
      
      private function __onClickToTop(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         addToContainer(_loc2_);
      }
      
      private function __onChildRemoveFromStage(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _loc2_.removeEventListener("removedFromStage",__onChildRemoveFromStage);
         _loc2_.removeEventListener("mouseDown",__onClickToTop);
         if(_blackGoundList.indexOf(_loc2_) != -1)
         {
            _blackGoundList.splice(_blackGoundList.indexOf(_loc2_),1);
         }
         if(_alphaGoundList.indexOf(_loc2_) != -1)
         {
            _alphaGoundList.splice(_alphaGoundList.indexOf(_loc2_),1);
         }
         delete LayerManager.Instance.settingMap[_loc2_];
         arrangeBlockGound();
      }
      
      private function arrangeBlockGound() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         if(_blackGound && _blackGound.parent)
         {
            _blackGound.parent.removeChild(_blackGound);
         }
         if(_alphaGound && _alphaGound.parent)
         {
            _alphaGound.parent.removeChild(_alphaGound);
         }
         if(_blackGoundList.length > 0)
         {
            _loc2_ = _blackGoundList[_blackGoundList.length - 1];
            _loc1_ = getChildIndex(_loc2_);
            addChildAt(blackGound,_loc1_);
         }
         else
         {
            removeBlackGound();
         }
         if(_alphaGoundList.length > 0)
         {
            _loc2_ = _alphaGoundList[_alphaGoundList.length - 1];
            _loc1_ = getChildIndex(_loc2_);
            addChildAt(alphaGound,_loc1_);
         }
         else
         {
            removeAlphaGound();
         }
      }
      
      private function get blackGound() : Sprite
      {
         if(_blackGound == null)
         {
            _blackGound = new Sprite();
            _blackGound.graphics.beginFill(0,0.6);
            _blackGound.graphics.drawRect(-1000,-500,StageReferance.stage.stageWidth + 2000,StageReferance.stage.stageHeight + 1000);
            _blackGound.graphics.endFill();
            _blackGound.addEventListener("mouseDown",__onBlackGoundMouseDown);
         }
         return _blackGound;
      }
      
      private function removeBlackGound() : void
      {
         if(_blackGound)
         {
            _blackGound.graphics.clear();
            _blackGound.removeEventListener("mouseDown",__onBlackGoundMouseDown);
            if(_blackGound.parent)
            {
               _blackGound.parent.removeChild(_blackGound);
            }
            _blackGound = null;
         }
      }
      
      private function __onBlackGoundMouseDown(param1:MouseEvent) : void
      {
         StageReferance.stage.focus = _blackGoundList[_blackGoundList.length - 1] as InteractiveObject;
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function get alphaGound() : Sprite
      {
         if(_alphaGound == null)
         {
            _alphaGound = new Sprite();
            _alphaGound.graphics.beginFill(0,0.001);
            _alphaGound.graphics.drawRect(-1000,-500,StageReferance.stage.stageWidth + 2000,StageReferance.stage.stageHeight + 1000);
            _alphaGound.graphics.endFill();
            _alphaGound.addEventListener("mouseDown",__onAlphaGoundDownClicked);
            _alphaGound.addEventListener("mouseUp",__onAlphaGoundUpClicked);
         }
         return _alphaGound;
      }
      
      private function removeAlphaGound() : void
      {
         if(_alphaGound)
         {
            _alphaGound.graphics.clear();
            _alphaGound.removeEventListener("mouseDown",__onAlphaGoundDownClicked);
            _alphaGound.removeEventListener("mouseUp",__onAlphaGoundUpClicked);
            if(_alphaGound.parent)
            {
               _alphaGound.parent.removeChild(_alphaGound);
            }
            _alphaGound = null;
         }
      }
      
      private function __onAlphaGoundDownClicked(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         StageReferance.stage.focus = _loc2_ as InteractiveObject;
      }
      
      private function __onAlphaGoundUpClicked(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         _loc2_.filters = null;
      }
      
      public function set autoClickTotop(param1:Boolean) : void
      {
         if(_autoClickTotop == param1)
         {
            return;
         }
         _autoClickTotop = param1;
      }
   }
}


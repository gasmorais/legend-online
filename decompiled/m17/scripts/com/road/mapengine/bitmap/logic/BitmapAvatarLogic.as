package com.road.mapengine.bitmap.logic
{
   import avatar.data.AvatarLayouData;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.load.ResourceAvatarInfo;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   import map.internals.utils.MapUtisl;
   
   public class BitmapAvatarLogic extends BitmapXYLogic
   {
      
      public static const WALK:int = 4;
      
      public static const JUMP:int = 1;
      
      public static const ATTACK:int = 2;
      
      public static const STAND:int = 3;
      
      protected var _walkTotalFrameX:int;
      
      protected var _walkTotalFrameY:int;
      
      protected var _standTotalFrameX:int;
      
      protected var _standTotalFrameY:int;
      
      protected var _jumpTotalFrameX:int;
      
      protected var _jumpTotalFrameY:int;
      
      protected var _attackTotalFrameX:int;
      
      protected var _attackTotalFrameY:int;
      
      protected var _state:int = 3;
      
      protected var _face:Boolean;
      
      protected var _sizeType:int = 0;
      
      protected var _offRect:Rectangle;
      
      private var _shape:Shape = new Shape();
      
      public function BitmapAvatarLogic(param1:BaseMapScene, param2:Boolean = true)
      {
         super(param1);
         if(param2)
         {
            sizeType = 1;
         }
         play();
      }
      
      public function get speed() : int
      {
         return 7;
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
         if(!_container)
         {
            return;
         }
         var _loc3_:ResourceAvatarInfo = new ResourceAvatarInfo();
         _loc3_.loadOver = true;
         _loc3_.packageName = MapUtisl.getPackageName(param1.url);
         _loc3_.position = _loc3_.position;
         var _loc5_:* = LoaderHeaderList.avatarShowNamePos[param1.url];
         var _loc4_:int = int(_loc5_ ? _loc5_.sizeType : 1);
         _loc3_.layouPara = new AvatarLayouData(_loc5_.standsPara);
         _loc3_.walkLayouPara = new AvatarLayouData(_loc5_.walksPara);
         if(_loc5_.attackPara)
         {
            _loc3_.attackLayouPara = new AvatarLayouData(_loc5_.attackPara);
         }
         _loc3_.sizeType = _loc4_;
         _loc3_.sornBaseNum = param1.args.stand;
         addResourceInfo(_loc3_);
         sizeType = maxSize;
         _loc3_.visible = true;
         updateStart();
      }
      
      public function set sizeType(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         if(_sizeType == param1)
         {
            return;
         }
         _sizeType = param1;
         var _loc2_:Object = MapUtisl.sizeMax[sizeType];
         _loc2_ = MapUtisl.sizeMax[1];
         _loc2_ || (_loc2_);
         _drawRect = new Rectangle(0,0,_loc2_.width,_loc2_.height);
         if(!_offRect)
         {
            _offRect = new Rectangle();
         }
         _offRect.x = _loc2_.x;
         _offRect.y = _loc2_.y;
         if(displayMode == 1)
         {
            _loc3_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            if(_baseView && _baseView.bitmapData)
            {
               _baseView.bitmapData.dispose();
            }
            _baseView.bitmapData = _loc3_;
            _baseView.x = _offRect.x;
            _baseView.y = _offRect.y;
            _hitRect.x = x + _offRect.x;
            _hitRect.y = y + _offRect.y;
            _hitRect.width = _loc2_.width;
            _hitRect.height = _loc2_.height;
         }
      }
      
      override public function get hitRect() : LogicRectangle
      {
         _hitRect.x = x + _offRect.x;
         _hitRect.y = y + _offRect.y;
         return _hitRect;
      }
      
      protected function get maxSize() : int
      {
         var _loc1_:Object = null;
         var _loc2_:int = 1;
         for each(var _loc3_:ResourceAvatarInfo in resourceList)
         {
            _loc1_ = MapUtisl.sizeMax[_loc3_.sizeType];
            if(_loc1_.size > MapUtisl.sizeMax[_loc2_].size)
            {
               _loc2_ = _loc3_.sizeType;
            }
         }
         return _loc2_;
      }
      
      public function get sizeType() : int
      {
         return _sizeType;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state != param1)
         {
            _state = param1;
            updateDepth();
            nextFrameX();
         }
      }
      
      public function isReverse() : Boolean
      {
         return _face;
      }
      
      override protected function updateOver() : void
      {
         switch(_state - 1)
         {
            case 0:
               drawJump();
               break;
            case 1:
               drawAttack();
               break;
            case 2:
               drawStand();
               break;
            case 3:
               darwWalk();
         }
         super.updateOver();
      }
      
      override protected function updateStart() : void
      {
         play();
         switch(_state - 1)
         {
            case 0:
               drawJumpPrepare();
               break;
            case 1:
               drawAttackPrepare();
               break;
            case 2:
               drawStandPrepare();
               break;
            case 3:
               darwWalkPrepare();
         }
      }
      
      protected function darwWalkPrepare() : void
      {
         for each(var _loc1_:ResourceAvatarInfo in resourceList)
         {
            if(_loc1_.loadOver)
            {
               _loc1_.getAvatarWalksCellByFrame(frameX,frameY);
               _loc1_.visible = true;
            }
         }
      }
      
      protected function drawStandPrepare() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_:ResourceAvatarInfo in resourceList)
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = getStandStateFrameY(frameY);
               _loc2_.getAvatarStandCellByFrame(frameX,_loc1_);
            }
         }
      }
      
      protected function drawJumpPrepare() : void
      {
      }
      
      protected function drawAttackPrepare() : void
      {
         for each(var _loc1_:ResourceAvatarInfo in resourceList)
         {
            if(!(!_loc1_.visible || !_loc1_.loadOver))
            {
               _loc1_.getAvatarAttackCellByFrame(frameX,frameY);
            }
         }
      }
      
      protected function getStandStateFrameY(param1:int) : int
      {
         var _loc2_:int = 2;
         if(sizeType != 10)
         {
            if(param1 == 1 || param1 == 0)
            {
               _loc2_ = 0;
            }
            else if(param1 == 3 || param1 == 2)
            {
               _loc2_ = 1;
            }
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      protected function drawStand() : void
      {
         var _loc1_:Object = null;
         var _loc4_:Object = null;
         if(!_baseView)
         {
            return;
         }
         var _loc2_:int = getStandStateFrameY(frameY);
         _baseView.bitmapData.lock();
         _baseView.bitmapData.fillRect(new Rectangle(0,0,_baseView.width,_baseView.height),0);
         for each(var _loc3_:ResourceAvatarInfo in resourceList)
         {
            if(!(!_loc3_.visible || !_loc3_.loadOver))
            {
               _loc1_ = MapUtisl.sizeMax[_loc3_.sizeType];
               _loc4_ = _loc3_.layouPara.getCellByKey(frameX,_loc2_);
               if(_loc1_ && _loc3_.nextBitmapData)
               {
                  _drawRect.x = _drawRect.y = 0;
                  _drawRect.width = _loc3_.nextBitmapData.width;
                  _drawRect.height = _loc3_.nextBitmapData.height;
                  _destPoint.x = _loc1_.x + int(_loc4_["x"]) - _offRect.x;
                  _destPoint.y = _loc1_.y + int(_loc4_["y"]) - _offRect.y;
                  _baseView.bitmapData.copyPixels(_loc3_.nextBitmapData,_drawRect,_destPoint,null,null,true);
               }
            }
         }
         _baseView.bitmapData.unlock();
         _baseView.scaleX = mirror;
         if(_baseView.scaleX == 1)
         {
            _baseView.x = -(_baseView.width >> 1);
         }
         else
         {
            _baseView.x = _baseView.width >> 1;
         }
      }
      
      protected function darwWalk() : void
      {
         var _loc1_:Object = null;
         var _loc3_:Object = null;
         if(!_baseView)
         {
            return;
         }
         _baseView.bitmapData.lock();
         _baseView.bitmapData.fillRect(new Rectangle(0,0,_baseView.width,_baseView.height),0);
         for each(var _loc2_:ResourceAvatarInfo in resourceList)
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = MapUtisl.sizeMax[_loc2_.sizeType];
               _loc3_ = _loc2_.walkLayouPara.getCellByKey(frameX,frameY);
               if(_loc1_)
               {
                  _drawRect.x = _drawRect.y = 0;
                  _drawRect.width = _loc2_.nextBitmapData.width;
                  _drawRect.height = _loc2_.nextBitmapData.height;
                  _destPoint.x = _loc1_.x + int(_loc3_["x"]) - _offRect.x;
                  _destPoint.y = _loc1_.y + int(_loc3_["y"]) - _offRect.y;
                  _baseView.bitmapData.copyPixels(_loc2_.nextBitmapData,_drawRect,_destPoint,null,null,true);
               }
            }
         }
         _baseView.bitmapData.unlock();
         _baseView.scaleX = mirror;
         if(_baseView.scaleX == 1)
         {
            _baseView.x = -(_baseView.width >> 1);
         }
         else
         {
            _baseView.x = _baseView.width >> 1;
         }
      }
      
      protected function drawJump() : void
      {
         throw new Error("JUMP状{invalid_utf8=230}?{invalid_utf8=129}下未实现画操作");
      }
      
      protected function drawAttack() : void
      {
         var _loc1_:Object = null;
         var _loc3_:Object = null;
         if(!_baseView)
         {
            return;
         }
         _baseView.bitmapData.lock();
         _baseView.bitmapData.fillRect(new Rectangle(0,0,_baseView.width,_baseView.height),0);
         for each(var _loc2_:ResourceAvatarInfo in resourceList)
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = MapUtisl.sizeMax[_loc2_.sizeType];
               _loc3_ = _loc2_.attackLayouPara.getCellByKey(frameX,frameY);
               if(_loc1_ && _loc2_.nextBitmapData)
               {
                  _drawRect.x = _drawRect.y = 0;
                  _drawRect.width = _loc2_.nextBitmapData.width;
                  _drawRect.height = _loc2_.nextBitmapData.height;
                  _destPoint.x = _loc1_.x + int(_loc3_["x"]) - _offRect.x;
                  _destPoint.y = _loc1_.y + int(_loc3_["y"]) - _offRect.y;
                  _baseView.bitmapData.copyPixels(_loc2_.nextBitmapData,_drawRect,_destPoint,null,null,true);
               }
            }
         }
         _baseView.bitmapData.unlock();
         _baseView.scaleX = mirror;
         if(_baseView.scaleX == 1)
         {
            _baseView.x = -(_baseView.width >> 1);
         }
         else
         {
            _baseView.x = _baseView.width >> 1;
         }
      }
      
      override protected function nextFrameX() : void
      {
         frameX = frameX + 1;
         switch(_state - 1)
         {
            case 0:
               if(frameX >= _jumpTotalFrameX)
               {
                  frameX = 0;
               }
               break;
            case 1:
               if(frameX >= _attackTotalFrameX)
               {
                  frameX = 0;
               }
               break;
            case 2:
               if(frameX >= _standTotalFrameX)
               {
                  frameX = 0;
               }
               break;
            case 3:
               if(frameX >= _walkTotalFrameX)
               {
                  frameX = 0;
               }
         }
      }
      
      protected function updateDepth() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         switch(state - 1)
         {
            case 0:
               throw new Error("JUMP\t状{invalid_utf8=230}?{invalid_utf8=129}下未实现深度切{invalid_utf8=230}{invalid_utf8=141}?");
            case 1:
               _loc1_ = frameY;
               break;
            case 2:
               _loc1_ = getStandStateFrameY(frameY);
               break;
            case 3:
               _loc1_ = frameY;
         }
         for each(_loc2_ in resourceList)
         {
            _loc2_.curBaseNum = _loc2_.sornBaseNum[_loc1_];
         }
         resourceList.sortOn("curBaseNum",0x10 | 2);
      }
      
      override public function set frameY(param1:int) : void
      {
         if(frameY != param1)
         {
            super.frameY = param1;
            updateDepth();
            updateStart();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function get curResourceType() : int
      {
         return 3;
      }
   }
}


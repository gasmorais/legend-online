package avatar.view
{
   import avatar.data.AvatarBaseLayer;
   import avatar.data.AvatarLayouData;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.utils.MapUtisl;
   
   public class HeroAvatar extends HumanAvatar
   {
      
      protected var _curStepFrame:int;
      
      protected var _delayLoad:Boolean;
      
      protected var _mirror:int;
      
      private var _avatarStandList:Array = [];
      
      private var _avatarWalkList:Array = [];
      
      private var _defaultMovie:MovieClip;
      
      private var _defaultBitmap:Bitmap;
      
      protected var _isShowDefault:Boolean;
      
      private var _destPoint:Point = new Point();
      
      private var _footPrint:FootprintView;
      
      private var _isPlaying:Boolean = true;
      
      private var _isShowWeapons:Boolean;
      
      private var _isStandPosMount:Boolean;
      
      private var _loadAvatarBackCall:Function;
      
      private var _propertyChangeCallback:Function;
      
      private var _nodeLoadKey:String;
      
      private var _positionDict:Dictionary = new Dictionary(true);
      
      private var _standWalkDValue:int = 2;
      
      private var _standFrameX:int;
      
      private var _standTotalFrameX:int = 5;
      
      private var _stepFrame:int = 2;
      
      private var _isLockStepFrame:Boolean;
      
      private var _mount:String;
      
      public function HeroAvatar(param1:Boolean, param2:String, param3:int, param4:int, param5:Boolean, param6:int = 0, param7:String = "auto", param8:Boolean = true)
      {
         _isShowDefault = param1;
         _delayLoad = param5;
         _state = 4;
         var _loc9_:Boolean = param3 == 2 ? false : true;
         super(param2,_loc9_,param7,param8);
         type = param3;
         if(_loc9_ || param1)
         {
            _defaultMovie = ComponentFactory.Instance.creatCustomObject("asset.avatar.DefaultAvatarMovieAsset");
            _defaultBitmap = ComponentFactory.Instance.creatBitmap("asset.avatar.DefaultAvatarImage");
            addChild(_defaultBitmap);
            _defaultBitmap.visible = false;
            addChild(_defaultMovie);
         }
      }
      
      public function set propertyChangeCallback(param1:Function) : void
      {
         _propertyChangeCallback = param1;
      }
      
      override public function set angle(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         if(angle == param1)
         {
            return;
         }
         var _loc3_:int = frameY;
         super.angle = param1;
         var _loc4_:int = _mirror;
         if(_isStandPosMount)
         {
            if(param1 >= 270 && param1 < 310)
            {
               frameY = 4;
               _mirror = 1;
            }
            else if(param1 >= 225 && param1 < 270)
            {
               frameY = 4;
               _mirror = -1;
            }
            else if(param1 >= 310 && param1 < 320)
            {
               frameY = 3;
               _mirror = 1;
            }
            else if(param1 >= 320 || param1 < 40)
            {
               frameY = 2;
               _mirror = 1;
            }
            else if(param1 >= 40 && param1 < 45)
            {
               frameY = 1;
               _mirror = 1;
            }
            else if(param1 >= 45 && param1 <= 90)
            {
               frameY = 0;
               _mirror = 1;
            }
            else if(param1 > 90 && param1 < 135)
            {
               frameY = 0;
               _mirror = -1;
            }
            else if(param1 < 140 && param1 >= 135)
            {
               frameY = 1;
               _mirror = -1;
            }
            else if(param1 < 220 && param1 >= 140)
            {
               frameY = 2;
               _mirror = -1;
            }
            else if(param1 < 225 && param1 >= 220)
            {
               frameY = 3;
               _mirror = -1;
            }
         }
         else if(param1 >= 270 && param1 < 280)
         {
            frameY = 4;
            _mirror = 1;
         }
         else if(param1 >= 260 && param1 < 270)
         {
            frameY = 4;
            _mirror = -1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            frameY = 3;
            _mirror = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            frameY = 2;
            _mirror = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            frameY = 1;
            _mirror = 1;
         }
         else if(param1 >= 80 && param1 <= 90)
         {
            frameY = 0;
            _mirror = 1;
         }
         else if(param1 > 90 && param1 < 100)
         {
            frameY = 0;
            _mirror = -1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            frameY = 1;
            _mirror = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            frameY = 2;
            _mirror = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            frameY = 3;
            _mirror = -1;
         }
         _loc2_ = _loc3_ != frameY;
         if(_loc2_)
         {
            _curStepFrame = _stepFrame;
         }
         if(_propertyChangeCallback != null && (_loc4_ != _mirror || _loc2_))
         {
            _propertyChangeCallback();
         }
         play();
      }
      
      override public function dispose() : void
      {
         removeAllAvatar();
         if(_footPrint)
         {
            _footPrint.dispose();
         }
         _footPrint = null;
         removeDefaultMovie();
         _avatarStandList = null;
         _avatarWalkList = null;
         _positionDict = null;
         super.dispose();
      }
      
      override public function set frameY(param1:int) : void
      {
         if(param1 == frameY)
         {
            return;
         }
         super.frameY = param1;
         nextFramePrepare();
         updateDepth();
      }
      
      override public function getCurrentPixels() : uint
      {
         if(_bitmap && _bitmap.bitmapData)
         {
            return _bitmap.bitmapData.getPixel(_bitmap.mouseX,_bitmap.mouseY);
         }
         if(isShowDefault)
         {
            if(_defaultBitmap && _defaultBitmap.bitmapData)
            {
               return _defaultBitmap.bitmapData.getPixel(_defaultBitmap.mouseX,_defaultBitmap.mouseY);
            }
         }
         return 0;
      }
      
      override public function set isShowWeapons(param1:Boolean) : void
      {
         _isShowWeapons = param1;
      }
      
      public function set isStandPosMount(param1:Boolean) : void
      {
         _isStandPosMount = param1;
      }
      
      public function set playing(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      override public function removeAllAvatar() : void
      {
         _body = "";
         _mount = "";
         removeAvatarList(_avatarWalkList);
         removeAvatarList(_avatarStandList);
         ObjectUtils.clearDictionary(_positionDict);
      }
      
      override public function run() : void
      {
         if(_curStepFrame == _stepFrame - 1)
         {
            nextFramePrepare();
            _curStepFrame = _curStepFrame + 1;
         }
         else if(_curStepFrame >= _stepFrame)
         {
            _curStepFrame = 0;
            super.run();
         }
         else
         {
            _curStepFrame = _curStepFrame + 1;
         }
         var _loc1_:int = findFlyHeight();
         if(_loc1_ != flight)
         {
            flight = _loc1_;
            contentBitmap.y = flight + sizeMax[this.sizeType].y;
            dispatchEvent(new Event("sizeTypeChange"));
         }
      }
      
      public function setPositionVisible(param1:String, param2:Boolean) : void
      {
         for each(var _loc4_:AvatarBaseLayer in _avatarWalkList)
         {
            if(_loc4_.resourceInfo.position == param1)
            {
               _loc4_.visible = param2;
            }
         }
         for each(var _loc3_:AvatarBaseLayer in _avatarStandList)
         {
            if(_loc3_.resourceInfo.position == param1)
            {
               _loc3_.visible = param2;
            }
         }
      }
      
      public function showNextFrame() : void
      {
         nextFrameX();
         draw();
      }
      
      public function showPreFrame() : void
      {
         preframeX();
         draw();
      }
      
      override public function set sizeType(param1:int) : void
      {
         super.sizeType = param1;
         if(type == 2)
         {
            return;
         }
         if(!_footPrint)
         {
            _footPrint = new FootprintView(this);
            _footPrint.footPrintLayer = footPrintLayer;
            _footPrint.type = type;
         }
         _footPrint.createFoots();
      }
      
      override public function set footPrintLayer(param1:Sprite) : void
      {
         super.footPrintLayer = param1;
         if(!_footPrint)
         {
            _footPrint = new FootprintView(this);
            _footPrint.type = type;
            _footPrint.createFoots();
         }
         _footPrint.footPrintLayer = footPrintLayer;
      }
      
      public function get standTotalFrameX() : int
      {
         return _standTotalFrameX;
      }
      
      public function set standTotalFrameX(param1:int) : void
      {
         _standTotalFrameX = param1;
      }
      
      override public function set state(param1:int) : void
      {
         if(param1 != _state)
         {
            super.state = param1;
            nextFrameX();
            _curStepFrame = _stepFrame;
            nextFramePrepare();
            if(_propertyChangeCallback != null)
            {
               _propertyChangeCallback();
            }
         }
      }
      
      public function get stepFrame() : int
      {
         return _stepFrame;
      }
      
      override public function set stepFrame(param1:int) : void
      {
         if(_isLockStepFrame)
         {
            return;
         }
         _stepFrame = param1;
      }
      
      public function get isLockStepFrame() : Boolean
      {
         return _isLockStepFrame;
      }
      
      public function set isLockStepFrame(param1:Boolean) : void
      {
         _isLockStepFrame = param1;
      }
      
      override public function set type(param1:int) : void
      {
         super.type = param1;
         if(type == 2)
         {
            totalFrameX = curTotalFrameX;
            if(_footPrint)
            {
               _footPrint.clearFoots();
            }
         }
         else if(type == 1)
         {
            totalFrameX = 8;
         }
      }
      
      override protected function drawAttack() : void
      {
      }
      
      override protected function drawJump() : void
      {
      }
      
      override protected function darwWalk() : void
      {
         var _loc7_:* = null;
         var _loc1_:Object = null;
         var _loc6_:* = undefined;
         var _loc3_:int = getFrameY(frameY);
         if(!_bitmap.bitmapData)
         {
            _bitmap.bitmapData = new BitmapData(size.x,size.y,true,0);
         }
         _bitmap.bitmapData.lock();
         _bitmap.bitmapData.fillRect(_bitmap.bitmapData.rect,0);
         var _loc4_:int = getOffsetY("walk");
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         if(_isStandPosMount)
         {
            for each(_loc7_ in _avatarWalkList)
            {
               if(!(!_loc7_.visible || !_loc7_.loadOver))
               {
                  if(_loc7_.tempBitmapData)
                  {
                     _loc1_ = sizeMax[_loc7_.sizeType];
                     if(_loc1_)
                     {
                        if(isMountPart(_loc7_.resourceInfo.position))
                        {
                           _loc6_ = _loc7_.layouPara.getCellByKey(frameX,frameY);
                        }
                        else
                        {
                           _loc6_ = _loc7_.layouPara.getCellByKey(standWalkFrameX,_loc3_);
                        }
                        if(_loc6_ == null)
                        {
                           _loc6_ = _loc7_.layouPara.getCellByKey(frameX,_loc3_);
                        }
                        if(_loc6_)
                        {
                           _loc8_ = _loc4_;
                           if(isMountPart(_loc7_.resourceInfo.position))
                           {
                              _loc8_ = 0;
                           }
                           _loc2_ = _loc7_.offsetX;
                           _drawRect.x = 0;
                           _drawRect.y = 0;
                           _destPoint.x = _loc1_.x - sizeMax[this.sizeType].x + int(_loc6_["x"]) + _loc2_ + _loc5_;
                           _destPoint.y = _loc1_.y - sizeMax[this.sizeType].y + int(_loc6_["y"]) + _loc8_;
                           _drawRect.width = _loc7_.tempBitmapData.width;
                           _drawRect.height = _loc7_.tempBitmapData.height;
                           _bitmap.bitmapData.copyPixels(_loc7_.tempBitmapData,_drawRect,_destPoint,null,null,true);
                        }
                     }
                  }
               }
            }
         }
         else
         {
            for each(_loc7_ in _avatarWalkList)
            {
               if(!(!_loc7_.visible || !_loc7_.loadOver))
               {
                  if(_loc7_.tempBitmapData)
                  {
                     _loc1_ = sizeMax[_loc7_.sizeType];
                     if(_loc1_)
                     {
                        _loc6_ = _loc7_.layouPara.getCellByKey(frameX,frameY);
                        if(_loc6_ == null)
                        {
                           _loc6_ = _loc7_.layouPara.getCellByKey(frameX,getFrameY(frameY));
                        }
                        if(_loc6_)
                        {
                           _loc8_ = _loc4_;
                           if(isMountPart(_loc7_.resourceInfo.position))
                           {
                              _loc8_ = 0;
                           }
                           _loc2_ = _loc7_.offsetX;
                           _drawRect.x = 0;
                           _drawRect.y = 0;
                           _destPoint.x = _loc1_.x - sizeMax[this.sizeType].x + int(_loc6_["x"]) + _loc2_ + _loc5_;
                           _destPoint.y = _loc1_.y - sizeMax[this.sizeType].y + int(_loc6_["y"]) + _loc8_;
                           _drawRect.width = _loc7_.tempBitmapData.width;
                           _drawRect.height = _loc7_.tempBitmapData.height;
                           _bitmap.bitmapData.copyPixels(_loc7_.tempBitmapData,_drawRect,_destPoint,null,null,true);
                        }
                     }
                  }
               }
            }
         }
         _bitmap.bitmapData.unlock();
         _bitmap.scaleX = _mirror;
         if(_mirror == -1)
         {
            _bitmap.x = -sizeMax[this.sizeType].x;
         }
         else
         {
            _bitmap.x = sizeMax[this.sizeType].x;
         }
         if(_footPrint)
         {
            _footPrint.drawFootPrints(frameX,frameY);
         }
      }
      
      override protected function darwWalkPrepare() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_:AvatarBaseLayer in _avatarWalkList)
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               if(_isStandPosMount)
               {
                  if(isMountPart(_loc2_.resourceInfo.position))
                  {
                     _loc2_.getWalksCellByFrame(frameX,frameY);
                  }
                  else
                  {
                     _loc1_ = getFrameY(frameY);
                     _loc2_.getStandCellByFrame(standWalkFrameX,_loc1_);
                  }
               }
               else
               {
                  _loc2_.getWalksCellByFrame(frameX,frameY);
               }
            }
         }
      }
      
      override protected function drawStand() : void
      {
         var _loc1_:Object = null;
         var _loc5_:* = undefined;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = getFrameY(frameY);
         if(!_bitmap.bitmapData)
         {
            _bitmap.bitmapData = new BitmapData(size.x,size.y,true,0);
         }
         _bitmap.bitmapData.lock();
         _bitmap.bitmapData.fillRect(_bitmap.bitmapData.rect,0);
         var _loc4_:int = getOffsetY("stand");
         for each(var _loc6_:AvatarBaseLayer in _avatarStandList)
         {
            if(!(!_loc6_.visible || !_loc6_.loadOver))
            {
               if(_loc6_.tempBitmapData)
               {
                  _loc1_ = sizeMax[_loc6_.sizeType];
                  if(_loc1_)
                  {
                     _loc5_ = _loc6_.layouPara.getCellByKey(frameX,_loc3_);
                     if(_loc5_)
                     {
                        _loc7_ = _loc4_;
                        if(isMountPart(_loc6_.resourceInfo.position))
                        {
                           _loc7_ = 0;
                        }
                        _loc2_ = 0;
                        _drawRect.x = 0;
                        _drawRect.y = 0;
                        _destPoint.x = _loc1_.x - sizeMax[this.sizeType].x + int(_loc5_["x"]) + _loc2_;
                        _destPoint.y = _loc1_.y - sizeMax[this.sizeType].y + int(_loc5_["y"]) + _loc7_;
                        _drawRect.width = _loc6_.tempBitmapData.width;
                        _drawRect.height = _loc6_.tempBitmapData.height;
                        _bitmap.bitmapData.copyPixels(_loc6_.tempBitmapData,_drawRect,_destPoint,null,null,true);
                     }
                  }
               }
            }
         }
         _bitmap.bitmapData.unlock();
         _bitmap.scaleX = _mirror;
         if(_mirror == -1)
         {
            _bitmap.x = -sizeMax[this.sizeType].x;
         }
         else
         {
            _bitmap.x = sizeMax[this.sizeType].x;
         }
         if(_footPrint)
         {
            _footPrint.drawFootPrints(frameX,frameY);
         }
      }
      
      override protected function drawStandPrepare() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_:AvatarBaseLayer in _avatarStandList)
         {
            if(!(!_loc2_.visible || !_loc2_.loadOver))
            {
               _loc1_ = getFrameY(frameY);
               _loc2_.getStandCellByFrame(frameX,_loc1_);
            }
         }
      }
      
      protected function get standWalkFrameX() : int
      {
         return int(_standFrameX / _standWalkDValue);
      }
      
      protected function preframeX() : void
      {
         frameX = Number(frameX) - 1;
         _standFrameX = _standFrameX - 1;
         if(frameX < 0)
         {
            switch(int(_state) - 3)
            {
               case 0:
                  frameX = standTotalFrameX - 1;
                  break;
               case 1:
                  frameX = totalFrameX - 1;
                  _standFrameX = standTotalFrameX * _standWalkDValue - 1;
            }
         }
      }
      
      override protected function nextFrameX() : void
      {
         frameX = Number(frameX) + 1;
         _standFrameX = _standFrameX + 1;
         switch(int(_state) - 3)
         {
            case 0:
               if(frameX >= standTotalFrameX)
               {
                  frameX = 0;
               }
               break;
            case 1:
               if(frameX >= totalFrameX)
               {
                  frameX = 0;
               }
               if(_standFrameX >= standTotalFrameX * _standWalkDValue)
               {
                  _standFrameX = 0;
               }
         }
      }
      
      override public function loaderCompleteHandler(param1:ResourceLoaderInfo, param2:Object) : void
      {
         if(checkDomainResource(param1.url,param1.position))
         {
            loadAvatarResourceResult(param1.url,param1);
         }
      }
      
      private function checkDomainResource(param1:String, param2:String) : Boolean
      {
         var _loc3_:String = MapUtisl.getPackageName(param1) + "S_0_0";
         if(DomainResourceLoad.loaderContext)
         {
            return DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc3_);
         }
         return false;
      }
      
      public function createResourceLoadInfo(param1:String, param2:Array, param3:Array, param4:String) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.packageName = MapUtisl.getPackageName(param1);
         _loc5_.stand = param2;
         _loc5_.walk = param3;
         _loc5_.position = param4;
         _loc5_.url = param1;
         return _loc5_;
      }
      
      private function getAvatarByPosition(param1:String, param2:String, param3:Array) : AvatarBaseLayer
      {
         var _loc4_:AvatarBaseLayer = null;
         for each(_loc4_ in param3)
         {
            if(_loc4_.resourceInfo.position == param1 && _loc4_.resourceInfo.positionAddSign == param2)
            {
               return _loc4_;
            }
         }
         _loc4_ = new AvatarBaseLayer();
         if(param3)
         {
            param3.push(_loc4_);
         }
         return _loc4_;
      }
      
      private function getFrameY(param1:int) : int
      {
         var _loc2_:int = 2;
         if(sizeType != 10 || SizeType_NEW10.indexOf(currentMountId) != -1)
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
      
      private function getOffsetY(param1:String = "stand") : int
      {
         var _loc4_:AvatarBaseLayer = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 == "walk")
         {
            _loc2_ = _avatarWalkList;
         }
         else if(param1 == "stand")
         {
            _loc2_ = _avatarStandList;
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.resourceInfo.position == "mount")
            {
               _loc3_ = _loc4_.offsetY;
               break;
            }
         }
         _loc4_ = null;
         return _loc3_;
      }
      
      private function isMountPart(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 == "mount" || param1 == "mountWing")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function loadAvatarResourceResult(param1:String, param2:ResourceLoaderInfo) : void
      {
         if(param2.position == "body")
         {
            _body = param1;
         }
         if(param2.position == "mount")
         {
            _mount = param1;
         }
         var _loc4_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         var _loc3_:int = int(_loc4_ ? _loc4_.sizeType : 1);
         var _loc5_:AvatarBaseLayer = getAvatarByPosition(param2.position,param2.positionAddSign,_avatarStandList);
         _loc5_.resourceInfo = param2;
         _loc5_.layouPara = new AvatarLayouData(_loc4_.standsPara);
         _loc5_.sizeType = _loc3_;
         _loc5_.loadOver = true;
         _loc5_.offsetY = _loc4_.offsetY ? _loc4_.offsetY : 0;
         if(checkDomainResource(param1,param2.position))
         {
            _loc5_ = getAvatarByPosition(param2.position,param2.positionAddSign,_avatarWalkList);
            _loc5_.resourceInfo = param2;
            if(_isStandPosMount)
            {
               if(isMountPart(param2.position))
               {
                  _loc5_.layouPara = new AvatarLayouData(_loc4_.walksPara);
               }
               else
               {
                  _loc5_.layouPara = new AvatarLayouData(_loc4_.standsPara);
               }
            }
            else
            {
               _loc5_.layouPara = new AvatarLayouData(_loc4_.walksPara);
            }
            _loc5_.sizeType = _loc3_;
            _loc5_.loadOver = true;
            _loc5_.offsetY = _loc4_.offsetY ? _loc4_.offsetY : 0;
         }
         if(_nodeLoadKey == param1)
         {
            if(_loadAvatarBackCall != null)
            {
               _loadAvatarBackCall(param1);
            }
            _loadAvatarBackCall = null;
         }
         resetSizeType();
         nextFramePrepare();
         updateDepth();
         removeDefaultMovie();
      }
      
      public function get mount() : String
      {
         return _mount;
      }
      
      public function clearLayoutOffset() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _avatarStandList)
         {
            _loc1_.layouPara.clearOffset();
         }
         for each(_loc1_ in _avatarWalkList)
         {
            _loc1_.layouPara.clearOffset();
         }
      }
      
      private function findFlyHeight() : int
      {
         var _loc1_:Object = null;
         for each(var _loc2_:AvatarBaseLayer in _avatarStandList)
         {
            if(_loc2_.resourceInfo.position == "mount")
            {
               _loc1_ = LoaderHeaderList.avatarShowNamePos[_loc2_.resourceInfo.url];
               if(_loc1_.hasOwnProperty("flight"))
               {
                  return _loc1_.flight;
               }
            }
         }
         return 0;
      }
      
      private function removeAvatarList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AvatarBaseLayer = null;
         if(param1 && param1.length > 0)
         {
            _loc2_ = int(param1.length);
            while(param1.length > 0)
            {
               _loc3_ = param1.pop() as AvatarBaseLayer;
               _loc3_.dispose();
            }
         }
         param1 = null;
         _loc3_ = null;
      }
      
      public function removeDefaultMovie() : void
      {
         if(_defaultMovie)
         {
            if(_defaultMovie.parent)
            {
               _defaultMovie.parent.removeChild(_defaultMovie);
            }
            _defaultMovie.stop();
         }
         if(_defaultBitmap)
         {
            ObjectUtils.disposeObject(_defaultBitmap);
         }
         _defaultBitmap = null;
         _defaultMovie = null;
      }
      
      private function resetSizeType() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 7;
         for each(_loc2_ in _avatarWalkList)
         {
            if(sizeMax[_loc2_.sizeType].size > sizeMax[_loc1_].size)
            {
               _loc1_ = _loc2_.sizeType;
            }
         }
         for each(_loc2_ in _avatarStandList)
         {
            if(sizeMax[_loc2_.sizeType].size > sizeMax[_loc1_].size)
            {
               _loc1_ = _loc2_.sizeType;
            }
         }
         this.sizeType = _loc1_;
      }
      
      override public function removeAvatar(param1:String) : void
      {
         spliceByPosition(param1,_avatarStandList);
         spliceByPosition(param1,_avatarWalkList);
         delete _positionDict[param1];
         if(param1 == "body")
         {
            _body = "";
         }
         if(param1 == "mount")
         {
            _mount = "";
         }
      }
      
      public function removeAvatarByPositionAddSign(param1:String, param2:String = null) : void
      {
         var positionAddSign:String = param1;
         var position:String = param2;
         var spliceBypositionAddSign:* = function(param1:Array):void
         {
            var _loc2_:AvatarBaseLayer = null;
            var _loc4_:int = 0;
            var _loc3_:int = int(param1.length);
            var _loc5_:Boolean = false;
            _loc4_ = _loc3_ - 1;
            while(_loc4_ >= 0)
            {
               _loc2_ = param1[_loc4_];
               if(_loc2_.resourceInfo.positionAddSign == positionAddSign)
               {
                  _loc5_ = false;
                  if(position != null && _loc2_.resourceInfo.position != position)
                  {
                     _loc5_ = true;
                  }
                  if(_loc5_ && isMountPosition && _loc2_.resourceInfo.position == "mountWing")
                  {
                     _loc5_ = false;
                  }
                  if(!_loc5_)
                  {
                     param1.splice(_loc4_,1);
                     _loc2_.dispose();
                  }
               }
               _loc4_--;
            }
         };
         var isMountPosition:Boolean = position == "mount";
         if(isMountPosition)
         {
            _mount = "";
         }
         spliceBypositionAddSign(_avatarStandList);
         spliceBypositionAddSign(_avatarWalkList);
      }
      
      private function spliceByPosition(param1:String, param2:Array) : void
      {
         var _loc3_:AvatarBaseLayer = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_];
            if(_loc3_.resourceInfo.position == param1)
            {
               param2.splice(_loc4_,1);
               _loc3_.dispose();
               break;
            }
            _loc4_++;
         }
      }
      
      private function updateDepth() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _avatarWalkList)
         {
            _loc2_.curBaseNum = _loc2_.resourceInfo.walk[frameY];
         }
         _avatarWalkList = _avatarWalkList.sortOn("curBaseNum",0x10 | 2);
         switch(frameY)
         {
            case 0:
            case 1:
               _loc1_ = 0;
               break;
            case 2:
            case 3:
               _loc1_ = 1;
               break;
            default:
               _loc1_ = 2;
         }
         for each(_loc2_ in _avatarStandList)
         {
            _loc2_.curBaseNum = _loc2_.resourceInfo.stand[_loc1_];
         }
         _avatarStandList = _avatarStandList.sortOn("curBaseNum",0x10 | 2);
      }
      
      public function get mirror() : int
      {
         return _mirror;
      }
      
      public function get isShowDefault() : Boolean
      {
         return _isShowDefault;
      }
   }
}


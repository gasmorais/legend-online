package avatar.view
{
   import avatar.data.AvatarBaseLayer;
   import avatar.data.AvatarLayouData;
   import avatar.data.SimpleAvatarInfo;
   import avatar.utils.SimpleAvatarPool;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.utils.MapUtisl;
   
   public class SharedAvatar extends HumanAvatar
   {
      
      protected var _curStepFrame:int;
      
      protected var _delayLoad:Boolean;
      
      protected var _mirror:int;
      
      private var _avatarStandList:Array = [];
      
      private var _avatarWalkList:Array = [];
      
      private var _defaultMovie:MovieClip;
      
      private var _destPoint:Point = new Point();
      
      private var _footPrint:FootprintView;
      
      private var _isPlaying:Boolean = true;
      
      private var _isShowWeapons:Boolean;
      
      private var _loadAvatarBackCall:Function;
      
      private var _nodeLoadKey:String;
      
      private var _positionDict:Dictionary = new Dictionary(true);
      
      private var _standFrameX:int;
      
      private var _standTotalFrameX:int = 5;
      
      private var _stepFrame:int = 2;
      
      private var _partCount:int = 0;
      
      private var _partLoaded:int = 0;
      
      private var _partComplete:Boolean = false;
      
      private var _simpleAvatarInfo:SimpleAvatarInfo;
      
      private var _url:String;
      
      public function SharedAvatar(param1:String, param2:int, param3:int, param4:Boolean, param5:int = 0, param6:String = "auto", param7:Boolean = true)
      {
         _delayLoad = param4;
         _state = 4;
         var _loc8_:Boolean = param2 == 2 ? false : true;
         super(param1,_loc8_,param6,param7);
         type = param2;
         if(_loc8_)
         {
            _defaultMovie = ComponentFactory.Instance.creatCustomObject("asset.avatar.DefaultAvatarMovieAsset");
            addChild(_defaultMovie);
         }
      }
      
      override public function set angle(param1:Number) : void
      {
         if(angle == param1)
         {
            return;
         }
         var _loc2_:int = frameY;
         super.angle = param1;
         var _loc3_:int = _mirror;
         if(param1 >= 260 && param1 < 280)
         {
            frameY = 4;
            _mirror = 1;
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
         else if(param1 >= 80 && param1 < 100)
         {
            frameY = 0;
            _mirror = 1;
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
         if(_loc2_ != frameY)
         {
            _curStepFrame = _stepFrame;
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
         _simpleAvatarInfo = null;
         _cleanBitmapData = false;
         super.dispose();
      }
      
      override public function set frameY(param1:int) : void
      {
         if(param1 != frameY)
         {
            super.frameY = param1;
            _partComplete = false;
            checkLoaded();
         }
      }
      
      override public function getCurrentPixels() : uint
      {
         if(_bitmap && _bitmap.bitmapData)
         {
            return _bitmap.bitmapData.getPixel(_bitmap.mouseX,_bitmap.mouseY);
         }
         return 0;
      }
      
      override public function set isShowWeapons(param1:Boolean) : void
      {
         _isShowWeapons = param1;
      }
      
      public function set playing(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      override public function removeAllAvatar() : void
      {
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
            _partComplete = false;
            checkLoaded();
         }
      }
      
      public function get stepFrame() : int
      {
         return _stepFrame;
      }
      
      override public function set stepFrame(param1:int) : void
      {
         _stepFrame = param1;
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
      
      private function urlDecode(param1:String, param2:int, param3:int, param4:String, param5:int, param6:int) : void
      {
         if(_url)
         {
            _url += param1;
         }
         else
         {
            _url = param2 + "_" + param3 + "_" + param5 + "_" + param6 + param1;
         }
      }
      
      override protected function darwWalkPrepare() : void
      {
      }
      
      override protected function drawAttack() : void
      {
      }
      
      override protected function drawJump() : void
      {
      }
      
      override protected function darwWalk() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(_partComplete && _simpleAvatarInfo && _simpleAvatarInfo.tileData[frameX])
         {
            _bitmap.bitmapData = _simpleAvatarInfo.tileData[frameX];
            _bitmap.scaleX = _mirror;
            if(_mirror == -1)
            {
               _bitmap.x = _bitmap.bitmapData.width / 2;
            }
            else
            {
               _bitmap.x = -_bitmap.bitmapData.width / 2;
            }
         }
         else
         {
            _loc1_ = getFrameY(frameY,state);
            _loc2_ = getMD5Key(_url,state,_loc1_);
            if(SimpleAvatarPool.instance.hasSimpleAvatar(_loc2_))
            {
               _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_loc2_);
            }
            else
            {
               checkLoaded();
            }
         }
         _standFrameX = frameX;
         if(_footPrint)
         {
            _footPrint.drawFootPrints(frameX);
         }
      }
      
      override protected function drawStand() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(_partComplete && _simpleAvatarInfo && _simpleAvatarInfo.tileData[frameX])
         {
            _bitmap.bitmapData = _simpleAvatarInfo.tileData[frameX];
            _bitmap.scaleX = _mirror;
            if(_mirror == -1)
            {
               _bitmap.x = _bitmap.bitmapData.width / 2;
            }
            else
            {
               _bitmap.x = -_bitmap.bitmapData.width / 2;
            }
         }
         else
         {
            _loc1_ = getFrameY(frameY,state);
            _loc2_ = getMD5Key(_url,state,_loc1_);
            if(SimpleAvatarPool.instance.hasSimpleAvatar(_loc2_))
            {
               _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_loc2_);
            }
            else
            {
               checkLoaded();
            }
         }
         _standFrameX = _standFrameX + 1;
         if(_standFrameX >= totalFrameX)
         {
            _standFrameX = 0;
         }
         if(_footPrint)
         {
            _footPrint.drawFootPrints(frameX);
         }
      }
      
      override protected function drawStandPrepare() : void
      {
      }
      
      override protected function nextFrameX() : void
      {
         frameX = Number(frameX) + 1;
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
      
      private function getAvatarByPosition(param1:String, param2:Array) : AvatarBaseLayer
      {
         for each(var _loc3_:AvatarBaseLayer in param2)
         {
            if(_loc3_.resourceInfo.position == param1)
            {
               return _loc3_;
            }
         }
         return new AvatarBaseLayer();
      }
      
      private function getFrameY(param1:int, param2:int) : int
      {
         var _loc3_:int = 2;
         if(param2 == 3)
         {
            switch(param1)
            {
               case 0:
               case 1:
                  _loc3_ = 0;
                  break;
               case 2:
               case 3:
                  _loc3_ = 1;
                  break;
               case 4:
                  _loc3_ = 2;
                  break;
               case 5:
               case 6:
               case 7:
                  _loc3_ = 1;
            }
         }
         else if(param2 == 4)
         {
            switch(param1)
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
                  _loc3_ = param1;
                  break;
               case 5:
               case 6:
               case 7:
                  _loc3_ = param1 - 4;
            }
         }
         if(sizeType == 10)
         {
            _loc3_ = 0;
         }
         return _loc3_;
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
      
      private function loadAvatarResourceResult(param1:String, param2:ResourceLoaderInfo) : void
      {
         var _loc4_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         var _loc3_:int = int(_loc4_ ? _loc4_.sizeType : 1);
         var _loc5_:AvatarBaseLayer = getAvatarByPosition(param2.position,_avatarStandList);
         _loc5_.resourceInfo = param2;
         _loc5_.layouPara = new AvatarLayouData(_loc4_.standsPara);
         _loc5_.sizeType = _loc3_;
         _loc5_.loadOver = true;
         _loc5_.offsetY = _loc4_.offsetY ? _loc4_.offsetY : 0;
         spliceByPosition(param2.position,_avatarStandList);
         _avatarStandList.push(_loc5_);
         if(checkDomainResource(param1,param2.position))
         {
            _loc5_ = getAvatarByPosition(param2.position,_avatarWalkList);
            _loc5_.resourceInfo = param2;
            _loc5_.layouPara = new AvatarLayouData(_loc4_.walksPara);
            _loc5_.sizeType = _loc3_;
            _loc5_.loadOver = true;
            _loc5_.offsetY = _loc4_.offsetY ? _loc4_.offsetY : 0;
            spliceByPosition(param2.position,_avatarWalkList);
            _avatarWalkList.push(_loc5_);
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
         _partLoaded = _partLoaded + 1;
         checkLoaded();
      }
      
      public function resetLoaded(param1:int = 1) : void
      {
         _partCount = param1;
         _partLoaded = 0;
         _url = "";
      }
      
      public function checkLoaded() : void
      {
         if(!_partComplete && _partCount != 0 && _partCount <= _partLoaded)
         {
            avatarAnalyzer();
         }
      }
      
      private function avatarAnalyzer() : void
      {
         _partComplete = true;
         _simpleAvatarInfo = null;
         switch(int(_state) - 3)
         {
            case 0:
               analyzeStand();
               break;
            case 1:
               analyzeWalk();
         }
      }
      
      private function analyzeWalk() : void
      {
         var _loc5_:BitmapData = null;
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         var _loc8_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:int = int(totalFrameX);
         var _loc3_:int = getFrameY(frameY,4);
         var _loc7_:String = getMD5Key(_url,4,_loc3_);
         if(SimpleAvatarPool.instance.hasSimpleAvatar(_loc7_))
         {
            _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_loc7_);
            return;
         }
         if(SimpleAvatarPool.instance.existSimpleAvatarLoader(_loc7_))
         {
            return;
         }
         SimpleAvatarPool.instance.registerSimpleAvatarLoader(_loc7_);
         _simpleAvatarInfo = new SimpleAvatarInfo(_loc6_);
         updateDepth();
         frameX = 0;
         while(frameX < _loc6_)
         {
            _loc2_ = getOffsetY("walk");
            _loc5_ = new BitmapData(sizeMax[this.sizeType].width,sizeMax[this.sizeType].height,true,0);
            _loc5_.lock();
            for each(var _loc9_:AvatarBaseLayer in _avatarWalkList)
            {
               if(!(!_loc9_.visible || !_loc9_.loadOver))
               {
                  _loc9_.getWalksCellByFrame(frameX,_loc3_);
                  _loc1_ = sizeMax[_loc9_.sizeType];
                  _loc8_ = _loc9_.layouPara.getCellByKey(frameX,_loc3_);
                  _loc4_ = int(_loc9_.resourceInfo.position == "mount" ? 0 : _loc2_);
                  if(_loc1_)
                  {
                     _drawRect.x = 0;
                     _drawRect.y = 0;
                     _destPoint.x = _loc1_.x - sizeMax[this.sizeType].x + int(_loc8_["x"]);
                     _destPoint.y = _loc1_.y - sizeMax[this.sizeType].y + int(_loc8_["y"]) + _loc4_;
                     _drawRect.width = _loc9_.tempBitmapData.width;
                     _drawRect.height = _loc9_.tempBitmapData.height;
                     _loc5_.copyPixels(_loc9_.tempBitmapData,_drawRect,_destPoint,null,null,true);
                  }
               }
            }
            _loc5_.unlock();
            _simpleAvatarInfo.tileData[frameX] = _loc5_;
            frameX = Number(frameX) + 1;
         }
         if(frameX >= totalFrameX)
         {
            frameX = 0;
         }
         SimpleAvatarPool.instance.addSimpleAvatar(_loc7_,_simpleAvatarInfo);
         SimpleAvatarPool.instance.unregisterSimpleAvatarLoader(_loc7_);
      }
      
      private function analyzeStand() : void
      {
         var _loc5_:BitmapData = null;
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         var _loc8_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:int = standTotalFrameX;
         var _loc3_:int = getFrameY(frameY,3);
         var _loc7_:String = getMD5Key(_url,3,_loc3_);
         if(SimpleAvatarPool.instance.hasSimpleAvatar(_loc7_))
         {
            _simpleAvatarInfo = SimpleAvatarPool.instance.getSimapleAvatar(_loc7_);
            return;
         }
         if(SimpleAvatarPool.instance.existSimpleAvatarLoader(_loc7_))
         {
            return;
         }
         SimpleAvatarPool.instance.registerSimpleAvatarLoader(_loc7_);
         _simpleAvatarInfo = new SimpleAvatarInfo(_loc6_);
         updateDepth();
         frameX = 0;
         while(frameX < _loc6_)
         {
            _loc2_ = getOffsetY("stand");
            _loc5_ = new BitmapData(sizeMax[this.sizeType].width,sizeMax[this.sizeType].height,true,0);
            _loc5_.lock();
            for each(var _loc9_:AvatarBaseLayer in _avatarStandList)
            {
               if(!(!_loc9_.visible || !_loc9_.loadOver))
               {
                  _loc9_.getStandCellByFrame(frameX,_loc3_);
                  _loc1_ = sizeMax[_loc9_.sizeType];
                  _loc8_ = _loc9_.layouPara.getCellByKey(frameX,_loc3_);
                  _loc4_ = int(_loc9_.resourceInfo.position == "mount" ? 0 : _loc2_);
                  if(_loc1_)
                  {
                     _drawRect.x = 0;
                     _drawRect.y = 0;
                     _destPoint.x = _loc1_.x - sizeMax[this.sizeType].x + int(_loc8_["x"]);
                     _destPoint.y = _loc1_.y - sizeMax[this.sizeType].y + int(_loc8_["y"]) + _loc4_;
                     _drawRect.width = _loc9_.tempBitmapData.width;
                     _drawRect.height = _loc9_.tempBitmapData.height;
                     _loc5_.copyPixels(_loc9_.tempBitmapData,_drawRect,_destPoint,null,null,true);
                  }
               }
            }
            _loc5_.unlock();
            _simpleAvatarInfo.tileData[frameX] = _loc5_;
            frameX = Number(frameX) + 1;
         }
         if(frameX >= standTotalFrameX)
         {
            frameX = 0;
         }
         SimpleAvatarPool.instance.addSimpleAvatar(_loc7_,_simpleAvatarInfo);
         SimpleAvatarPool.instance.unregisterSimpleAvatarLoader(_loc7_);
      }
      
      private function getMD5Key(param1:String, param2:int, param3:int) : String
      {
         return param3 + "_" + param2 + "_" + param1;
      }
      
      private function getKey(param1:int, param2:int, param3:int) : String
      {
         return param1 + "_" + "frameX" + param2 + "_" + "frameY" + param3;
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
      
      private function preframeX() : void
      {
         frameX = Number(frameX) - 1;
         if(frameX < 0)
         {
            switch(int(_state) - 3)
            {
               case 0:
                  frameX = standTotalFrameX - 1;
                  break;
               case 1:
                  frameX = totalFrameX - 1;
            }
         }
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
               if(_loc3_.tempBitmapData)
               {
                  _loc3_.tempBitmapData.dispose();
               }
            }
         }
         param1 = null;
         _loc3_ = null;
      }
      
      private function removeDefaultMovie() : void
      {
         if(_defaultMovie)
         {
            if(_defaultMovie.parent)
            {
               _defaultMovie.parent.removeChild(_defaultMovie);
            }
            _defaultMovie.stop();
         }
         _defaultMovie = null;
      }
      
      private function resetSizeType() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 1;
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
               break;
            }
            _loc4_++;
         }
      }
      
      private function updateDepth() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = getFrameY(frameY,4);
         for each(_loc2_ in _avatarWalkList)
         {
            _loc2_.curBaseNum = _loc2_.resourceInfo.walk[_loc1_];
         }
         _avatarWalkList = _avatarWalkList.sortOn("curBaseNum",0x10 | 2);
         _loc1_ = getFrameY(frameY,3);
         for each(_loc2_ in _avatarStandList)
         {
            _loc2_.curBaseNum = _loc2_.resourceInfo.stand[_loc1_];
         }
         _avatarStandList = _avatarStandList.sortOn("curBaseNum",0x10 | 2);
      }
   }
}


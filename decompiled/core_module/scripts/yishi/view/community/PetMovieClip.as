package yishi.view.community
{
   import avatar.data.AvatarLayouData;
   import avatar.view.Avatar;
   import com.pickgliss.loader.DomainResourceLoad;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.utils.MapUtisl;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PathManager;
   
   public class PetMovieClip extends MovieClip implements Disposeable, IEnterFrame
   {
      
      private var _urlKey:String;
      
      private var _position:String = "pet";
      
      private var _sornStand:Array;
      
      private var _sornWalk:Array;
      
      private var _stepFrame:int;
      
      private var _sizeType:int;
      
      private var _cache:Dictionary;
      
      public var standTotalFrameX:int = 5;
      
      private var _url:String;
      
      private var _resourceInfo:ResourceLoaderInfo;
      
      private var _standLayouPara:AvatarLayouData;
      
      private var _walkLayouPara:AvatarLayouData;
      
      private var _loadCompleted:Boolean = false;
      
      private var _dx:int = 0;
      
      private var _frameX:int = 0;
      
      private var _frameY:int = 0;
      
      private var _state:int = 3;
      
      private var _curStepFrame:int = 0;
      
      public function PetMovieClip()
      {
         super();
         _cache = new Dictionary();
         frameY = 0;
         _stepFrame = 2;
      }
      
      override public function play() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      override public function stop() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function get urlKey() : String
      {
         return _urlKey;
      }
      
      public function set urlKey(param1:String) : void
      {
         _urlKey = param1;
         this.url = getResourcePath(param1);
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(param1:String) : void
      {
         var _loc2_:ResourceLoaderInfo = null;
         if(_url == param1)
         {
            return;
         }
         _url = param1;
         _sornStand = [];
         _sornWalk = [];
         if(param1 == null || param1 == "")
         {
            clearAllFrames();
            return;
         }
         if(checkDomainResource(url))
         {
            loadAvatarResourceResult(url,createResourceLoadInfo(url,_sornStand,_sornWalk,_position));
         }
         else
         {
            _loc2_ = createResourceLoadInfo(url,_sornStand,_sornWalk,_position);
            LoaderManagerII.instance.load(url,4,4,__loaderCompleteHandler,null,null,_loc2_);
         }
      }
      
      private function getResourcePath(param1:String) : String
      {
         if(param1)
         {
            return PathManager.resourcePath + "swf/avatar" + param1 + "/" + 2 + ".bswf";
         }
         return param1;
      }
      
      private function checkDomainResource(param1:String) : Boolean
      {
         var _loc2_:String = MapUtisl.getPackageName(param1) + "S_0_0";
         if(DomainResourceLoad.loaderContext)
         {
            return DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc2_);
         }
         return false;
      }
      
      private function createResourceLoadInfo(param1:String, param2:Array, param3:Array, param4:String) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.packageName = MapUtisl.getPackageName(param1);
         _loc5_.stand = param2;
         _loc5_.walk = param3;
         _loc5_.position = param4;
         _loc5_.url = param1;
         return _loc5_;
      }
      
      private function __loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!_cache)
         {
            return;
         }
         if(checkDomainResource(param1.url))
         {
            loadAvatarResourceResult(param1.url,param1.args as ResourceLoaderInfo);
         }
      }
      
      private function loadAvatarResourceResult(param1:String, param2:ResourceLoaderInfo) : void
      {
         var _loc4_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         var _loc3_:int = int(_loc4_ ? _loc4_.sizeType : 1);
         _sizeType = _loc3_;
         _resourceInfo = param2;
         _standLayouPara = new AvatarLayouData(_loc4_.standsPara);
         _walkLayouPara = new AvatarLayouData(_loc4_.walksPara);
         _loadCompleted = true;
         clearCache();
         draw();
         dispatchEvent(new Event("complete"));
      }
      
      private function drawStand() : void
      {
         var _loc7_:* = undefined;
         var _loc1_:Object = null;
         var _loc8_:Object = null;
         var _loc2_:Point = null;
         var _loc4_:Matrix = null;
         if(!_loadCompleted)
         {
            return;
         }
         if(!_standLayouPara)
         {
            return;
         }
         var _loc3_:int = getFrameY(frameY);
         var _loc6_:String = _resourceInfo.packageName + "S_" + frameX + "_" + _loc3_;
         var _loc5_:BitmapData = _cache[_loc6_];
         if(!_loc5_)
         {
            if(DomainResourceLoad.loaderContext && DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc6_))
            {
               _loc7_ = DomainResourceLoad.loaderContext.applicationDomain.getDefinition(_loc6_);
               _loc5_ = new _loc7_() as BitmapData;
               _cache[_loc6_] = _loc5_;
            }
         }
         if(_loc5_)
         {
            _loc1_ = Avatar.sizeMaxOld[_sizeType];
            _loc8_ = _standLayouPara.getCellByKey(frameX,_loc3_);
            _loc2_ = new Point();
            _loc2_.x = _loc1_.x + int(_loc8_["x"]);
            _loc2_.y = _loc1_.y + int(_loc8_["y"]);
            _loc4_ = new Matrix();
            _loc4_.tx = _loc2_.x;
            _loc4_.ty = _loc2_.y;
            graphics.clear();
            graphics.beginBitmapFill(_loc5_,_loc4_,false,false);
            graphics.drawRect(_loc2_.x,_loc2_.y,_loc5_.width,_loc5_.height);
            graphics.endFill();
         }
      }
      
      private function drawWalk() : void
      {
         var _loc6_:* = undefined;
         var _loc1_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Point = null;
         var _loc3_:Matrix = null;
         if(!_loadCompleted)
         {
            return;
         }
         if(!_walkLayouPara)
         {
            return;
         }
         var _loc5_:String = _resourceInfo.packageName + "W_" + frameX + "_" + frameY;
         var _loc4_:BitmapData = _cache[_loc5_];
         if(!_loc4_)
         {
            if(DomainResourceLoad.loaderContext && DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc5_))
            {
               _loc6_ = DomainResourceLoad.loaderContext.applicationDomain.getDefinition(_loc5_);
               _loc4_ = new _loc6_() as BitmapData;
               _cache[_loc5_] = _loc4_;
            }
         }
         if(_loc4_)
         {
            _loc1_ = Avatar.sizeMaxOld[_sizeType];
            _loc7_ = _walkLayouPara.getCellByKey(frameX,frameY);
            _loc2_ = new Point();
            _loc2_.x = _loc1_.x + int(_loc7_["x"]);
            _loc2_.y = _loc1_.y + int(_loc7_["y"]);
            _loc3_ = new Matrix();
            _loc3_.tx = _loc2_.x;
            _loc3_.ty = _loc2_.y;
            graphics.clear();
            graphics.beginBitmapFill(_loc4_,_loc3_,false,false);
            graphics.drawRect(_loc2_.x,_loc2_.y,_loc4_.width,_loc4_.height);
            graphics.endFill();
         }
      }
      
      private function isCacheNumber(param1:Number) : Boolean
      {
         return param1 != -9999;
      }
      
      public function get frameX() : int
      {
         return _frameX;
      }
      
      public function set frameX(param1:int) : void
      {
         _frameX = param1;
         if(_frameX >= standTotalFrameX)
         {
            _frameX = 0;
         }
      }
      
      public function get frameY() : int
      {
         return _frameY;
      }
      
      public function set frameY(param1:int) : void
      {
         _frameY = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         resetPos();
      }
      
      protected function draw() : void
      {
         switch(_state - 3)
         {
            case 0:
               drawStand();
               break;
            case 1:
               drawWalk();
         }
      }
      
      private function getFrameY(param1:int) : int
      {
         var _loc2_:int = 2;
         if(param1 == 1 || param1 == 0)
         {
            _loc2_ = 0;
         }
         else if(param1 == 3 || param1 == 2)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function clearAllFrames() : void
      {
         _loadCompleted = false;
         _standLayouPara = null;
         _walkLayouPara = null;
         clearCache();
         graphics.clear();
         _url = null;
         _urlKey = null;
      }
      
      private function clearCache() : void
      {
         for each(var _loc1_:BitmapData in _cache)
         {
            _loc1_.dispose();
         }
         _cache = new Dictionary();
         resetPos();
      }
      
      private function resetPos() : void
      {
         _dx = -9999;
      }
      
      public function enterFrame() : void
      {
         if(_curStepFrame >= _stepFrame)
         {
            _curStepFrame = 0;
            draw();
            frameX = frameX + 1;
         }
         else
         {
            _curStepFrame = _curStepFrame + 1;
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loaderCompleteHandler);
         stop();
         clearAllFrames();
         _cache = null;
         ObjectUtils.disposeAllChildren(this);
         this.graphics.clear();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


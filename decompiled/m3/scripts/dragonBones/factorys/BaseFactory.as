package dragonBones.factorys
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.display.NativeDisplayBridge;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DecompressedData;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.SkeletonData;
   import dragonBones.objects.XMLDataParser;
   import dragonBones.textures.ITextureAtlas;
   import dragonBones.textures.NativeTextureAtlas;
   import dragonBones.textures.SubTextureData;
   import dragonBones.utils.XMLParserEventUtil;
   import dragonBones.utils.dragonBones_internal;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   use namespace dragonBones_internal;
   
   [Event(name="complete",type="flash.events.Event")]
   public class BaseFactory extends EventDispatcher
   {
      
      private static var _loaderContext:LoaderContext = new LoaderContext(false);
      
      protected static var _helpMatirx:Matrix = new Matrix();
      
      protected var _skeletonDataDic:Object;
      
      protected var _textureAtlasDic:Object;
      
      protected var _textureAtlasLoadingDic:Object;
      
      protected var _currentSkeletonData:SkeletonData;
      
      protected var _currentTextureAtlas:Object;
      
      protected var _currentSkeletonName:String;
      
      protected var _currentTextureAtlasName:String;
      
      public function BaseFactory()
      {
         super();
         this._skeletonDataDic = {};
         this._textureAtlasDic = {};
         this._textureAtlasLoadingDic = {};
         _loaderContext.allowCodeImport = true;
      }
      
      public function stepStage(param1:Stage) : void
      {
         if(param1 != null)
         {
            XMLDataParser.step(param1);
         }
      }
      
      public function parseData(param1:ByteArray, param2:String = null) : SkeletonData
      {
         var _loc3_:DecompressedData = XMLDataParser.decompressData(param1);
         var _loc4_:SkeletonData = XMLDataParser.parseSkeletonData(_loc3_.skeletonXML);
         param2 ||= _loc4_.name;
         this.addSkeletonData(_loc4_,param2);
         var _loc5_:Loader = new Loader();
         _loc5_.name = param2;
         this._textureAtlasLoadingDic[param2] = _loc3_.textureAtlasXML;
         _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         _loc5_.loadBytes(_loc3_.textureBytes,_loaderContext);
         _loc3_.dispose();
         return _loc4_;
      }
      
      public function getSkeletonData(param1:String) : SkeletonData
      {
         return this._skeletonDataDic[param1];
      }
      
      public function addSkeletonData(param1:SkeletonData, param2:String = null) : void
      {
         param2 ||= param1.name;
         if(!param2)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(param1)
         {
            this._skeletonDataDic[param2] = param1;
         }
      }
      
      public function removeSkeletonData(param1:String) : void
      {
         delete this._skeletonDataDic[param1];
      }
      
      public function getTextureAtlas(param1:String) : Object
      {
         return this._textureAtlasDic[param1];
      }
      
      public function addTextureAtlas(param1:Object, param2:String = null) : void
      {
         if(!param2 && param1 is ITextureAtlas)
         {
            param2 = param1.name;
         }
         if(!param2)
         {
            throw new ArgumentError("Unnamed data!");
         }
         if(param1)
         {
            this._textureAtlasDic[param2] = param1;
         }
      }
      
      public function removeTextureAtlas(param1:String) : void
      {
         delete this._textureAtlasDic[param1];
      }
      
      public function dispose(param1:Boolean = true) : void
      {
         var _loc2_:SkeletonData = null;
         var _loc3_:Object = null;
         if(param1)
         {
            for each(_loc2_ in this._skeletonDataDic)
            {
               _loc2_.dispose();
            }
            for each(_loc3_ in this._textureAtlasDic)
            {
               _loc3_.dispose();
            }
         }
         this._skeletonDataDic = {};
         this._textureAtlasDic = {};
         this._textureAtlasLoadingDic = {};
         this._currentSkeletonData = null;
         this._currentTextureAtlas = null;
         this._currentSkeletonName = null;
         this._currentTextureAtlasName = null;
      }
      
      public function buildArmature(param1:String, param2:String = null, param3:String = null, param4:String = null) : Armature
      {
         var _loc5_:SkeletonData = null;
         var _loc6_:ArmatureData = null;
         var _loc10_:String = null;
         var _loc11_:BoneData = null;
         var _loc12_:Bone = null;
         param2 ||= param1;
         if(param3)
         {
            _loc5_ = this._skeletonDataDic[param3];
            if(_loc5_)
            {
               _loc6_ = _loc5_.getArmatureData(param1);
            }
         }
         else
         {
            for(param3 in this._skeletonDataDic)
            {
               _loc5_ = this._skeletonDataDic[param3];
               _loc6_ = _loc5_.getArmatureData(param1);
               if(_loc6_)
               {
                  break;
               }
            }
         }
         if(!_loc6_)
         {
            return null;
         }
         this._currentSkeletonName = param3;
         this._currentSkeletonData = _loc5_;
         this._currentTextureAtlasName = param4 || param3;
         this._currentTextureAtlas = this._textureAtlasDic[this._currentTextureAtlasName];
         var _loc7_:AnimationData = this._currentSkeletonData.getAnimationData(param2);
         if(!_loc7_)
         {
            for(param3 in this._skeletonDataDic)
            {
               _loc5_ = this._skeletonDataDic[param3];
               _loc7_ = _loc5_.getAnimationData(param2);
               if(_loc7_)
               {
                  break;
               }
            }
         }
         var _loc8_:Armature = this.generateArmature();
         _loc8_.name = param1;
         _loc8_.frameRate = _loc6_.frameRate;
         _loc8_.scale = _loc6_.scale;
         _loc8_.animation.animationData = _loc7_;
         var _loc9_:Vector.<String> = _loc6_.boneNames;
         for each(_loc10_ in _loc9_)
         {
            _loc11_ = _loc6_.getBoneData(_loc10_);
            if(_loc11_)
            {
               _loc12_ = this.buildBone(_loc11_);
               _loc12_.name = _loc10_;
               _loc8_.addBone(_loc12_,_loc11_.parent);
            }
         }
         _loc8_._bonesIndexChanged = true;
         _loc8_.update();
         return _loc8_;
      }
      
      public function getTextureDisplay(param1:String, param2:String = null, param3:Number = NaN, param4:Number = NaN) : Object
      {
         var _loc5_:Object = null;
         var _loc6_:SkeletonData = null;
         var _loc7_:DisplayData = null;
         if(param2)
         {
            _loc5_ = this._textureAtlasDic[param2];
         }
         else
         {
            for(param2 in this._textureAtlasDic)
            {
               _loc5_ = this._textureAtlasDic[param2];
               if(_loc5_.getRegion(param1))
               {
                  break;
               }
               _loc5_ = null;
            }
         }
         if(_loc5_)
         {
            if(isNaN(param3) || isNaN(param4))
            {
               _loc6_ = this._skeletonDataDic[param2];
               if(_loc6_)
               {
                  _loc7_ = _loc6_.getDisplayData(param1);
                  if(_loc7_)
                  {
                     param3 ||= _loc7_.pivotX;
                     param4 ||= _loc7_.pivotY;
                  }
               }
            }
            return this.generateTextureDisplay(_loc5_,param1,param3,param4);
         }
         return null;
      }
      
      protected function buildBone(param1:BoneData) : Bone
      {
         var _loc3_:DisplayData = null;
         var _loc5_:String = null;
         var _loc6_:Armature = null;
         var _loc2_:Bone = this.generateBone();
         _loc2_.origin.copy(param1.node);
         var _loc4_:* = int(param1._displayNames.length - 1);
         while(_loc4_ >= 0)
         {
            _loc5_ = param1._displayNames[_loc4_];
            _loc3_ = this._currentSkeletonData.getDisplayData(_loc5_);
            _loc2_.changeDisplay(_loc4_);
            if(_loc3_.isArmature)
            {
               _loc6_ = this.buildArmature(_loc5_,null,this._currentSkeletonName,this._currentTextureAtlasName);
               if(_loc6_)
               {
                  _loc6_.animation.play();
                  _loc2_.display = _loc6_;
               }
            }
            else
            {
               _loc2_.display = this.generateTextureDisplay(this._currentTextureAtlas,_loc5_,_loc3_.pivotX,_loc3_.pivotY);
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      protected function loaderCompleteHandler(param1:Event) : void
      {
         var _loc6_:Object = null;
         param1.target.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Object = param1.target.content;
         _loc2_.unloadAndStop();
         var _loc4_:String = _loc2_.name;
         var _loc5_:XML = this._textureAtlasLoadingDic[_loc4_];
         delete this._textureAtlasLoadingDic[_loc4_];
         if(Boolean(_loc4_) && Boolean(_loc5_))
         {
            if(_loc3_ is Bitmap)
            {
               _loc3_ = (_loc3_ as Bitmap).bitmapData;
            }
            else if(_loc3_ is Sprite)
            {
               _loc3_ = (_loc3_ as Sprite).getChildAt(0) as MovieClip;
            }
            _loc6_ = this.generateTextureAtlas(_loc3_,_loc5_);
            this.addTextureAtlas(_loc6_,_loc4_);
            _loc4_ = null;
            var _loc7_:int = 0;
            var _loc8_:* = this._textureAtlasLoadingDic;
            for(_loc4_ in _loc8_)
            {
            }
            if(!_loc4_ && hasEventListener(Event.COMPLETE))
            {
               if(XMLParserEventUtil.instance.isDispatcher)
               {
                  dispatchEvent(new Event(Event.COMPLETE));
               }
               else
               {
                  XMLParserEventUtil.instance.addEventListener(Event.COMPLETE,this.splitCompleteHandle);
               }
            }
         }
      }
      
      private function splitCompleteHandle(param1:Event) : void
      {
         XMLParserEventUtil.instance.removeEventListener(Event.COMPLETE,this.splitCompleteHandle);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function generateTextureAtlas(param1:Object, param2:XML) : Object
      {
         return new NativeTextureAtlas(param1,param2);
      }
      
      protected function generateArmature() : Armature
      {
         var _loc1_:Sprite = new Sprite();
         return new Armature(_loc1_);
      }
      
      protected function generateBone() : Bone
      {
         return new Bone(new NativeDisplayBridge());
      }
      
      protected function generateTextureDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         var movieClip:MovieClip = null;
         var displaySWF:Object = null;
         var subTextureData:SubTextureData = null;
         var displayShape:Shape = null;
         var textureAtlas:Object = param1;
         var fullName:String = param2;
         var pivotX:Number = param3;
         var pivotY:Number = param4;
         var nativeTextureAtlas:NativeTextureAtlas = textureAtlas as NativeTextureAtlas;
         if(nativeTextureAtlas)
         {
            movieClip = nativeTextureAtlas.movieClip;
            if(Boolean(movieClip) && movieClip.totalFrames >= 3)
            {
               movieClip.gotoAndStop(movieClip.totalFrames);
               movieClip.gotoAndStop(fullName);
               if(movieClip.numChildren > 0)
               {
                  try
                  {
                     displaySWF = movieClip.getChildAt(0);
                     displaySWF.x = 0;
                     displaySWF.y = 0;
                     return displaySWF;
                  }
                  catch(e:Error)
                  {
                     throw "Can not get the movie clip, please make sure the version of the resource compatible with app version!";
                  }
               }
            }
            else if(nativeTextureAtlas.bitmapData)
            {
               subTextureData = nativeTextureAtlas.getRegion(fullName) as SubTextureData;
               if(subTextureData)
               {
                  displayShape = new Shape();
                  pivotX ||= subTextureData.pivotX;
                  pivotY ||= subTextureData.pivotY;
                  _helpMatirx.a = 1;
                  _helpMatirx.b = 0;
                  _helpMatirx.c = 0;
                  _helpMatirx.d = 1;
                  _helpMatirx.scale(nativeTextureAtlas.scale,nativeTextureAtlas.scale);
                  _helpMatirx.tx = -subTextureData.x - pivotX;
                  _helpMatirx.ty = -subTextureData.y - pivotY;
                  displayShape.graphics.beginBitmapFill(nativeTextureAtlas.bitmapData,_helpMatirx,false,true);
                  displayShape.graphics.drawRect(-pivotX,-pivotY,subTextureData.width,subTextureData.height);
                  return displayShape;
               }
            }
         }
         return null;
      }
      
      public function get currentSkeletonData() : SkeletonData
      {
         return this._currentSkeletonData;
      }
   }
}


package com.speedEngine.components.manager
{
   import com.speedEngine.components.bone.BoneMovie;
   import com.speedEngine.components.bone.BoneMovieFactory;
   import com.speedEngine.components.model.FileAdapter;
   import com.speedEngine.components.model.FormatData;
   import com.speedEngine.components.model.FormatModel;
   import com.speedEngine.components.model.MovieData2D;
   import com.speedEngine.components.ui2D.SimpleMovie;
   import com.speedEngine.components.ui2D.TinyUI;
   import com.speedEngine.game.Director;
   import com.speedEngine.res.ResourcesManager;
   import com.speedEngine.res.loader.DataLoader;
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.display.DisplayObject;
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.textures.AtfData;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class UIFactory extends EventDispatcher
   {
      
      public static const CREATE_UI_COMPLETE:String = "create_ui_complete";
      
      private static var _instance:UIFactory;
      
      private var _curParse:String;
      
      private var _uiList:Array;
      
      private var _maxCreateCount:int = 1;
      
      private var _curIndex:int = 0;
      
      private var _isCreateComplete:Boolean = true;
      
      private var _curUIList:Array;
      
      private var _curObj:Object;
      
      private var _beginTime:int = 0;
      
      private var _spaceTime:int = 42;
      
      private var _moviePath:String;
      
      private var _styleConfig:StyleConfig;
      
      private var _list:Array = [];
      
      public function UIFactory()
      {
         super();
         _uiList = [];
         _curUIList = [];
         _styleConfig = new StyleConfig();
         new DefineComponent();
         RepaintManger.instance.setp(Director.instance.stage2d);
      }
      
      public static function get instance() : UIFactory
      {
         if(_instance == null)
         {
            _instance = new UIFactory();
         }
         return _instance;
      }
      
      public static function getChildByPath(param1:Object, param2:String) : Object
      {
         var _loc5_:int = 0;
         var _loc4_:Array = param2.match(/[a-z,A-Z,0-9,_]+/g);
         var _loc3_:Object = param1;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc3_ == null)
            {
               return null;
            }
            if(_loc3_.hasOwnProperty("getChildByName"))
            {
               _loc3_ = _loc3_.getChildByName(_loc4_[_loc5_]) as Object;
            }
            else
            {
               Director.instance.throwError("传入的目标对{invalid_utf8=232}{invalid_utf8=177}?" + param1 + "没有getChildByName方法");
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function analysisData(param1:ByteArray, param2:ByteArray, param3:ByteArray) : void
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param1);
         _loc4_.uncompress();
         var _loc6_:int = _loc4_.readInt();
         param2.writeBytes(_loc4_,_loc4_.position,_loc6_);
         _loc4_.position += _loc6_;
         var _loc5_:int = _loc4_.readInt();
         param3.writeBytes(_loc4_,_loc4_.position,_loc5_);
         _loc4_.clear();
      }
      
      public function addUIFile(param1:String, param2:*, param3:Object) : void
      {
         if(_list.length == 0)
         {
            Director.instance.addEnterFrameEvent(onEnter);
         }
         var _loc4_:Object = {
            "name":param1,
            "value":param2,
            "uiDic":param3
         };
         _list.push(_loc4_);
      }
      
      private function onEnter() : void
      {
         var _loc2_:Object = null;
         var _loc1_:FormatData = null;
         if(_list.length <= 0)
         {
            return;
         }
         while(_list.length > 0)
         {
            _loc2_ = _list.shift();
            _loc1_ = FileAdapter.getObjectData(_loc2_["value"]);
            _loc1_.path = _loc2_["name"];
            _loc2_["uiDic"].data = _loc1_;
         }
         Director.instance.addEnterFrameEvent(onEnter);
         _instance.dispatchEvent(new Event("create_ui_complete"));
      }
      
      private function buildFeathersUI(param1:String, param2:XMLList, param3:Array, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc10_:XML = null;
         var _loc7_:XMLList = null;
         var _loc8_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc12_:Array = null;
         var _loc14_:XMLList = null;
         var _loc18_:Array = null;
         var _loc17_:String = null;
         var _loc15_:String = null;
         var _loc16_:Object = null;
         var _loc11_:int = 0;
         if(param2.length() == 0)
         {
            _isCreateComplete = true;
         }
         var _loc9_:int = param5 ? _curIndex : 0;
         while(_loc9_ < param2.length())
         {
            _loc10_ = param2[_loc9_];
            _loc7_ = _loc10_.attributes();
            _loc8_ = _loc10_.@classname.toString().indexOf("ui3D") == 0;
            _loc6_ = false;
            if(judgeFore(_loc10_))
            {
               _loc6_ = true;
            }
            _loc12_ = [];
            param3.push(_loc12_);
            _loc14_ = _loc10_.component;
            _loc18_ = [];
            _loc12_.push(_loc18_);
            if(_loc14_.length() > 0)
            {
               buildFeathersUI(param1,_loc14_,_loc18_);
            }
            for each(var _loc13_:XML in _loc7_)
            {
               _loc17_ = _loc13_.name();
               _loc15_ = _loc13_.toString();
               _loc16_ = {};
               _loc16_.name = _loc17_;
               _loc16_.value = _loc15_;
               _loc16_.isForePic = _loc6_;
               _loc12_.push(_loc16_);
            }
            if(param5)
            {
               _curIndex = _curIndex + 1;
               if(_curIndex >= param2.length())
               {
                  _curIndex = 0;
                  _isCreateComplete = true;
               }
               else
               {
                  _loc11_ = getTimer();
                  if(_loc11_ - _beginTime > _spaceTime)
                  {
                     _isCreateComplete = false;
                     return;
                  }
               }
            }
            _loc9_++;
         }
      }
      
      private function judgeFore(param1:XML) : Boolean
      {
         var _loc2_:XML = param1.parent();
         if(_loc2_ != null)
         {
            if(_loc2_.@objectname == "forePic")
            {
               return true;
            }
            return judgeFore(_loc2_);
         }
         return false;
      }
      
      private function create3DSimpleMovieClip(param1:String) : DisplayObjectContainer
      {
         return null;
      }
      
      private function create2DSimpleMovieClip(param1:String) : TinyUI
      {
         var _loc2_:MovieData2D = new MovieData2D();
         _loc2_.atlasType = "tex_atlas";
         _loc2_.atlas = getBitmapData(param1);
         _loc2_.meta = getMC(param1);
         _loc2_.build();
         _loc2_.url = param1;
         return new SimpleMovie(_loc2_);
      }
      
      private function getMC(param1:String) : Object
      {
         var _loc2_:DataLoader = null;
         var _loc3_:String = param1;
         var _loc4_:Object = ResourcesManager.instance.getObjByKey(_loc3_);
         if(_loc4_ == null)
         {
            _loc2_ = ResourcesManager.instance.getGlobalResource(_loc3_) as DataLoader;
            if(_loc2_ == null)
            {
               Director.instance.throwError("动画不存在{invalid_utf8=227}?{invalid_utf8=130}[[At{invalid_utf8=239}{invalid_utf8=188}?" + _curParse + "]]");
               return null;
            }
            return JSON.parse(_loc2_.data);
         }
         return _loc4_;
      }
      
      private function getXML(param1:String) : XML
      {
         var _loc2_:DataLoader = ResourcesManager.instance.getGlobalResource(param1) as DataLoader;
         if(_loc2_ == null)
         {
            Director.instance.throwError("XML:" + param1 + "不存在{invalid_utf8=227}??" + "[[At{invalid_utf8=239}{invalid_utf8=188}?" + _curParse + "]]");
         }
         return new XML(_loc2_.data);
      }
      
      private function getResource(param1:String, param2:Boolean = false) : Object
      {
         var _loc4_:Object = null;
         var _loc3_:* = null;
         if(param2)
         {
            _loc4_ = getAtfData(param1);
         }
         else
         {
            _loc4_ = getBitmapData(param1);
         }
         return _loc4_;
      }
      
      private function getAtfData(param1:String) : AtfData
      {
         var _loc2_:AtfData = ResourcesManager.instance.getAtfData(param1);
         if(_loc2_ == null)
         {
            throw new Error("图片资源错误，必须为DataLoader，TextureLoader,ZmapLoader url=" + param1 + "不存在{invalid_utf8=227}??" + "[[At{invalid_utf8=239}{invalid_utf8=188}?" + _curParse + "]]");
         }
         return _loc2_;
      }
      
      private function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = ResourcesManager.instance.getMovieClip(param1);
         if(_loc2_ == null)
         {
            Director.instance.throwError("MovieClip:" + param1 + "不存在{invalid_utf8=227}??" + "[[At{invalid_utf8=239}{invalid_utf8=188}?" + _curParse + "]]");
         }
         return _loc2_;
      }
      
      private function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = ResourcesManager.instance.getBitmapData(param1);
         if(_loc2_ == null)
         {
            Director.instance.throwError("BitmapData:" + param1 + "不存在{invalid_utf8=227}??" + "[[At{invalid_utf8=239}{invalid_utf8=188}?" + _curParse + "]]");
         }
         return _loc2_;
      }
      
      private function findAttr(param1:Array, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         _loc4_ = 3;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            if(_loc3_.name == param2)
            {
               return _loc3_.value;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function create3DUIFromFormatModel(param1:DisplayObjectContainer, param2:FormatModel, param3:String) : DisplayObjectContainer
      {
         var _loc12_:DisplayObject = null;
         var _loc4_:* = null;
         var _loc13_:* = null;
         var _loc11_:* = undefined;
         var _loc8_:String = null;
         var _loc7_:String = param2.className;
         var _loc14_:Array = param2.children;
         var _loc10_:String = param2.objectName;
         var _loc9_:int = 0;
         var _loc5_:int = _loc14_ ? _loc14_.length : 0;
         if(_loc7_ == null || _loc7_ == "")
         {
            param1 = new DisplayObjectContainer();
            _loc12_ = param1;
         }
         else if(_loc7_ == "movie")
         {
            _loc12_ = create3DSimpleMovieClip(param2["path"]);
         }
         else if(_loc7_ == "xml")
         {
            _loc8_ = _curParse;
            _loc12_ = create3DUI(param2["path"]);
            _curParse = _loc8_;
         }
         else if(_loc7_ == "bone")
         {
            _loc12_ = createBoneMovie(param2["bonePath"],param2["armatureName"]);
         }
         else
         {
            _loc12_ = new (Class(getDefinitionByName(_loc7_)))();
         }
         if(param1 == null)
         {
            param1 = new DisplayObjectContainer();
         }
         _loc10_ ? (_loc12_.name = _loc10_) : null;
         for(var _loc6_:String in param2)
         {
            if(!(_loc6_ == "path" || _loc6_ == "styleName"))
            {
               _loc11_ = param2[_loc6_];
               if(_loc12_.hasOwnProperty(_loc6_))
               {
                  if(_loc11_ is String && _loc11_.charAt(0) == "@")
                  {
                     _loc12_[_loc6_] = getResource(_loc11_.slice(1),true);
                  }
                  else
                  {
                     _loc12_[_loc6_] = _loc11_ == "false" ? false : _loc11_;
                  }
               }
               else
               {
                  Director.instance.throwError(_loc12_ + "属{invalid_utf8=230}??" + _loc6_ + "不存在{invalid_utf8=227}??" + "[[At{invalid_utf8=239}{invalid_utf8=188}?" + param3 + "]]");
               }
            }
         }
         while(_loc9_ < _loc5_)
         {
            create3DUIFromFormatModel(_loc12_ as DisplayObjectContainer,_loc14_[_loc9_],param3);
            _loc9_++;
         }
         param1.addChild(_loc12_);
         return param1;
      }
      
      private function createBoneMovie(param1:String, param2:String) : BoneMovie
      {
         var bonePath:String = param1;
         var aramtureName:String = param2;
         var boneMovie:BoneMovie = new BoneMovie();
         BoneMovieFactory.instance.createBoneMovieByPath(bonePath,aramtureName,function(param1:Object = null):void
         {
            var _loc2_:Animation = BoneMovieFactory.instance.getAnimationByName(aramtureName);
            boneMovie.setAnimation(_loc2_);
         },0,false);
         return boneMovie;
      }
      
      private function create2DUIFormFormatModel(param1:TinyUI, param2:FormatModel, param3:String, param4:TinyUI) : TinyUI
      {
         var _loc12_:TinyUI = null;
         var _loc13_:* = null;
         var _loc11_:* = undefined;
         var _loc8_:String = null;
         var _loc7_:String = param2.className;
         var _loc14_:Array = param2.children;
         var _loc10_:String = param2.objectName;
         var _loc9_:int = 0;
         var _loc5_:int = _loc14_ ? _loc14_.length : 0;
         if(_loc7_ == null || _loc7_ == "")
         {
            param1 = new TinyUI();
            _loc12_ = param1;
         }
         else if(_loc7_ == "movie")
         {
            _loc12_ = create2DSimpleMovieClip(param2["path"]);
         }
         else if(_loc7_ == "xml")
         {
            _loc8_ = _curParse;
            _loc12_ = createTinyUI(param2["path"]);
            _curParse = _loc8_;
         }
         else
         {
            _loc12_ = new (Class(getDefinitionByName(_loc7_)))();
         }
         if(param1 == null)
         {
            param1 = new TinyUI();
         }
         _loc12_.xmlPath = param3;
         _loc10_ ? (_loc12_.name = _loc10_) : null;
         for(var _loc6_:String in param2)
         {
            if(!(_loc6_ == "path" || _loc6_ == "styleName"))
            {
               _loc11_ = param2[_loc6_];
               if(_loc12_.hasOwnProperty(_loc6_))
               {
                  if(_loc11_ is String && _loc11_.charAt(0) == "@")
                  {
                     if(_loc6_ == "movie")
                     {
                        _loc12_[_loc6_] = getMovieClip(_loc11_.slice(1));
                     }
                     else
                     {
                        _loc12_[_loc6_] = getResource(_loc11_.slice(1),false);
                     }
                  }
                  else if(_loc11_ is String && _loc11_.charAt(0) == "~")
                  {
                     _loc12_[_loc6_] = param4.getChildByPath((_loc11_ as String).substring(1) as String);
                  }
                  else
                  {
                     _loc12_[_loc6_] = _loc11_ == "false" ? false : _loc11_;
                  }
               }
            }
         }
         if(_loc12_ is TinyUI)
         {
            _loc12_.__onAfterProp();
         }
         _loc12_ != param1 ? param1.addChild(_loc12_) : null;
         while(_loc9_ < _loc5_)
         {
            create2DUIFormFormatModel(_loc12_,_loc14_[_loc9_],param3,param4);
            _loc9_++;
         }
         return param1;
      }
      
      private function changeStyleByArray(param1:Object, param2:Array) : void
      {
         var _loc3_:String = getStyleName(param2);
         if(_loc3_)
         {
            getStyle(param1,_loc3_);
         }
      }
      
      private function getStyleName(param1:Array) : String
      {
         var _loc2_:String = null;
         for each(var _loc3_:Object in param1)
         {
            if(_loc3_.name == "styleName")
            {
               _loc2_ = _loc3_.value;
               break;
            }
         }
         return _loc2_;
      }
      
      public function createUI(param1:String, param2:Boolean = false) : Object
      {
         var _loc3_:Object = null;
         _curParse = param1;
         if(param2)
         {
            _loc3_ = create3DUI(param1);
         }
         else
         {
            _loc3_ = createTinyUI(param1);
         }
         return _loc3_;
      }
      
      private function create3DUI(param1:String) : DisplayObjectContainer
      {
         var _loc2_:* = null;
         _curParse = param1;
         var _loc3_:Object = ResourcesManager.instance.getObjByKey(param1);
         if(_loc3_)
         {
            return create3DUIFromFormatModel(_loc2_,(_loc3_.data as FormatData).data,param1);
         }
         Director.instance.throwError("创建FeathersUI资源失败 [" + param1 + "]");
         return null;
      }
      
      private function createTinyUI(param1:String) : TinyUI
      {
         var _loc2_:* = null;
         var _loc3_:TinyUI = null;
         var _loc4_:Object = ResourcesManager.instance.getObjByKey(param1);
         _curParse = param1;
         if(_loc4_)
         {
            _loc3_ = new TinyUI();
            return create2DUIFormFormatModel(_loc2_,(_loc4_.data as FormatData).data,param1,null);
         }
         Director.instance.throwError("创建TinyUI资源失败 [" + param1 + "]");
         return null;
      }
      
      public function getStyle(param1:Object, param2:String) : void
      {
         var _loc3_:XML = null;
         var _loc7_:XMLList = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(param2 == null || param2 == "")
         {
            return;
         }
         var _loc9_:Array = param2.split(",");
         for each(var _loc8_:String in _loc9_)
         {
            _loc3_ = _styleConfig.getStyleByName(_loc8_);
            _loc7_ = _loc3_.attributes();
            for each(var _loc5_:XML in _loc7_)
            {
               _loc4_ = _loc5_.name().toString();
               _loc6_ = _loc5_.toString();
               if(param1.hasOwnProperty(_loc4_))
               {
                  param1[_loc4_] = ResourcesManager.instance.getBitmapData(_loc6_);
               }
               else
               {
                  Director.instance.throwError(param1 + "对象不存{invalid_utf8=229}{invalid_utf8=156}?" + _loc4_ + "属{invalid_utf8=230}??");
               }
            }
         }
      }
      
      public function analyzingReference(param1:Array, param2:XMLList, param3:int) : void
      {
         var _loc4_:XML = param2[param3];
         var _loc5_:XMLList = _loc4_.attributes();
      }
   }
}


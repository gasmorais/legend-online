package com.speedEngine.speedBones.model
{
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.manager.RenderManager;
   
   public class SkeletonData extends BaseClass
   {
      
      private var _name:String;
      
      private var _frameRate:uint;
      
      private var _version:String;
      
      private var _animationNames:Vector.<String> = null;
      
      private var _animationDatas:Vector.<AnimationData> = null;
      
      public var textureIndex:uint = 0;
      
      public function SkeletonData()
      {
         super();
         _animationDatas = new Vector.<AnimationData>();
         _animationNames = new Vector.<String>();
      }
      
      public function get animationNames() : Vector.<String>
      {
         return _animationNames;
      }
      
      public function addAnimationData(param1:AnimationData) : void
      {
         animationNames.push(param1.name);
         _animationDatas.push(param1);
      }
      
      public function getAnimationDataByName(param1:String) : AnimationData
      {
         if(param1 == null || param1 == "")
         {
            return _animationDatas[0];
         }
         for each(var _loc2_:AnimationData in _animationDatas)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get frameRate() : uint
      {
         return _frameRate;
      }
      
      public function set frameRate(param1:uint) : void
      {
         _frameRate = param1;
      }
      
      public function get version() : String
      {
         return _version;
      }
      
      public function set version(param1:String) : void
      {
         _version = param1;
      }
      
      public function get animationDatas() : Vector.<AnimationData>
      {
         return _animationDatas;
      }
      
      public function dispose(param1:Boolean = true) : void
      {
         for each(var _loc2_:AnimationData in _animationDatas)
         {
            _loc2_.dispose();
         }
         if(param1)
         {
            RenderManager.instance.disposeTexture(textureIndex);
         }
         if(_animationNames)
         {
            _animationNames.length = 0;
         }
         if(_animationDatas)
         {
            _animationDatas.length = 0;
         }
         _animationDatas = null;
         _animationNames = null;
      }
   }
}


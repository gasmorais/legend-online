package com.speedEngine.components.bone
{
   import flash.utils.ByteArray;
   
   public class LoaderData
   {
      
      private var _loaderPath:String = null;
      
      private var _isCompleteBuild:Boolean = true;
      
      private var _boneMovieType:int = 0;
      
      private var _callback:Function = null;
      
      private var _boneMovieName:String = null;
      
      private var _boneBytes:ByteArray;
      
      public function LoaderData(param1:String, param2:String, param3:Function, param4:uint, param5:Boolean)
      {
         super();
         _loaderPath = param1;
         _boneMovieName = param2;
         _callback = param3;
         _boneMovieType = param4;
         _isCompleteBuild = param5;
      }
      
      public function get boneMovieName() : String
      {
         return _boneMovieName;
      }
      
      public function set boneMovieName(param1:String) : void
      {
         _boneMovieName = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function get boneMovieType() : int
      {
         return _boneMovieType;
      }
      
      public function set boneMovieType(param1:int) : void
      {
         _boneMovieType = param1;
      }
      
      public function get loaderPath() : String
      {
         return _loaderPath;
      }
      
      public function set loaderPath(param1:String) : void
      {
         _loaderPath = param1;
      }
      
      public function get isCompleteBuild() : Boolean
      {
         return _isCompleteBuild;
      }
      
      public function set isCompleteBuild(param1:Boolean) : void
      {
         _isCompleteBuild = param1;
      }
      
      public function get boneBytes() : ByteArray
      {
         return _boneBytes;
      }
      
      public function set boneBytes(param1:ByteArray) : void
      {
         _boneBytes = param1;
      }
   }
}


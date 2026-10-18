package com.speedEngine.speedBones.textures
{
   import com.speedEngine.speedBones.BaseClass;
   import flash.utils.ByteArray;
   
   public class AtfData extends BaseClass
   {
      
      private var mFormat:String;
      
      private var mPath:String;
      
      private var mType:int;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mTextureWidth:int;
      
      private var mTextureHeight:int;
      
      private var mNumTextures:int;
      
      private var mData:ByteArray;
      
      public function AtfData(param1:ByteArray, param2:int = 3, param3:String = null)
      {
         super();
         var _loc4_:String = String.fromCharCode(param1[0],param1[1],param1[2]);
         if(_loc4_ != "ATF")
         {
            throw new ArgumentError("Invalid ATF data");
         }
         switch(param1[6])
         {
            case 0:
            case 1:
               mFormat = "bgra";
               break;
            case 2:
            case 3:
               mFormat = "compressed";
               break;
            case 4:
            case 5:
               mFormat = "compressedAlpha";
               break;
            default:
               throw new Error("Invalid ATF format");
         }
         mTextureWidth = mWidth = Math.pow(2,param1[7]);
         mTextureHeight = mHeight = Math.pow(2,param1[8]);
         mNumTextures = param1[9];
         mData = param1;
         mPath = param3;
         mType = param2;
      }
      
      public function get format() : String
      {
         return mFormat;
      }
      
      public function get width() : int
      {
         return mWidth;
      }
      
      public function get height() : int
      {
         return mHeight;
      }
      
      public function get textureWidth() : int
      {
         return mTextureWidth;
      }
      
      public function get textureHeight() : int
      {
         return mTextureHeight;
      }
      
      public function set width(param1:int) : void
      {
         mWidth = param1;
      }
      
      public function set height(param1:int) : void
      {
         mHeight = param1;
      }
      
      public function get numTextures() : int
      {
         return mNumTextures;
      }
      
      public function get data() : ByteArray
      {
         return mData;
      }
      
      public function dispose() : void
      {
         if(mData)
         {
            mData.clear();
         }
         mData = null;
      }
      
      public function get path() : String
      {
         return mPath;
      }
      
      public function get type() : int
      {
         return mType;
      }
   }
}


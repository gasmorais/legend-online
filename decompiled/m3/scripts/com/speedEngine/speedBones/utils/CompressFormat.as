package com.speedEngine.speedBones.utils
{
   public class CompressFormat
   {
      
      private static var OTHER_TYPE:uint = 0;
      
      public static var ZLIB:String = "zlib";
      
      private static var ZLIB_TYPE:uint = 1;
      
      public static var LZMA:String = "lzma";
      
      private static var LZMA_TYPE:uint = 2;
      
      public static const COMPRESS_FORMAT:String = "lzma";
      
      private static var uncompress:String = "zlib";
      
      public function CompressFormat()
      {
         super();
      }
      
      public static function setUnCompressFormat(param1:uint = 1) : void
      {
         uncompress = getCompress(param1);
      }
      
      public static function get unCompressFormat() : String
      {
         return uncompress;
      }
      
      public static function getCompressType() : uint
      {
         if("lzma" == ZLIB)
         {
            return ZLIB_TYPE;
         }
         if("lzma" == LZMA)
         {
            return LZMA_TYPE;
         }
         return OTHER_TYPE;
      }
      
      private static function getCompress(param1:uint) : String
      {
         if(param1 == ZLIB_TYPE)
         {
            return ZLIB;
         }
         if(param1 == LZMA_TYPE)
         {
            return LZMA;
         }
         throw new Error("文件压缩类型错误，请{invalid_utf8=230}{invalid_utf8=163}?查spp文件{invalid_utf8=229}{invalid_utf8=164}?");
      }
   }
}


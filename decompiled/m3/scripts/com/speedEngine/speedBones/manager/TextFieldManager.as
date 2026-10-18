package com.speedEngine.speedBones.manager
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextFieldManager
   {
      
      private static var _instance:TextFieldManager;
      
      public static var WORD_SIZE:int = 14;
      
      public static var IMAGE_SIZE:int = 2048;
      
      public static var COLOR:int = 16777215;
      
      public static var FONT:String = "宋体";
      
      public static var BOLD:Boolean = true;
      
      public var _textBitmap:BitmapData;
      
      private var _textDic:Object;
      
      private var _currentRow:int;
      
      private var _currentCol:int;
      
      private var _textureIndex:int;
      
      private var _leading:int = 2;
      
      public function TextFieldManager(param1:HelpClass)
      {
         super();
         if(param1 == null)
         {
            throw "single class";
         }
         _textDic = {};
         _textBitmap = new BitmapData(IMAGE_SIZE,IMAGE_SIZE,true,0);
         _textureIndex = RenderManager.instance.createBitmapData(_textBitmap);
      }
      
      public static function setDefaultTextFiledFormat(param1:String = "宋体", param2:uint = 16777215, param3:uint = 14, param4:Boolean = true, param5:uint = 2048) : void
      {
         FONT = param1;
         COLOR = param2;
         WORD_SIZE = param3;
         IMAGE_SIZE = param5;
         BOLD = param4;
      }
      
      public static function get instance() : TextFieldManager
      {
         if(_instance == null)
         {
            _instance = new TextFieldManager(new HelpClass());
         }
         return _instance;
      }
      
      public function updateTextureIndex(param1:int) : void
      {
         _textureIndex = param1;
      }
      
      public function getIndexArray(param1:String) : Array
      {
         var _loc4_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = param1.length;
         var _loc5_:int = -1;
         var _loc6_:Array = [];
         while(++_loc5_ < _loc3_)
         {
            _loc4_ = param1.charAt(_loc5_);
            if(_textDic[_loc4_] == null)
            {
               pushText(_loc4_);
               _loc2_ = true;
            }
            _loc6_.push(_textDic[_loc4_]);
         }
         if(_loc2_)
         {
            updataTextBitmap();
         }
         return _loc6_;
      }
      
      private function pushText(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:TextField = createTextField();
         var _loc5_:BitmapData = new BitmapData(WORD_SIZE + 2 * _leading,WORD_SIZE + 2 * _leading,true,0);
         _loc4_.text = param1;
         _loc5_.draw(_loc4_,null,null);
         _textDic[param1] = [_currentRow,_currentCol,_loc4_.getLineMetrics(0).width];
         _loc3_ = WORD_SIZE * _currentCol;
         _loc2_ = _currentRow * WORD_SIZE;
         _textBitmap.copyPixels(_loc5_,new Rectangle(_leading,_leading,WORD_SIZE,WORD_SIZE),new Point(_loc3_,_loc2_));
         if(_loc3_ + WORD_SIZE > IMAGE_SIZE)
         {
            _currentCol = 0;
            _currentRow = _currentRow + 1;
         }
         else
         {
            _currentCol = _currentCol + 1;
         }
         _loc5_.dispose();
      }
      
      private function createTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.defaultTextFormat = new TextFormat(FONT,WORD_SIZE,COLOR,BOLD);
         return _loc1_;
      }
      
      public function get textureIndex() : int
      {
         return _textureIndex;
      }
      
      private function updataTextBitmap() : void
      {
         RenderManager.instance.updateTexture(_textureIndex);
      }
      
      public function get leading() : int
      {
         return _leading;
      }
   }
}

class HelpClass
{
   
   public function HelpClass()
   {
      super();
   }
}

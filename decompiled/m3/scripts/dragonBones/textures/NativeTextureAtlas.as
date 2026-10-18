package dragonBones.textures
{
   import dragonBones.utils.ConstValues;
   import dragonBones.utils.dragonBones_internal;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   use namespace dragonBones_internal;
   
   public class NativeTextureAtlas implements ITextureAtlas
   {
      
      protected var _width:int;
      
      protected var _height:int;
      
      protected var _subTextureDataDic:Object;
      
      protected var _isDifferentXML:Boolean;
      
      protected var _name:String;
      
      protected var _movieClip:MovieClip;
      
      protected var _bitmapData:BitmapData;
      
      protected var _scale:Number;
      
      public function NativeTextureAtlas(param1:Object, param2:XML, param3:Number = 1, param4:Boolean = false)
      {
         super();
         this._scale = param3;
         this._isDifferentXML = param4;
         this._subTextureDataDic = {};
         if(param1 is BitmapData)
         {
            this._bitmapData = param1 as BitmapData;
         }
         else if(param1 is MovieClip)
         {
            this._movieClip = param1 as MovieClip;
            this._movieClip.stop();
         }
         this.parseData(param2);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get movieClip() : MovieClip
      {
         return this._movieClip;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function dispose() : void
      {
         this._movieClip = null;
         if(this._bitmapData)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = null;
         this._subTextureDataDic = {};
      }
      
      public function getRegion(param1:String) : Rectangle
      {
         return this._subTextureDataDic[param1];
      }
      
      protected function parseData(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:SubTextureData = null;
         this._name = param1.attribute(ConstValues.A_NAME);
         this._width = int(param1.attribute(ConstValues.A_WIDTH));
         this._height = int(param1.attribute(ConstValues.A_HEIGHT));
         var _loc2_:Number = this._isDifferentXML ? this._scale : 1;
         for each(_loc3_ in param1.elements(ConstValues.SUB_TEXTURE))
         {
            _loc4_ = _loc3_.attribute(ConstValues.A_NAME);
            _loc5_ = new SubTextureData();
            _loc5_.x = int(_loc3_.attribute(ConstValues.A_X)) / _loc2_;
            _loc5_.y = int(_loc3_.attribute(ConstValues.A_Y)) / _loc2_;
            _loc5_.width = int(_loc3_.attribute(ConstValues.A_WIDTH)) / _loc2_;
            _loc5_.height = int(_loc3_.attribute(ConstValues.A_HEIGHT)) / _loc2_;
            _loc5_.pivotX = int(_loc3_.attribute(ConstValues.A_PIVOT_X));
            _loc5_.pivotY = int(_loc3_.attribute(ConstValues.A_PIVOT_Y));
            this._subTextureDataDic[_loc4_] = _loc5_;
         }
      }
      
      dragonBones_internal function movieClipToBitmapData() : void
      {
         if(!this._bitmapData && Boolean(this._movieClip))
         {
            this._movieClip.gotoAndStop(1);
            this._bitmapData = new BitmapData(this._width,this._height,true,16711935);
            this._bitmapData.draw(this._movieClip);
            this._movieClip.gotoAndStop(this._movieClip.totalFrames);
         }
      }
   }
}


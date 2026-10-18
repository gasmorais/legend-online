package com.speedEngine.components.model
{
   import com.speedEngine.game.Director;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class MovieData2D
   {
      
      public static const BMP_ATLAS:String = "bmp_atlas";
      
      public static const TEX_ATLAS:String = "tex_atlas";
      
      public var meta:Object;
      
      public var atlas:Object;
      
      public var atlasType:String;
      
      public var url:String;
      
      private var _keyFrame:Array;
      
      private var _keyTextures:Vector.<BitmapData>;
      
      private var _intactFrame:Array;
      
      private var _intactTextures:Vector.<BitmapData>;
      
      public function MovieData2D()
      {
         super();
      }
      
      public function get intactFrame() : Array
      {
         return _intactFrame;
      }
      
      public function get intactTextures() : Vector.<BitmapData>
      {
         return _intactTextures;
      }
      
      public function build() : void
      {
         var name:String;
         var t:int;
         var region:Rectangle;
         var oriRect:Rectangle;
         var tex:BitmapData;
         var tt:int;
         var frame:BitmapData;
         var eframe:Object;
         var keyIndex:int;
         var index:int;
         var curFrame:int;
         var nxtFrame:int;
         if(meta == null || atlas == null)
         {
            throw new Error("build data fail!");
         }
         _keyFrame = [];
         for(name in meta.frames)
         {
            meta.frames[name].name = name;
            _keyFrame.push(meta.frames[name]);
         }
         _keyFrame.sort(function(param1:Object, param2:Object):int
         {
            return int(param1.frameNum) - int(param2.frameNum);
         });
         t = getTimer();
         if(atlasType == "bmp_atlas")
         {
            tex = BitmapData(atlas);
         }
         else if(atlasType == "tex_atlas")
         {
            tex = atlas as BitmapData;
         }
         tt = getTimer() - t;
         if(atlasType == "bmp_atlas")
         {
            Director.instance.trace(4,"bitmap 没有释放~~~~~~~~~");
            atlas.dispose();
            atlas = null;
         }
         _keyTextures = new Vector.<BitmapData>();
         for each(eframe in _keyFrame)
         {
            region = new Rectangle(eframe.frame.x,eframe.frame.y,eframe.frame.w,eframe.frame.h);
            frame = new BitmapData(region.width,region.height,true,4278190080);
            frame.copyPixels(tex,region,new Point());
            _keyTextures.push(frame);
         }
         keyIndex = 0;
         index = 0;
         _intactFrame = [];
         _intactTextures = new Vector.<BitmapData>();
         keyIndex = 0;
         while(keyIndex < _keyFrame.length)
         {
            curFrame = int(_keyFrame[keyIndex].frameNum);
            nxtFrame = int(keyIndex < _keyFrame.length - 1 ? _keyFrame[keyIndex + 1].frameNum : meta.actions["default"].end + 1);
            index = curFrame;
            while(index < nxtFrame)
            {
               _intactFrame.push(_keyFrame[keyIndex]);
               _intactTextures.push(_keyTextures[keyIndex]);
               index = index + 1;
            }
            keyIndex = keyIndex + 1;
         }
      }
      
      public function dispose() : void
      {
         if(atlasType == "bmp_atlas" && atlas)
         {
            atlas.dispose();
         }
         if(_keyFrame)
         {
            _keyFrame.splice(0,_keyFrame.length);
         }
         if(_keyTextures)
         {
            _keyTextures.splice(0,_keyFrame.length);
         }
         if(_intactFrame)
         {
            _intactFrame.splice(0,_keyFrame.length);
         }
         if(_intactTextures)
         {
            _intactTextures.splice(0,_keyFrame.length);
         }
         meta = null;
         atlas = null;
         _keyFrame = null;
         _keyTextures = null;
         _intactFrame = null;
         _intactTextures = null;
      }
   }
}


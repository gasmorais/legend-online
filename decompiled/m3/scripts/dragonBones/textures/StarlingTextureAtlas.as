package dragonBones.textures
{
   import dragonBones.utils.ConstValues;
   import dragonBones.utils.dragonBones_internal;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import starling.core.Starling;
   import starling.events.Event;
   import starling.textures.*;
   
   use namespace dragonBones_internal;
   
   public class StarlingTextureAtlas extends TextureAtlas implements ITextureAtlas
   {
      
      dragonBones_internal var _bitmapData:BitmapData;
      
      protected var _subTextureDic:Object;
      
      protected var _isDifferentXML:Boolean;
      
      protected var _scale:Number;
      
      protected var _name:String;
      
      private var _splitList:XMLList = null;
      
      private var _splitListLength:uint = 0;
      
      private var _currentCount:uint = 0;
      
      private var _splitMax:uint = 10;
      
      public function StarlingTextureAtlas(param1:Texture, param2:XML, param3:Boolean = false)
      {
         if(param1)
         {
            this._scale = param1.scale;
            this._isDifferentXML = param3;
         }
         super(param1,param2);
         if(param2)
         {
            this._name = param2.attribute(ConstValues.A_NAME);
         }
         this._subTextureDic = {};
         this._splitList = param2.SubTexture.@name;
         this._currentCount = 0;
         this._splitListLength = this._splitList.length();
         if(this._splitListLength > 0 && Boolean(Starling.current.stage))
         {
            Starling.current.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Texture = null;
         var _loc3_:String = null;
         var _loc4_:int = getTimer();
      }
      
      override public function dispose() : void
      {
         var _loc1_:SubTexture = null;
         super.dispose();
         for each(_loc1_ in this._subTextureDic)
         {
            _loc1_.dispose();
         }
         this._subTextureDic = {};
         if(this._bitmapData)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = null;
      }
      
      override public function getTexture(param1:String) : Texture
      {
         var _loc2_:Texture = this._subTextureDic[param1];
         if(!_loc2_)
         {
            _loc2_ = super.getTexture(param1);
            if(_loc2_)
            {
               this._subTextureDic[param1] = _loc2_;
            }
         }
         return _loc2_;
      }
      
      override protected function parseAtlasXml(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:SubTextureData = null;
         var _loc14_:Rectangle = null;
         var _loc2_:Number = this._isDifferentXML ? this._scale : 1;
         for each(_loc3_ in param1.SubTexture)
         {
            _loc4_ = _loc3_.attribute("name");
            _loc5_ = parseFloat(_loc3_.attribute("x")) / _loc2_;
            _loc6_ = parseFloat(_loc3_.attribute("y")) / _loc2_;
            _loc7_ = parseFloat(_loc3_.attribute("width")) / _loc2_;
            _loc8_ = parseFloat(_loc3_.attribute("height")) / _loc2_;
            _loc9_ = parseFloat(_loc3_.attribute("frameX")) / _loc2_;
            _loc10_ = parseFloat(_loc3_.attribute("frameY")) / _loc2_;
            _loc11_ = parseFloat(_loc3_.attribute("frameWidth")) / _loc2_;
            _loc12_ = parseFloat(_loc3_.attribute("frameHeight")) / _loc2_;
            _loc13_ = new SubTextureData(_loc5_,_loc6_,_loc7_,_loc8_);
            _loc13_.pivotX = int(_loc3_.attribute(ConstValues.A_PIVOT_X));
            _loc13_.pivotY = int(_loc3_.attribute(ConstValues.A_PIVOT_Y));
            _loc14_ = _loc11_ > 0 && _loc12_ > 0 ? new Rectangle(_loc9_,_loc10_,_loc11_,_loc12_) : null;
            addRegion(_loc4_,_loc13_,_loc14_);
         }
      }
   }
}


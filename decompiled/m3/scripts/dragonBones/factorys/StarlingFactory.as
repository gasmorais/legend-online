package dragonBones.factorys
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.display.StarlingDisplayBridge;
   import dragonBones.objects.XMLDataParser;
   import dragonBones.textures.StarlingTextureAtlas;
   import dragonBones.textures.SubTextureData;
   import dragonBones.utils.ConstValues;
   import dragonBones.utils.dragonBones_internal;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   use namespace dragonBones_internal;
   
   public class StarlingFactory extends BaseFactory
   {
      
      public var generateMipMaps:Boolean;
      
      public var optimizeForRenderToTexture:Boolean;
      
      public var scaleForTexture:Number;
      
      public function StarlingFactory()
      {
         super();
         this.scaleForTexture = 1;
         if(Boolean(Starling.current) && Starling.current.isStarted)
         {
            XMLDataParser.step(Starling.current.nativeStage);
         }
      }
      
      override protected function generateArmature() : Armature
      {
         return new Armature(new Sprite());
      }
      
      override protected function generateBone() : Bone
      {
         return new Bone(new StarlingDisplayBridge());
      }
      
      override protected function generateTextureDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
      {
         var _loc7_:SubTextureData = null;
         var _loc8_:Image = null;
         var _loc5_:StarlingTextureAtlas = param1 as StarlingTextureAtlas;
         if(_loc5_)
         {
            _loc7_ = _loc5_.getRegion(param2) as SubTextureData;
            if(_loc7_)
            {
               param3 ||= _loc7_.pivotX;
               param4 ||= _loc7_.pivotY;
            }
         }
         var _loc6_:SubTexture = (param1 as TextureAtlas).getTexture(param2) as SubTexture;
         if(_loc6_)
         {
            _loc8_ = new Image(_loc6_);
            _loc8_.pivotX = param3;
            _loc8_.pivotY = param4;
            return _loc8_;
         }
         return null;
      }
      
      override protected function generateTextureAtlas(param1:Object, param2:XML) : Object
      {
         var _loc3_:Texture = null;
         var _loc4_:BitmapData = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         if(param1 is BitmapData)
         {
            _loc4_ = param1 as BitmapData;
            _loc3_ = Texture.fromBitmapData(_loc4_,this.generateMipMaps,this.optimizeForRenderToTexture);
         }
         else if(param1 is MovieClip)
         {
            _loc6_ = int(param2.attribute(ConstValues.A_WIDTH)) * this.scaleForTexture;
            _loc7_ = int(param2.attribute(ConstValues.A_HEIGHT)) * this.scaleForTexture;
            _helpMatirx.a = 1;
            _helpMatirx.b = 0;
            _helpMatirx.c = 0;
            _helpMatirx.d = 1;
            _helpMatirx.scale(this.scaleForTexture,this.scaleForTexture);
            _helpMatirx.tx = 0;
            _helpMatirx.ty = 0;
            _loc8_ = param1 as MovieClip;
            _loc8_.gotoAndStop(1);
            _loc4_ = new BitmapData(_loc6_,_loc7_,true,16711935);
            _loc4_.draw(_loc8_,_helpMatirx);
            _loc8_.gotoAndStop(_loc8_.totalFrames);
            _loc3_ = Texture.fromBitmapData(_loc4_,this.generateMipMaps,this.optimizeForRenderToTexture,this.scaleForTexture);
         }
         var _loc5_:StarlingTextureAtlas = new StarlingTextureAtlas(_loc3_,param2);
         if(Starling.handleLostContext)
         {
            _loc5_._bitmapData = _loc4_;
         }
         else
         {
            _loc4_.dispose();
         }
         return _loc5_;
      }
   }
}


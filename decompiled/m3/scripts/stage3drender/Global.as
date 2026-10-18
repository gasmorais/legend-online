package stage3drender
{
   import dragonBones.factorys.StarlingFactory;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import map.internals.utils.QTree;
   import starling.textures.Texture;
   
   public class Global
   {
      
      public static var stage3dRenderLayer:Stage3DRenderLayer;
      
      public static var starlingFactory:StarlingFactory;
      
      public static var nameLayer:Sprite;
      
      public static var qtree:QTree;
      
      public static var avatarAltarTexture:Dictionary = new Dictionary();
      
      public static var avatarTextureDic:Dictionary = new Dictionary();
      
      public static var avatarPartPostion:Dictionary = new Dictionary();
      
      public static var avatarHitData:Dictionary = new Dictionary();
      
      public static var avatarPartParams:Dictionary = new Dictionary();
      
      public static var stage3dMovieStep:Dictionary = new Dictionary();
      
      public function Global()
      {
         super();
      }
      
      public static function disposeTexture(param1:Texture) : void
      {
         if(param1)
         {
            param1.dispose();
         }
      }
   }
}


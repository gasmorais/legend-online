package stage3drender
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import dragonBones.factorys.StarlingFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import stage3drender.map.Map;
   import stage3drender.nodes.Stage3dMoviel;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class Stage3DRenderLayer extends Sprite
   {
      
      private var _map:Map;
      
      public function Stage3DRenderLayer()
      {
         super();
         addEventListener("addedToStage",addedHandler);
      }
      
      private function addedHandler(param1:Event) : void
      {
         removeEventListener("addedToStage",addedHandler);
         Global.starlingFactory = new StarlingFactory();
         prepareLoad();
         init();
      }
      
      private function prepareLoad() : void
      {
         var _loc6_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.core.StandShadowAsset");
         Global.avatarTextureDic["shadow"] = Texture.fromBitmapData(_loc4_.bitmapData);
         ObjectUtils.disposeObject(_loc4_);
         _loc4_ = ComponentFactory.Instance.creatBitmap("asset.core.MountStandShadowAsset");
         Global.avatarTextureDic["mount_shadow"] = Texture.fromBitmapData(_loc4_.bitmapData);
         ObjectUtils.disposeObject(_loc4_);
         _loc4_ = ComponentFactory.Instance.creatBitmap("asset.map.SelectTargetAsset4");
         Global.avatarTextureDic["selecttarget1"] = Texture.fromBitmapData(_loc4_.bitmapData);
         ObjectUtils.disposeObject(_loc4_);
         _loc4_ = ComponentFactory.Instance.creatBitmap("asset.map.SelectTargetAsset3");
         Global.avatarTextureDic["selecttarget2"] = Texture.fromBitmapData(_loc4_.bitmapData);
         ObjectUtils.disposeObject(_loc4_);
         _loc4_ = ComponentFactory.Instance.creat("asset.map.FightEffect");
         Global.avatarTextureDic["fighteffect"] = new Vector.<Texture>();
         var _loc1_:Rectangle = new Rectangle(0,0,110,110);
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc1_.x = _loc5_ * 110;
            _loc6_ = new BitmapData(110,110,true,0);
            _loc6_.lock();
            _loc6_.copyPixels(_loc4_.bitmapData,_loc1_,new Point(0,0),null,null,true);
            _loc6_.unlock();
            Global.avatarTextureDic["fighteffect"].push(Texture.fromBitmapData(_loc6_));
            _loc6_.dispose();
            _loc5_++;
         }
         ObjectUtils.disposeObject(_loc4_);
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.outercity.WalkTargetEffectAsset");
         var _loc3_:Stage3dMoviel = new Stage3dMoviel();
         _loc3_.setContent(_loc2_,"WalkTargetEffectAsset");
         Global.avatarTextureDic["WalkTargetEffectAsset"] = _loc3_.frameTextures;
         ObjectUtils.disposeViolentMc(_loc2_);
         _loc2_ = null;
      }
      
      private function init() : void
      {
         _map = new Map();
         addChild(_map);
         Starling.juggler.add(_map);
      }
   }
}


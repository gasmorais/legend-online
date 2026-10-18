package stage3drender.nodes
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import flash.utils.ByteArray;
   import map.internals.data.CampaignNode;
   import stage3drender.Global;
   import stage3drender.bone.BoneResManager;
   import starling.display.DisplayObject;
   import yishi.manager.PathManager;
   
   public class SpaceStaticNode extends MapNodeRender
   {
      
      private var _armarture:Armature;
      
      public function SpaceStaticNode()
      {
         super();
      }
      
      override protected function setSwf() : void
      {
         var _loc1_:String = resourcesPath;
         if(_loc1_ == _url)
         {
            return;
         }
         _url = _loc1_;
         if(Global.starlingFactory.getTextureAtlas(_url))
         {
            armartureRun(_url);
         }
         else
         {
            LoaderManagerII.instance.load(_loc1_,1,5,addNetMovieClip);
         }
      }
      
      override protected function addNetMovieClip(param1:LoaderInfo, param2:Object) : void
      {
         if(_isDispose)
         {
            return;
         }
         if(!param2)
         {
            return;
         }
         BoneResManager.instance.createBoneMovie(_url,param2 as ByteArray,this,armartureRun);
      }
      
      private function armartureRun(param1:String) : void
      {
         if(_isDispose)
         {
            return;
         }
         if(param1 != _url)
         {
            return;
         }
         _armarture = Global.starlingFactory.buildArmature("cj","",_url);
         _armarture.animation.gotoAndPlay("cj",-1,-1,true);
         _movieContainer.addChild(_armarture.display as DisplayObject);
         WorldClock.clock.add(_armarture);
      }
      
      public function get movie() : Object
      {
         return _armarture;
      }
      
      override protected function get resourcesPath() : String
      {
         if(info.info.types == 201)
         {
            return PathManager.solveCampaignMovieByUrl(_info.info.names.replace(".swf",".png"));
         }
         return PathManager.solveMapPhysicsBySonType((_info as CampaignNode).sonType);
      }
      
      override public function dispose() : void
      {
         if(_armarture)
         {
            WorldClock.clock.remove(_armarture);
            _armarture.dispose();
            _armarture = null;
         }
         super.dispose();
      }
   }
}


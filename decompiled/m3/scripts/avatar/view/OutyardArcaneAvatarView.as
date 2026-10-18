package avatar.view
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.geom.Point;
   import map.campaign.data.CollectionRobotData;
   import map.internals.data.CampaignNode;
   import map.internals.utils.MapUtisl;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.ai.AIPhysicsBase;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   
   public class OutyardArcaneAvatarView extends AIPhysicsBase
   {
      
      protected var _nodeInfo:CampaignNode;
      
      protected var _avatar:Avatar;
      
      private var _angle:Number;
      
      public function OutyardArcaneAvatarView()
      {
         super();
      }
      
      public function set nodeInfo(param1:CampaignNode) : void
      {
         _nodeInfo = param1;
         showAvatar();
      }
      
      protected function showAvatar() : void
      {
         var _loc1_:Object = null;
         var _loc7_:String = null;
         var _loc5_:Object = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc4_:CampaignNode = _nodeInfo as CampaignNode;
         if(!_loc4_)
         {
            return;
         }
         avatarView = new HeroAvatar(true,_loc4_.sonType.toString(),2,0,true);
         _loc4_.toward = _loc4_.toward;
         updateDirection(_loc4_.toward);
         if(_loc4_.info.types != 101)
         {
            _loc7_ = PathManager.getAvatarResourcePath(_loc4_.sonType.toString(),-1,1,"body",-1,2);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
         }
         else
         {
            avatarView.type = 1;
            _loc5_ = CollectionRobotData.robotData[_loc4_.sonType];
            _loc3_ = "/" + _loc5_.body;
            _loc2_ = "/" + _loc5_.army;
            _loc6_ = int(_loc5_.job);
            this._avatar.scaleX = this._avatar.scaleY = 0.85;
            _loc7_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_.sex,1,"body",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(_loc2_,_loc5_.sex,1,"army",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","army"),AvatarStaticData.getBaseNumByType("Walk","army"),"army");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(JobType.getDefaultHairUpByJob(_loc6_),_loc5_.sex,1,"hairUp",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","hairUp"),AvatarStaticData.getBaseNumByType("Walk","hairUp"),"hairUp");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(JobType.getDefaultHairDownByJob(_loc6_),_loc5_.sex,1,"hairDown",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","hairDown"),AvatarStaticData.getBaseNumByType("Walk","hairDown"),"hairDown");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(_loc3_ + "_cloak",_loc5_.sex,1,"cloak",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","cloak"),AvatarStaticData.getBaseNumByType("Walk","cloak"),"cloak");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
         }
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         super.nextWalk(param1);
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
      }
      
      public function standImp() : void
      {
         if(_avatar)
         {
            _avatar.state = 3;
         }
      }
      
      public function updateDirection(param1:Number) : void
      {
         if(_avatar)
         {
            _avatar.angle = param1;
         }
         if(_avatar && _isPlaying)
         {
            _avatar.run();
            if(!_isStand)
            {
               _avatar.state = 4;
            }
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar && _isPlaying)
         {
            _avatar.run();
            if(!_isStand)
            {
               _avatar.state = 4;
            }
         }
      }
      
      protected function createResourceLoadInfo(param1:String, param2:Array, param3:Array, param4:String) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.packageName = MapUtisl.getPackageName(param1);
         _loc5_.stand = param2;
         _loc5_.walk = param3;
         _loc5_.position = param4;
         _loc5_.url = param1;
         return _loc5_;
      }
      
      protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HumanAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set avatarView(param1:Avatar) : void
      {
         if(_avatar)
         {
            if(_avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            _avatar.dispose();
         }
         _avatar = null;
         _avatar = param1;
         _avatar.angle = 100;
         if(_isPlaying)
         {
            addChild(_avatar);
         }
      }
      
      public function get avatarView() : Avatar
      {
         return _avatar;
      }
   }
}


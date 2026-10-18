package timevortex.view
{
   import avatar.data.AvatarStaticData;
   import avatar.view.CampaignAvatar;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import map.internals.utils.MapUtisl;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class TimeVortexShowAvatar extends Component
   {
      
      private var _avatar:CampaignAvatar;
      
      private var _npcName:FilterFrameText;
      
      private var _data:CampaignAreaInfo;
      
      public var showNamePosY:int = -130;
      
      public function TimeVortexShowAvatar()
      {
         super();
      }
      
      public function initView() : void
      {
      }
      
      public function uninitView() : void
      {
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _data = null;
      }
      
      public function showName(param1:String) : void
      {
         if(_npcName == null)
         {
            _npcName = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexShowAvatar.bossNameTxt");
            addChild(_npcName);
         }
         _npcName.text = param1;
      }
      
      public function set data(param1:CampaignAreaInfo) : void
      {
         _data = param1;
         refreshAvatarView();
      }
      
      public function get data() : CampaignAreaInfo
      {
         return _data;
      }
      
      protected function refreshAvatarView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         if(data)
         {
            _loc1_ = int(_data.getMapByDifficult(1).SonTypes);
            avatarView = new CampaignAvatar(_loc1_.toString(),2,0,true);
            _loc3_ = PathManager.getAvatarResourcePath(_loc1_.toString(),-1,1,"body",-1,2);
            _loc2_ = createResourceLoadInfo(_loc3_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc3_,4,7,loaderCompleteHandler,null,null,_loc2_);
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
            (_avatar as CampaignAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
         if(param1.url.indexOf("body") >= 0 || param1.url.indexOf("npc") >= 0)
         {
            layouTextView(param1.url);
         }
      }
      
      private function layouTextView(param1:String) : void
      {
         if(!_npcName)
         {
            return;
         }
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         showNamePosY = -110;
         if(_loc2_)
         {
            if(_loc2_.showNamePosY)
            {
               showNamePosY = _loc2_.showNamePosY;
            }
            if(_loc2_.hasOwnProperty("noShadow"))
            {
               _avatar.noShadow = _loc2_.noShadow;
            }
            if(_loc2_.hasOwnProperty("curTotalFrameX"))
            {
               _avatar.curTotalFrameX = _loc2_.curTotalFrameX;
            }
         }
         _npcName.y = showNamePosY;
         NotificationManager.instance.sendNotification("NPC_LOAD_COMPLETE",this);
      }
      
      public function set avatarView(param1:CampaignAvatar) : void
      {
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         _avatar = param1;
         _avatar.stepFrame = 5;
         _avatar.angle = 90;
         _avatar.state = 3;
         _avatar.noShadow = true;
         addChildAt(_avatar,0);
      }
      
      public function get avatarView() : CampaignAvatar
      {
         return _avatar;
      }
      
      public function execute() : void
      {
         if(_avatar)
         {
            _avatar.run();
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         uninitView();
         super.dispose();
      }
   }
}


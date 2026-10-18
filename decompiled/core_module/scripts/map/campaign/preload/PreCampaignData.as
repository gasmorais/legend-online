package map.campaign.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import map.internals.data.MapInfo;
   import map.internals.load.PreLoadMapData;
   import yishi.datas.consant.JobType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.view.community.LoadingSceneView;
   
   public class PreCampaignData extends PreLoadMapData
   {
      
      private var _loadCount:int = 0;
      
      private var _loadTotal:int;
      
      private var _failCount:int = 0;
      
      private var _behindBool:Boolean;
      
      private var _preLoadProperty:int;
      
      private var timeId:int;
      
      protected var _avatarMaxCount:int = 2;
      
      protected var _avatarCount:int;
      
      private var _url:String;
      
      public function PreCampaignData(param1:MapInfo, param2:Boolean = false)
      {
         _behindBool = param2;
         if(_behindBool)
         {
            _preLoadProperty = 8;
         }
         else
         {
            _preLoadProperty = 10;
         }
         super(param1);
      }
      
      override protected function loadData() : void
      {
         _loadTotal = 2;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc4_:int = _model.mapTempInfo.MapFileId;
         var _loc3_:String = PathManager.getOuterCityMapsData(_loc4_);
         LoaderManagerII.instance.load(_loc3_,1,_preLoadProperty,__resultMapsInfo,null,null,null,_loc1_);
         var _loc2_:String = PathManager.getOuterCityTilesData(_loc4_);
         LoaderManagerII.instance.load(_loc2_,1,_preLoadProperty,__resultTilesInfo,null,null,null,_loc1_);
         var _loc5_:String = PathManager.mapNameMoviePath(_loc4_ > 100000 ? 100 : _loc4_);
         LoaderManagerII.instance.load(_loc5_,2,_preLoadProperty,__loadCompleteHandler);
      }
      
      private function __resultMapsInfo(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         if(!_model)
         {
            return;
         }
         try
         {
            _loc3_ = param2 as ByteArray;
            _loc3_.uncompress();
            _loc4_ = _loc3_.readObject();
            _loc3_.bytesAvailable && (_loc4_);
            _loc5_ = _loc3_.readObject();
            _loc3_.bytesAvailable && (_loc5_);
            _loc6_ = _loc3_.readObject();
            _loc3_.bytesAvailable && (_loc6_);
            if(_loc4_)
            {
               _model.floorData = _loc4_;
               _model.moviesData = _loc5_;
               _model.topsData = _loc6_;
            }
            else
            {
               if(_failCount < 2)
               {
                  _failCount = _failCount + 1;
                  timeId = setTimeout(loadImageData,300);
                  return;
               }
               _model.floorData = {};
            }
            _loadCount = _loadCount + 1;
            loadProgress();
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadImageData() : void
      {
         clearTimeout(timeId);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc3_:int = _model.mapTempInfo.MapFileId;
         var _loc2_:String = PathManager.getOuterCityMapsData(_loc3_);
         LoaderManagerII.instance.load(_loc2_,1,_preLoadProperty,__resultMapsInfo,null,null,_loc1_);
      }
      
      private function __resultTilesInfo(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Object = null;
         if(!_model)
         {
            return;
         }
         try
         {
            (param2 as ByteArray).uncompress();
            _loc3_ = (param2 as ByteArray).readObject();
            _model.mapTielsData = _loc3_;
            _loadCount = _loadCount + 1;
            loadProgress();
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadProgress() : void
      {
         if(!_behindBool)
         {
            LoadingSceneView.instance.update(_loadCount * 2 + 20);
         }
         if(_loadTotal <= _loadCount)
         {
            loadMoviePro(true,1,1);
         }
      }
      
      private function loadMapMovie() : void
      {
         new PreLoadCampaignStaticMovie().loadMoveByData(_model.moviesData,loadMoviePro);
      }
      
      private function loadMoviePro(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:PreLoadFloorData = null;
         if(param1)
         {
            _loc4_ = new PreLoadFloorData(loadPro);
            _loc4_.load(_loc4_.getMapFloorData(_model.floorData,2));
         }
         if(!_behindBool)
         {
            LoadingSceneView.instance.update(param2 / param3 * 22 + 28);
         }
      }
      
      private function loadPro(param1:Boolean, param2:int, param3:int) : void
      {
         if(param1)
         {
            loadSelfAvatar();
         }
         if(!_behindBool)
         {
            LoadingSceneView.instance.update(param2 / param3 * 50 + 50);
         }
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
      }
      
      private function loadSelfAvatar() : void
      {
         var _loc6_:int = thane.templateInfo ? thane.templateInfo.Job : thane.job;
         var _loc3_:int = thane.templateInfo ? thane.templateInfo.Sexs : thane.sexs;
         var _loc4_:int = thane.id;
         var _loc5_:GoodsInfo = GoodsManager.instance.getHeroEquipByPos(_loc4_,1);
         var _loc2_:String = "";
         if(_loc5_)
         {
            _loc2_ = _loc5_.templateInfo.Avata;
         }
         if(_loc2_ == "")
         {
            _loc2_ = JobType.getDefaultArmysEquipNameByJob(_loc6_);
         }
         var _loc1_:String = "";
         _loc5_ = GoodsManager.instance.getHeroEquipByPos(_loc4_,2);
         if(_loc5_)
         {
            _loc1_ = _loc5_.templateInfo.Avata;
         }
         if(_loc1_ == "")
         {
            _loc1_ = JobType.getDefaultBodyEquipNameByJob(_loc6_);
         }
         if(_loc6_ <= 6)
         {
            loadResourceByKey(_loc2_,_loc3_,loadAvatarCall,_loc6_);
         }
         else
         {
            _avatarMaxCount = 1;
         }
         loadResourceByKey(_loc1_,_loc3_,loadAvatarCall,_loc6_);
      }
      
      protected function loadAvatarCall() : void
      {
         _avatarCount = _avatarCount + 1;
         LoadingSceneView.instance.update(_avatarCount * 1 + 90);
         if(_avatarCount >= _avatarMaxCount)
         {
            backCall();
         }
      }
      
      private function loadResourceByKey(param1:String, param2:int, param3:Function, param4:int) : void
      {
         _url = param4 == 100 ? PathManager.resourcePath + param1 : getResourcepath(param1,param2);
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.call = param3;
         _loc5_.url = _url;
         LoaderManagerII.instance.load(_url,4,4,__loaderCompleteHandler,null,null,_loc5_);
      }
      
      private function __loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Function = null;
         if(param1)
         {
            _loc3_ = param1.args.call;
            if(_loc3_ != null)
            {
               _loc3_();
            }
            _loc3_ = null;
            param1.args.call = null;
         }
      }
      
      private function getResourcepath(param1:String, param2:int) : String
      {
         return PathManager.avatarResourcePath(param1,param2);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}


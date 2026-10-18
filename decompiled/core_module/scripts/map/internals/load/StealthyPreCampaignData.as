package map.internals.load
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import map.campaign.preload.PreLoadCampaignStaticMovie;
   import map.campaign.preload.PreLoadFloorData;
   import yishi.manager.PathManager;
   
   public class StealthyPreCampaignData
   {
      
      private var _loadCount:int = 0;
      
      private var _loadTotal:int;
      
      private var _mapFileId:int = -1;
      
      private var _model:Object = {};
      
      public function StealthyPreCampaignData()
      {
         super();
      }
      
      public function set mapFileId(param1:int) : void
      {
         _mapFileId = param1;
         loadData();
      }
      
      protected function loadData() : void
      {
         _loadTotal = 4;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc5_:int = _mapFileId;
         var _loc3_:String = PathManager.getOuterCityMapsData(_loc5_);
         LoaderManagerII.instance.load(_loc3_,1,8,__resultMapsInfo,null,null,null,_loc1_);
         var _loc2_:String = PathManager.getOuterCityTilesData(_loc5_);
         LoaderManagerII.instance.load(_loc2_,1,8,__resultTilesInfo,null,null,null,_loc1_);
         var _loc4_:String = PathManager.getOuterCityNoteData(_loc5_);
         LoaderManagerII.instance.load(_loc4_,1,8,__resultNodesInfo,null,null,null,_loc1_);
         var _loc6_:String = PathManager.mapNameMoviePath(_loc5_ > 100000 ? 100 : _loc5_);
         LoaderManagerII.instance.load(_loc6_,2,8,__loadCompleteHandler);
      }
      
      private function __resultTilesInfo(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Object = null;
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
      
      private function __resultNodesInfo(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Object = null;
         try
         {
            (param2 as ByteArray).uncompress();
            _loc3_ = (param2 as ByteArray).readObject();
            _model.nodes = _loc3_;
            _loadCount = _loadCount + 1;
            loadProgress();
         }
         catch(e:Error)
         {
         }
      }
      
      private function __resultMapsInfo(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
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
               _model.floorData = {};
            }
            _loadCount = _loadCount + 1;
            loadProgress();
         }
         catch(e:Error)
         {
         }
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _loadCount = _loadCount + 1;
         loadProgress();
      }
      
      private function loadProgress() : void
      {
         if(_loadTotal <= _loadCount)
         {
            loadMapMovie();
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
      }
      
      private function loadPro(param1:Boolean, param2:int, param3:int) : void
      {
      }
   }
}


package map.campaign.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.MapInfo;
   import map.internals.library.MapElmsLibrary;
   import map.internals.load.PreLoadMapData;
   import yishi.manager.PathManager;
   
   public class PreRigeterCampaignData extends PreLoadMapData
   {
      
      private static const mapConfigPro:Number = 0.06;
      
      private static const mapMoviePro:Number = 0.14;
      
      private static const mapImagesPro:Number = 0.74;
      
      private static const otherPro:Number = 0.06;
      
      private var _loadCount:int = 0;
      
      private var _loadTotal:int;
      
      private var _behindBool:Boolean;
      
      private var _isAddQueue:Boolean;
      
      private var _proCall:Function;
      
      private var _args:Object;
      
      private var _curLoadOtherCount:int = 0;
      
      private var _needLoadOtherCount:int = 0;
      
      public function PreRigeterCampaignData(param1:MapInfo, param2:Function, param3:Boolean = false, param4:Boolean = false, param5:Object = null)
      {
         _isAddQueue = param4;
         _proCall = param2;
         _behindBool = param3;
         _args = param5;
         super(param1);
      }
      
      override protected function loadData() : void
      {
         _loadTotal = 2;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc4_:int = _model.mapId;
         var _loc3_:String = PathManager.getOuterCityMapsData(_loc4_);
         LoaderManagerII.instance.load(_loc3_,1,8,__resultMapsInfo,null,null,null,_loc1_);
         var _loc2_:String = PathManager.getOuterCityTilesData(_loc4_);
         LoaderManagerII.instance.load(_loc2_,1,8,__resultTilesInfo,null,null,null,_loc1_);
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
               solveCampaignModel.moviesData = _loc5_;
               solveCampaignModel.topsData = _loc6_;
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
      
      private function get solveCampaignModel() : CampaignMapModel
      {
         return _model as CampaignMapModel;
      }
      
      private function loadProgress() : void
      {
         if(!_behindBool)
         {
            if(_proCall != null)
            {
               _proCall(_loadCount / _loadTotal * 0.06);
            }
         }
         if(_loadTotal <= _loadCount)
         {
            loadMoviePro(true,1,1);
         }
      }
      
      private function loadMoviePro(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:PreLoadFloorData = null;
         if(param1)
         {
            MapElmsLibrary.instance.isLoaderQueue = _isAddQueue;
            _loc4_ = new PreLoadFloorData(loadPro);
            if(_args)
            {
               _loc4_.load(_loc4_.getMapFloorData({
                  "row":int(_args["row"]),
                  "column":int(_args["column"])
               },_model.mapId));
            }
            else
            {
               _loc4_.load(_loc4_.getMapFloorData({
                  "row":0,
                  "column":0
               },_model.mapId));
            }
         }
         if(!_behindBool)
         {
            if(_proCall != null)
            {
               _proCall(param2 / param3 * 0.14 + 0.06);
            }
         }
      }
      
      private function loadPro(param1:Boolean, param2:int, param3:int) : void
      {
         if(param1)
         {
            MapElmsLibrary.instance.isLoaderQueue = false;
            loadOther();
         }
         if(!_behindBool)
         {
            if(_proCall != null)
            {
               _proCall(param2 / param3 * 0.74 + (0.14 + 0.06));
            }
         }
      }
      
      override protected function backCall() : void
      {
         super.backCall();
         _proCall = null;
         _args = null;
      }
      
      private function loadOther() : void
      {
         var _loc2_:String = null;
         var _loc1_:ResourceLoaderInfo = null;
         _loc2_ = PathManager.resourcePath + "swf/npc/2253.bswf";
         _loc1_ = new ResourceLoaderInfo();
         _loc1_.url = _loc2_;
         _needLoadOtherCount = _needLoadOtherCount + 1;
         LoaderManagerII.instance.load(_loc2_,4,4,onSingleOtherLoadComplete,null,null,_loc1_);
      }
      
      private function onSingleOtherLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         _curLoadOtherCount = _curLoadOtherCount + 1;
         if(!_behindBool)
         {
            if(_proCall != null)
            {
               _proCall(_curLoadOtherCount / _needLoadOtherCount * 0.06 + (0.74 + 0.14 + 0.06));
            }
         }
         if(_curLoadOtherCount >= _needLoadOtherCount)
         {
            backCall();
         }
      }
   }
}


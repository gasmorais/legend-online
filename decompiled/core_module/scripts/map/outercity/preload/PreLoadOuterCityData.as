package map.outercity.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import map.campaign.preload.PreLoadFloorData;
   import map.internals.data.MapInfo;
   import map.internals.load.PreLoadMapData;
   import yishi.manager.PathManager;
   import yishi.view.community.LoadingSceneView;
   
   public class PreLoadOuterCityData extends PreLoadMapData
   {
      
      private var _stepTimeId1:int;
      
      private var _stepTimeId2:int;
      
      private var _stepTimeId3:int;
      
      private var _stepTimeId4:int;
      
      private var _loadCount:int;
      
      private var _upProView:Boolean;
      
      public function PreLoadOuterCityData(param1:MapInfo, param2:Boolean = true)
      {
         _upProView = param2;
         super(param1);
      }
      
      override protected function loadData() : void
      {
         _stepTimeId4 = setTimeout(loadSteps,0,4);
         _stepTimeId1 = setTimeout(loadSteps,80,1);
         _stepTimeId2 = setTimeout(loadSteps,180,2);
      }
      
      private function loadSteps(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["rnd"] = Math.random();
         var _loc4_:int = _model.mapTempInfo.MapFileId;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = PathManager.getOuterCityMapsData(_loc4_);
               LoaderManagerII.instance.load(_loc3_,1,8,__resultMapsInfo,null,null,null,_loc2_);
               break;
            case 1:
               _loc3_ = PathManager.getOuterCityTilesData(_loc4_);
               LoaderManagerII.instance.load(_loc3_,1,8,__resultTilesInfo,null,null,null,_loc2_);
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
               _model.moviesData = _loc5_;
               _model.topsData = _loc6_;
            }
            else
            {
               _model.floorData = {};
            }
            loadImages();
         }
         catch(e:Error)
         {
         }
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
            loadImages();
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadImages() : void
      {
         var _loc1_:PreLoadFloorData = null;
         _loadCount = _loadCount + 1;
         if(_upProView)
         {
            LoadingSceneView.instance.update(int(_loadCount + 20));
         }
         if(_model.floorData && _model.mapTielsData)
         {
            clearInterval(_stepTimeId1);
            clearInterval(_stepTimeId2);
            clearInterval(_stepTimeId3);
            clearInterval(_stepTimeId4);
            _loc1_ = new PreLoadFloorData(loadPro);
            _loc1_.load(_loc1_.getMapFloorData(_model.floorData,1));
         }
      }
      
      private function loadPro(param1:Boolean, param2:int, param3:int) : void
      {
         if(_upProView)
         {
            LoadingSceneView.instance.update(param2 / param3 * 77 + 20);
         }
         if(param1)
         {
            backCall();
         }
      }
   }
}


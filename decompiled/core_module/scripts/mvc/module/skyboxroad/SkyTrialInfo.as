package mvc.module.skyboxroad
{
   import com.road.yishi.proto.skytrial.SkyTrialLayerMsg;
   
   public class SkyTrialInfo
   {
      
      public var layerList:Array;
      
      public var buyEnergyCount:int;
      
      private var _skillCountList:Object;
      
      private var _buffList:Array;
      
      public var searchPoint:int;
      
      public var energy:int;
      
      public function SkyTrialInfo()
      {
         super();
         layerList = [];
      }
      
      public function get buffList() : Array
      {
         return _buffList;
      }
      
      public function get skillCountList() : Object
      {
         return _skillCountList;
      }
      
      public function setBuffList(param1:Array) : void
      {
         var _loc2_:int = 0;
         _buffList = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _buffList.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setSkillList(param1:Array) : void
      {
         var _loc2_:int = 0;
         _skillCountList = {};
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _skillCountList[param1[_loc2_]] = param1[_loc2_ + 1];
            _loc2_++;
            _loc2_++;
         }
      }
      
      public function updateLayerList(param1:SkyTrialLayerMsg) : void
      {
         var _loc2_:SkyTrialLayerInfo = getLayerInfoByLayerNum(param1.layerNum);
         _loc2_.updateLayerInfo(param1);
      }
      
      public function getPortalByLayerAndTempId(param1:int, param2:int) : SkyTrialPortalInfo
      {
         var _loc3_:SkyTrialPortalInfo = null;
         var _loc4_:int = 0;
         var _loc5_:SkyTrialLayerInfo = getLayerInfoByLayerNum(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.portalList.length)
         {
            if(_loc5_.portalList[_loc4_].portalTempId == param2)
            {
               _loc3_ = _loc5_.portalList[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getLayerInfoByLayerNum(param1:int) : SkyTrialLayerInfo
      {
         var _loc2_:int = 0;
         var _loc3_:SkyTrialLayerInfo = null;
         _loc2_ = 0;
         while(_loc2_ < layerList.length)
         {
            if(layerList[_loc2_].layerNum == param1)
            {
               _loc3_ = layerList[_loc2_];
               break;
            }
            _loc2_++;
         }
         if(_loc3_ == null)
         {
            _loc3_ = new SkyTrialLayerInfo();
            _loc3_.setInitData(param1);
            layerList.push(_loc3_);
         }
         return _loc3_;
      }
   }
}


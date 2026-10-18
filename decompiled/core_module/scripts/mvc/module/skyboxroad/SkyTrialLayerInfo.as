package mvc.module.skyboxroad
{
   import com.road.yishi.proto.skytrial.SkyTrialLayerMsg;
   import com.road.yishi.proto.skytrial.SkyTrialPortalMsg;
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkyTrialPortalTemplateInfo;
   import yishi.datas.templates.SkytriallayerTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class SkyTrialLayerInfo
   {
      
      public var layerNum:int;
      
      public var portalList:Array;
      
      public var tempInfo:SkytriallayerTemplateInfo;
      
      public function SkyTrialLayerInfo()
      {
         super();
         portalList = [];
      }
      
      public function setInitData(param1:int) : void
      {
         var _loc2_:SkyTrialPortalTemplateInfo = null;
         var _loc4_:SkyTrialPortalInfo = null;
         this.layerNum = param1;
         tempInfo = TempleteManager.instance.skytriallayerTemplateCate.getTemplateByLayerNum(param1);
         var _loc5_:Dictionary = TempleteManager.instance.skyTrialPortalTemplateCate.getTemplates();
         for(var _loc3_:String in _loc5_)
         {
            _loc2_ = _loc5_[_loc3_];
            if(_loc2_.LayerNum == param1)
            {
               _loc4_ = new SkyTrialPortalInfo();
               _loc4_.setInitData(_loc2_);
               portalList.push(_loc4_);
            }
         }
      }
      
      public function updateLayerInfo(param1:SkyTrialLayerMsg) : void
      {
         var _loc4_:int = 0;
         var _loc3_:SkyTrialPortalInfo = null;
         var _loc2_:SkyTrialPortalMsg = null;
         _loc4_ = 0;
         while(_loc4_ < param1.portalList.length)
         {
            _loc2_ = param1.portalList[_loc4_];
            _loc3_ = getPortalByTempId(_loc2_.portalId);
            _loc3_.updatePortalInfo(_loc2_);
            _loc4_++;
         }
      }
      
      public function get isAllClear() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:SkyTrialPortalInfo = null;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < portalList.length)
         {
            _loc2_ = portalList[_loc3_];
            if(!_loc2_.clear)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getPortalByTempId(param1:int) : SkyTrialPortalInfo
      {
         var _loc3_:int = 0;
         var _loc2_:SkyTrialPortalInfo = null;
         _loc3_ = 0;
         while(_loc3_ < portalList.length)
         {
            _loc2_ = portalList[_loc3_];
            if(_loc2_.portalTempId == param1)
            {
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}


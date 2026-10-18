package mvc.module.skyboxroad
{
   import com.road.yishi.proto.skytrial.SkyTrialPortalMsg;
   import yishi.datas.templates.SkyTrialPortalTemplateInfo;
   
   public class SkyTrialPortalInfo
   {
      
      public var portalTempId:int;
      
      public var searchCount:int = 0;
      
      public var clear:Boolean;
      
      public var tempInfo:SkyTrialPortalTemplateInfo;
      
      public function SkyTrialPortalInfo()
      {
         super();
      }
      
      public function setInitData(param1:SkyTrialPortalTemplateInfo) : void
      {
         tempInfo = param1;
         portalTempId = tempInfo.PortalId;
         searchCount = 0;
         searchCount = 0;
      }
      
      public function updatePortalInfo(param1:SkyTrialPortalMsg) : void
      {
         searchCount = param1.searchCount;
         clear = param1.clear;
      }
      
      public function get explorePercen() : Number
      {
         var _loc1_:Number = searchCount / tempInfo.TotalSearchCount;
         return _loc1_ > 1 ? 1 : _loc1_;
      }
   }
}


package mvc.module.skyboxroad
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class SkyBoxRoadPointInfo
   {
      
      public var portalId:int;
      
      public var posIndex:int;
      
      public var occpUuid:String;
      
      public var occpUserId:int;
      
      public var nickName:String;
      
      public var svrsName:String;
      
      public var occpDateStr:String;
      
      public var occpMinute:int;
      
      public var userInfo:ThaneInfo;
      
      public function SkyBoxRoadPointInfo()
      {
         super();
         userInfo = new ThaneInfo();
      }
   }
}


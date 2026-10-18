package farm.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.farm.FarmOperReqMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class FarmSocketSendManager
   {
      
      public function FarmSocketSendManager()
      {
         super();
      }
      
      private static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendLandUp(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = TempleteManager.instance.getConfigInfoByConfigName("FarmLand_Points").ConfigValue.split(",");
         if(param1 - 1 > _loc5_.length)
         {
            _loc4_ = int(_loc5_[_loc5_.length - 1]);
         }
         else
         {
            _loc4_ = int(_loc5_[param1 - 1]);
         }
         var _loc6_:String = LanguageMgr.GetTranslation("farm.FarmManager.landUpPayTip",_loc4_,param1 + 1);
         SimpleAlertHelper.instance.data = [sendLandUpCall];
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc6_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc4_);
      }
      
      private static function sendLandUpCall(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = null;
         var _loc5_:FarmOperReqMsg = null;
         if(param1)
         {
            _loc6_ = new PackageOut(15044);
            _loc5_ = new FarmOperReqMsg();
            _loc5_.opType = 11;
            _loc5_.payType = 0;
            if(!param2)
            {
               _loc5_.payType = 1;
            }
            sendProtoBuffer(_loc6_,_loc5_);
         }
      }
   }
}


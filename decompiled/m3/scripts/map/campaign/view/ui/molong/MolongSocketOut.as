package map.campaign.view.ui.molong
{
   import com.road.yishi.proto.campaign.BoxInfoMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import manager.LanguageMgr;
   import yishi.GlobalConfig;
   import yishi.comm.PackageOut;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class MolongSocketOut
   {
      
      public function MolongSocketOut()
      {
         super();
      }
      
      public static function clickMolongMap() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("chat.view.ChatView.EnterMolongCampaignNoStartTips");
         SimpleAlertHelper.instance.data = [createMolongCampaign];
         if(PlayerManager.instance.currentPlayerModel.playerInfo.molongRestNum <= 0)
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,false);
         }
         else
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,false,2,"CHATINVIE_ALERT");
         }
      }
      
      private static function createMolongCampaign(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = null;
         if(!param1)
         {
            return;
         }
         _loc4_ = new PackageOut(8761);
         var _loc3_:CampaignReqMsg = new CampaignReqMsg();
         if(PlayerManager.instance.currentPlayerModel.playerInfo.molongRestNum <= 0)
         {
            _loc3_.paraBool1 = true;
         }
         else
         {
            _loc3_.paraBool1 = !param2;
         }
         GlobalConfig.isGet = !_loc3_.paraBool1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function getBox(param1:int) : void
      {
         var _loc3_:PackageOut = null;
         _loc3_ = new PackageOut(8768);
         var _loc2_:BoxInfoMsg = new BoxInfoMsg();
         _loc2_.boxId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function molongOperate(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = null;
         _loc4_ = new PackageOut(8769);
         var _loc3_:DragonCampaingnDataMsg = new DragonCampaingnDataMsg();
         _loc3_.type = param1;
         _loc3_.param1 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}


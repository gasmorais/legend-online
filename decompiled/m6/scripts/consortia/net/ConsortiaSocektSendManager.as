package consortia.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.consortia.ConsortiaAltarOpenReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.consortia.ConsortiaQuitReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaRenameReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaTreasureOpMsg;
   import com.road.yishi.proto.consortia.ConsortiaUserOfferReqMsg;
   import com.road.yishi.proto.consortia.ConsortiaVotingReqMsg;
   import com.road.yishi.proto.consortia.SearchConditionMsg;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInviteInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaVotingUserInfo;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaSocektSendManager
   {
      
      public function ConsortiaSocektSendManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public static function sendOpenDemon() : void
      {
         var _loc2_:PackageOut = new PackageOut(8541);
         var _loc1_:ConsortiaAltarOpenReqMsg = new ConsortiaAltarOpenReqMsg();
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendVotingInfo(param1:ConsortiaVotingUserInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8481);
         var _loc2_:ConsortiaVotingReqMsg = new ConsortiaVotingReqMsg();
         _loc2_.votingUser = param1.userId;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function searchConsortia(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(8213);
         var _loc4_:SearchConditionMsg = new SearchConditionMsg();
         _loc4_.consortiaName = param1;
         _loc4_.pageIndex = param2;
         _loc4_.isNewOpen = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function consortiaRename(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(5148);
         var _loc4_:ConsortiaRenameReqMsg = new ConsortiaRenameReqMsg();
         _loc4_.newName = param1;
         _loc4_.same = param2;
         _loc4_.payType = 0;
         if(!param3)
         {
            _loc4_.payType = 1;
         }
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function consortiaContribute(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         if(ResourceManager.instance.gold.count < param1)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command06");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(playerInfo.point + playerInfo.giftToken < param2)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command07");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         var _loc4_:int = int(param1 / 1000) * 1000;
         consortiaContributesend(_loc4_,param2);
      }
      
      public static function consortiaContributesend(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5144);
         var _loc3_:ConsortiaUserOfferReqMsg = new ConsortiaUserOfferReqMsg();
         _loc3_.offerGold = param1;
         _loc3_.offerPoint = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function consortiaContributeSoul(param1:int) : void
      {
         if(playerInfo.strategy < param1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.ConsortiaControler.command11"));
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8845);
         var _loc2_:ConsortiaUserOfferReqMsg = new ConsortiaUserOfferReqMsg();
         _loc2_.offerGold = int(param1 / 1000) * 1000;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function exitConsortia(param1:int = 0, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(5146);
         var _loc3_:ConsortiaQuitReqMsg = new ConsortiaQuitReqMsg();
         _loc3_.clear_CDType = param1;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function deleteApplyConsortia(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5141);
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_.applyId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function applyJoinConsortiaSend(param1:int) : void
      {
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var point:String;
         var content:String;
         var alertHandler:*;
         var pkg:PackageOut;
         var msg:ConsortiaMsg;
         var $id:int = param1;
         var num:Number = Number(PlayerManager.instance.currentPlayerModel.playerInfo.lastOutConsortia);
         var isAuto:Boolean = Boolean(PlayerManager.instance.currentPlayerModel.playerInfo.isAuto);
         if(isAuto && num + 86400 > PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond)
         {
            alertHandler = function(param1:Boolean, param2:Boolean):void
            {
               var _loc4_:PackageOut = null;
               var _loc3_:ConsortiaMsg = null;
               if(param1)
               {
                  if(PlayerManager.instance.currentPlayerModel.playerInfo.point < int(TempleteManager.instance.getConfigInfoByConfigName("Consortia_ClearCD_Point").ConfigValue))
                  {
                     RechargeAlertMannager.show();
                     return;
                  }
                  _loc4_ = new PackageOut(5135);
                  _loc3_ = new ConsortiaMsg();
                  _loc3_.consortiaId = $id;
                  _loc3_.isPay = true;
                  sendProtoBuffer(_loc4_,_loc3_);
               }
            };
            confirm = LanguageMgr.GetTranslation("public.confirm");
            cancel = LanguageMgr.GetTranslation("public.cancel");
            prompt = LanguageMgr.GetTranslation("public.prompt");
            point = TempleteManager.instance.getConfigInfoByConfigName("Consortia_ClearCD_Point").ConfigValue;
            content = LanguageMgr.GetTranslation("Consortia.ConsortiaSocketOutManager.content",point);
            SimpleAlertHelper.instance.data = [alertHandler];
            SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,true,true);
         }
         else
         {
            pkg = new PackageOut(5135);
            msg = new ConsortiaMsg();
            msg.consortiaId = $id;
            msg.isPay = false;
            sendProtoBuffer(pkg,msg);
         }
      }
      
      public static function applyJoinConsortia(param1:int) : void
      {
         if(checkApply(param1))
         {
            return;
         }
         applyJoinConsortiaSend(param1);
      }
      
      private static function checkApply(param1:int) : Boolean
      {
         var _loc2_:String = "";
         var _loc4_:ConsortiaModel = ConsortiaManager.instance.model;
         for each(var _loc3_:ConsortiaInviteInfo in _loc4_.applyList)
         {
            if(_loc3_.consortiaId == param1)
            {
               _loc2_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command02");
               MessageTipManager.instance().show(_loc2_);
               return true;
            }
         }
         if(thane.grades < 12)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command03",12);
            MessageTipManager.instance().show(_loc2_);
            return true;
         }
         if(_loc4_.applyList.length >= 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command04");
            MessageTipManager.instance().show(_loc2_);
            return true;
         }
         return false;
      }
      
      public static function sendOpenTreasure(param1:int = -1, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(9629);
         var _loc4_:ConsortiaTreasureOpMsg = new ConsortiaTreasureOpMsg();
         _loc4_.op = param1;
         _loc4_.payType = param2;
         _loc4_.treasureId = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}


package yishi.utils
{
   import com.road.yishi.proto.mail.MailInfoMsg;
   import manager.LanguageMgr;
   import mvc.module.emailII.EmailInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.view.tips.MessageTipManager;
   
   public class EmailHelp
   {
      
      public static var BagNewCount:int;
      
      public function EmailHelp()
      {
         super();
      }
      
      public static function checkCanGetGoods() : int
      {
         var _loc1_:String = null;
         BagNewCount = GoodsManager.instance.findNullCount();
         if(!BagNewCount)
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.help.EmailHelp.command01");
            MessageTipManager.instance().show(_loc1_);
            return -1;
         }
         return BagNewCount;
      }
      
      public static function checkCanGetStart() : int
      {
         var _loc1_:String = null;
         var _loc3_:int = int(StarManager.instance.getStarListByBagType(1).getList().length);
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.starBagCount;
         var _loc4_:int = 12 + _loc2_ - _loc3_;
         if(!_loc4_)
         {
            _loc1_ = LanguageMgr.GetTranslation("emailII.help.EmailHelp.command02");
            MessageTipManager.instance().show(_loc1_);
            return -1;
         }
         return _loc4_;
      }
      
      public static function transferToMailInfo(param1:MailInfoMsg) : EmailInfo
      {
         var _loc2_:EmailInfo = new EmailInfo();
         _loc2_.Id = param1.id;
         _loc2_.MailType = param1.mailType;
         _loc2_.SendId = param1.sendId;
         _loc2_.SendNickName = param1.sendNickName;
         _loc2_.SendPlayerGrade = param1.sendPlayerGrades;
         _loc2_.ReceiveId = param1.receiveId;
         _loc2_.ReceiveNickName = param1.receiveNickName;
         _loc2_.SendDate = param1.sendDate;
         _loc2_.ReadDate = param1.readDate;
         _loc2_.Title = param1.title;
         _loc2_.Contents = param1.contents;
         _loc2_.RemoveDate = param1.removeDate;
         _loc2_.ValidityDate = param1.validityDate;
         _loc2_.Annex1 = param1.annex1;
         _loc2_.Annex1Name = param1.annex1Name;
         _loc2_.Annex1Count = param1.annex1Count;
         _loc2_.IsAnnex1 = param1.isAnnex1;
         _loc2_.Annex2 = param1.annex2;
         _loc2_.Annex2Name = param1.annex2Name;
         _loc2_.Annex2Count = param1.annex2Count;
         _loc2_.IsAnnex2 = param1.isAnnex2;
         _loc2_.Annex3 = param1.annex3;
         _loc2_.Annex3Name = param1.annex3Name;
         _loc2_.Annex3Count = param1.annex3Count;
         _loc2_.IsAnnex3 = param1.isAnnex3;
         _loc2_.Annex4 = param1.annex4;
         _loc2_.Annex4Name = param1.annex4Name;
         _loc2_.Annex4Count = param1.annex4Count;
         _loc2_.IsAnnex4 = param1.isAnnex4;
         _loc2_.Annex5 = param1.annex5;
         _loc2_.Annex5Name = param1.annex5Name;
         _loc2_.Annex5Count = param1.annex5Count;
         _loc2_.IsAnnex5 = param1.isAnnex5;
         _loc2_.IsExist = param1.isExist;
         return _loc2_;
      }
   }
}


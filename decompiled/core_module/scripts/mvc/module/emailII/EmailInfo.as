package mvc.module.emailII
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.EmailManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.BattleReportHelp;
   import yishi.utils.DateFormatter;
   
   public class EmailInfo extends EventDispatcher
   {
      
      public var Id:int;
      
      public var MailType:int;
      
      public var SendId:int;
      
      public var SendType:int;
      
      public var SendNickName:String;
      
      public var SendPlayerGrade:int;
      
      public var ReceiveId:int;
      
      public var ReceiveNickName:String;
      
      public var SendDate:String;
      
      public var ReadDate:String;
      
      public var Title:String;
      
      public var Contents:String;
      
      public var RemoveDate:String;
      
      public var ValidityDate:int;
      
      public var Annex1:int;
      
      public var Annex1Name:int;
      
      public var Annex1Count:int;
      
      public var IsAnnex1:Boolean;
      
      public var Annex2:int;
      
      public var Annex2Name:int;
      
      public var Annex2Count:int;
      
      public var IsAnnex2:Boolean;
      
      public var Annex3:int;
      
      public var Annex3Name:int;
      
      public var Annex3Count:int;
      
      public var IsAnnex3:Boolean;
      
      public var Annex4:int;
      
      public var Annex4Name:int;
      
      public var Annex4Count:int;
      
      public var IsAnnex4:Boolean;
      
      public var Annex5:int;
      
      public var Annex5Name:int;
      
      public var Annex5Count:int;
      
      public var IsAnnex5:Boolean;
      
      public var IsExist:Boolean;
      
      public var report:BattleInfo;
      
      private var _goodsList:Dictionary;
      
      private var _starList:Dictionary;
      
      private var _sendDate:Date;
      
      private var _readDate:Date;
      
      private var _removeDate:Date;
      
      public function EmailInfo()
      {
         super();
         _goodsList = new Dictionary();
         _starList = new Dictionary();
      }
      
      public function get isRead() : Boolean
      {
         if(readDate.fullYear == 2999)
         {
            return false;
         }
         return true;
      }
      
      public function get hasGoods() : Boolean
      {
         return getFirstGoods() != 0;
      }
      
      public function getFirstGoods() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            if(!this["IsAnnex" + _loc1_] && this["Annex" + _loc1_] != 0)
            {
               return this["Annex" + _loc1_ + "Name"];
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function synchronization(param1:EmailInfo) : void
      {
         ObjectUtils.copyProperties(this,param1,false);
         if(param1.MailType == 3)
         {
            param1.report = BattleReportHelp.covertToBattleInfo(param1.Contents);
         }
      }
      
      public function get goodsList() : Dictionary
      {
         return _goodsList;
      }
      
      public function getFirstGoodsIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            if(!this["IsAnnex" + _loc1_] && this["Annex" + _loc1_] != 0)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getFirstGoodsInfo() : GoodsInfo
      {
         var _loc1_:int = getFirstGoodsIndex();
         if(_loc1_ != -1)
         {
            return getAnnexByIndex(_loc1_);
         }
         return null;
      }
      
      public function getFirstStarInfo() : StarInfo
      {
         var _loc1_:int = getFirstGoodsIndex();
         if(_loc1_ != -1)
         {
            return getAnnexStarByIndex(_loc1_);
         }
         return null;
      }
      
      public function getAnnexByIndex(param1:int) : GoodsInfo
      {
         var _loc2_:GoodsInfo = null;
         if(this["Annex" + param1] > 0)
         {
            return EmailManager.instance.cate.annexGoodsList[this["Annex" + param1]];
         }
         _loc2_ = new GoodsInfo();
         _loc2_.templateId = int(this["Annex" + param1 + "Name"]);
         _loc2_.id = param1;
         _loc2_.count = this["Annex" + param1 + "Count"];
         return _loc2_;
      }
      
      public function getAnnexStarByIndex(param1:int) : StarInfo
      {
         return EmailManager.instance.cate.annexStarList[this["Annex" + param1]];
      }
      
      public function getUngetAnnexId() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            if(!this["IsAnnex" + _loc1_] && this["Annex" + _loc1_] != 0)
            {
               return this["Annex" + _loc1_];
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function get leftTime() : String
      {
         var _loc2_:String = null;
         var _loc1_:Number = NaN;
         _loc1_ = remainTime();
         if(_loc1_ >= 24)
         {
            _loc2_ = String(Math.round(_loc1_ / 24)) + LanguageMgr.GetTranslation("public.day");
         }
         else if(_loc1_ > 0 && _loc1_ < 24)
         {
            _loc2_ = String(Math.round(_loc1_)) + LanguageMgr.GetTranslation("public.time.hour");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.data.EmailInfo.leftTime.timeOut");
         }
         return _loc2_;
      }
      
      public function remainTime() : Number
      {
         var _loc1_:Number = NaN;
         if(isRead)
         {
            _loc1_ = ValidityDate * 24 - (nowDate - readDate.time) / 3600000;
         }
         else
         {
            _loc1_ = ValidityDate * 24 - (nowDate - sendDate.time) / 3600000;
         }
         if(_loc1_ < 0)
         {
            return -1;
         }
         return _loc1_;
      }
      
      private function get nowDate() : Number
      {
         return PlayerManager.instance.currentPlayerModel.nowDate;
      }
      
      public function get removeDate() : Date
      {
         return DateFormatter.parse(RemoveDate,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function get readDate() : Date
      {
         return DateFormatter.parse(ReadDate,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function get sendDate() : Date
      {
         return DateFormatter.parse(SendDate,"YYYY-MM-DD hh:mm:ss");
      }
   }
}


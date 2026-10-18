package yishi.manager
{
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.mail.MailInfoMsg;
   import com.road.yishi.proto.mail.MailMsg;
   import com.road.yishi.proto.mail.MailPickupRspMsg;
   import com.road.yishi.proto.mail.PickupResult;
   import com.road.yishi.proto.mail.ReceiveMailMsg;
   import events.EmailEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.emailII.EmailCategory;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.star.StarInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.resolve.EmailInfoResolve;
   import yishi.resolve.EmainAnnexResolve;
   import yishi.resolve.EmainAnnexStarResolve;
   import yishi.service.managers.SocketManager;
   import yishi.utils.EmailHelp;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class EmailManager extends EventDispatcher
   {
      
      private static var _instance:EmailManager;
      
      private var _userId:int;
      
      private var _key:String;
      
      public var _startNew:Boolean;
      
      private var _model:EmailCategory;
      
      public function EmailManager()
      {
         super();
         _userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _key = PlayerManager.instance.currentPlayerModel.userInfo.key;
         _model = new EmailCategory();
         addEvent();
      }
      
      public static function get instance() : EmailManager
      {
         if(!_instance)
         {
            _instance = new EmailManager();
         }
         return _instance;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 148,__newMail);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 114,__attachedHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4131,__attachedMailListUpdate);
      }
      
      public function setup() : void
      {
         getMailList();
      }
      
      public function getMailList(param1:String = "0", param2:int = 0) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["userId"] = _userId;
         _loc3_["mailId"] = param1;
         _loc3_["reqType"] = param2;
         _loc3_["key"] = _key;
         _loc3_["rnd"] = Math.random();
         var _loc5_:String = PathManager.info.REQUEST_PATH + "maillist";
         var _loc6_:URLLoader = new URLLoader();
         _loc6_.dataFormat = "binary";
         _loc6_.addEventListener("complete",__onGetMailComplete);
         _loc6_.addEventListener("ioError",__onGetMailComplete);
         var _loc4_:URLRequest = new URLRequest(_loc5_);
         _loc4_.method = "POST";
         _loc4_.data = _loc3_;
         _loc6_.load(_loc4_);
      }
      
      private function __onGetMailComplete(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:XML = null;
         var _loc4_:URLLoader = param1.currentTarget as URLLoader;
         _loc4_.removeEventListener("complete",__onGetMailComplete);
         _loc4_.removeEventListener("ioError",__onGetMailComplete);
         var _loc5_:ByteArray = _loc4_.data as ByteArray;
         if(_loc5_)
         {
            _loc5_.uncompress();
            _loc5_.position = 0;
            _loc3_ = _loc5_.readUTFBytes(_loc5_.bytesAvailable);
            _loc5_.clear();
         }
         if(_loc3_)
         {
            _loc2_ = new XML(_loc3_);
            new EmailInfoResolve(_loc2_..Info,mailResoveBack).imediatyly();
         }
      }
      
      private function mailResoveBack(param1:Dictionary) : void
      {
         EmailManager.instance.cate.setupMaill(param1);
         if(!_startNew)
         {
            dispatchEvent(new EmailEvent("EMAIL_CLOSE"));
            _startNew = true;
         }
      }
      
      public function getNewGoodMailAnnex(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["userId"] = _userId;
         _loc2_["itemId"] = param1;
         _loc2_["key"] = _key;
         _loc2_["rnd"] = Math.random();
         param1 = StringHelper.trimAll(param1);
         var _loc4_:String = PathManager.info.REQUEST_PATH + "itemlist";
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.dataFormat = "binary";
         _loc5_.addEventListener("complete",__onGetAnnexGoodComplete);
         var _loc3_:URLRequest = new URLRequest(_loc4_);
         _loc3_.method = "POST";
         _loc3_.data = _loc2_;
         _loc5_.load(_loc3_);
      }
      
      public function getNewSatrMailAnnex(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["userId"] = _userId;
         _loc2_["starId"] = param1;
         _loc2_["key"] = _key;
         _loc2_["rnd"] = Math.random();
         param1 = StringHelper.trimAll(param1);
         var _loc4_:String = PathManager.info.REQUEST_PATH + "starlist";
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.dataFormat = "binary";
         _loc5_.addEventListener("complete",__onGetAnnexStarComplete);
         var _loc3_:URLRequest = new URLRequest(_loc4_);
         _loc3_.method = "POST";
         _loc3_.data = _loc2_;
         _loc5_.load(_loc3_);
      }
      
      private function __onGetAnnexStarComplete(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:XML = null;
         var _loc4_:URLLoader = param1.currentTarget as URLLoader;
         _loc4_.removeEventListener("complete",__onGetAnnexStarComplete);
         var _loc5_:ByteArray = _loc4_.data as ByteArray;
         if(_loc5_)
         {
            _loc5_.uncompress();
            _loc5_.position = 0;
            _loc3_ = _loc5_.readUTFBytes(_loc5_.bytesAvailable);
            _loc5_.clear();
         }
         if(_loc3_)
         {
            _loc2_ = new XML(_loc3_);
            new EmainAnnexStarResolve(_loc2_..Info,mailAnnexStarResoveBack).imediatyly();
         }
      }
      
      private function mailAnnexStarResoveBack(param1:Dictionary) : void
      {
         for each(var _loc2_:StarInfo in param1)
         {
            cate.annexStarList[_loc2_.id] = _loc2_;
         }
         NotificationManager.instance.dispatchEvent(new EmailEvent("ANNEX_CALLBACK"));
      }
      
      private function __onGetAnnexGoodComplete(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:XML = null;
         var _loc4_:URLLoader = param1.currentTarget as URLLoader;
         _loc4_.removeEventListener("complete",__onGetAnnexGoodComplete);
         var _loc5_:ByteArray = _loc4_.data as ByteArray;
         if(_loc5_)
         {
            _loc5_.uncompress();
            _loc5_.position = 0;
            _loc3_ = _loc5_.readUTFBytes(_loc5_.bytesAvailable);
            _loc5_.clear();
         }
         if(_loc3_)
         {
            _loc2_ = new XML(_loc3_);
            new EmainAnnexResolve(_loc2_..Info,mailAnnexGoodResoveBack).imediatyly();
         }
      }
      
      private function mailAnnexGoodResoveBack(param1:Dictionary) : void
      {
         for each(var _loc2_:GoodsInfo in param1)
         {
            cate.annexGoodsList[_loc2_.id] = _loc2_;
         }
         NotificationManager.instance.dispatchEvent(new EmailEvent("ANNEX_CALLBACK"));
      }
      
      private function __attachedMailListUpdate(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:EmailInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ReceiveMailMsg = new ReceiveMailMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ReceiveMailMsg;
         var _loc5_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.mailInfos.length)
         {
            _loc4_ = EmailHelp.transferToMailInfo(_loc2_.mailInfos[_loc3_] as MailInfoMsg);
            _model.updateEmail(_loc4_);
            _model.refreshAnnex(_loc4_);
            _loc5_.push(_loc4_.Id);
            _loc3_++;
         }
         dispatchEvent(new EmailEvent("DATA_EMAIL_UPDATE",null,_loc5_));
      }
      
      private function __attachedHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:EmailInfo = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:MailPickupRspMsg = new MailPickupRspMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as MailPickupRspMsg;
         var _loc3_:String = "";
         _loc7_ = 0;
         while(_loc7_ < _loc2_.pickupResult.length)
         {
            _loc8_ = int(PickupResult(_loc2_.pickupResult[_loc7_]).mailId);
            _loc4_ = Boolean(PickupResult(_loc2_.pickupResult[_loc7_]).result);
            if(!_loc4_)
            {
               _loc6_ = true;
               _loc5_ = _model.getEmailById(_loc8_);
               if(_loc5_ && _loc5_.hasGoods)
               {
                  if(_loc5_.MailType == 4)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("yishi.manager.EmailManager.command02");
                     MessageTipManager.instance().show(_loc3_);
                  }
                  if(_loc5_.MailType == 5)
                  {
                     return;
                  }
                  _loc3_ = LanguageMgr.GetTranslation("yishi.manager.EmailManager.command03");
                  MessageTipManager.instance().show(_loc3_);
                  return;
               }
            }
            _loc7_++;
         }
         if(_loc6_)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.EmailManager.command04");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __newMail(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MailMsg = new MailMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MailMsg;
         var _loc6_:int = _loc2_.playerId;
         var _loc4_:int = _loc2_.mailId;
         dispatchEvent(new EmailEvent("DATA_EMAIL_NEW"));
         SoundManager.instance.play("014");
         cate.totalLength++;
         if(cate.totalLength > 300)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.EmailManager.command01");
            MessageTipManager.instance().show(_loc3_);
            cate.unLoadList.push(_loc4_);
            return;
         }
         getMailList(_loc4_.toString());
      }
      
      public function removeEmail(param1:Array) : void
      {
         var _loc2_:int = 0;
         for each(var _loc3_:int in param1)
         {
            _model.removeEmail(_loc3_);
         }
         if(cate.unLoadList.length > 0)
         {
            _loc2_ = int(cate.unLoadList.length > param1.length ? param1.length : cate.unLoadList.length);
            getMailList((cate.unLoadList.splice(0,_loc2_) as Array).join(","));
         }
         dispatchEvent(new EmailEvent("DATA_EMAIL_DELETE",null,param1));
      }
      
      public function updateInfo(param1:Object) : void
      {
         _model.updateEmail(param1 as EmailInfo);
         dispatchEvent(new EmailEvent("DATA_EMAIL_UPDATE",null,[param1.Id]));
      }
      
      public function getEmailById(param1:int) : EmailInfo
      {
         var _loc2_:* = null;
         for each(_loc2_ in mailList)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in reportList)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getListByType(param1:int) : Array
      {
         if(param1 == 3)
         {
            return reportList;
         }
         if(param1 == 1)
         {
            return mailList;
         }
         return [];
      }
      
      public function existMail() : Boolean
      {
         if(mailList.length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function existBattle() : Boolean
      {
         if(reportList.length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function existUnreadMail() : Boolean
      {
         for each(var _loc1_:EmailInfo in mailList)
         {
            if(!_loc1_.isRead)
            {
               return true;
            }
         }
         return false;
      }
      
      public function existUnreadReport() : Boolean
      {
         for each(var _loc1_:EmailInfo in reportList)
         {
            if(!_loc1_.isRead)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get mailList() : Array
      {
         return _model.allMailList;
      }
      
      public function get reportList() : Array
      {
         return _model.allBattleList;
      }
      
      public function get cate() : EmailCategory
      {
         return _model;
      }
   }
}


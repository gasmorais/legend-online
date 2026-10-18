package mvc.module.emailII
{
   import events.EmailEvent;
   import flash.utils.Dictionary;
   import yishi.manager.EmailManager;
   import yishi.utils.BattleReportHelp;
   import yishi.utils.SimpleDictionary;
   
   public class EmailCategory
   {
      
      public var allMailList:Array;
      
      public var allBattleList:Array;
      
      public var bufferNewMailList:Array;
      
      public var annexGoodsList:SimpleDictionary;
      
      public var annexStarList:SimpleDictionary;
      
      public var annexIdList:String;
      
      public var totalLength:int;
      
      public var unLoadList:Array;
      
      private var start:Boolean;
      
      public function EmailCategory()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         allMailList = [];
         allBattleList = [];
         bufferNewMailList = [];
         unLoadList = [];
         annexGoodsList = new SimpleDictionary();
         annexStarList = new SimpleDictionary();
      }
      
      public function setupMaill(param1:Dictionary) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:String = "";
         var _loc6_:String = "";
         for each(var _loc2_:EmailInfo in param1)
         {
            annexIdList = "";
            if(!_loc2_.isRead && !start)
            {
               EmailManager.instance.dispatchEvent(new EmailEvent("EMAIL_STARTREAD"));
               start = true;
            }
            if(!_loc2_.isRead && (allBattleList.length + allMailList.length >= 300 && totalLength > 300))
            {
               unLoadList.push(_loc2_.Id);
            }
            else if(_loc2_.remainTime() > 0)
            {
               if(!EmailManager.instance._startNew)
               {
                  totalLength = totalLength + 1;
               }
               addMailNew(_loc2_);
               if(_loc2_.MailType == 4)
               {
                  if(_loc2_.hasGoods)
                  {
                     _loc4_ = 1;
                     while(_loc4_ <= 5)
                     {
                        _loc5_ = int(_loc2_["Annex" + _loc4_]);
                        if(_loc5_ > 0 && !annexStarList.hasOwnProperty(_loc5_))
                        {
                           _loc3_ += _loc5_ + ",";
                        }
                        _loc4_++;
                     }
                  }
               }
               else if(_loc2_.hasGoods)
               {
                  _loc4_ = 1;
                  while(_loc4_ <= 5)
                  {
                     _loc5_ = int(_loc2_["Annex" + _loc4_]);
                     if(_loc5_ > 0 && !annexGoodsList.hasOwnProperty(_loc5_))
                     {
                        _loc6_ += _loc5_ + ",";
                     }
                     _loc4_++;
                  }
               }
            }
         }
         _loc3_ = _loc3_.slice(0,_loc3_.lastIndexOf(","));
         EmailManager.instance.getNewSatrMailAnnex(_loc3_);
         _loc6_ = _loc6_.slice(0,_loc6_.lastIndexOf(","));
         EmailManager.instance.getNewGoodMailAnnex(_loc6_);
      }
      
      public function refreshMail() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(bufferNewMailList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            addMailNew(bufferNewMailList.pop() as EmailInfo);
            _loc2_++;
         }
      }
      
      public function addMailNew(param1:EmailInfo) : void
      {
         if(param1.MailType == 3)
         {
            if(isBattleExist(param1))
            {
               EmailManager.instance.updateInfo(param1);
               return;
            }
            addBattleReport(param1);
         }
         else
         {
            if(isMailExist(param1))
            {
               EmailManager.instance.updateInfo(param1);
               return;
            }
            allMailList.unshift(param1);
         }
      }
      
      private function isMailExist(param1:EmailInfo) : Boolean
      {
         var _loc2_:* = null;
         for each(_loc2_ in allMailList)
         {
            if(_loc2_.Id == param1.Id)
            {
               return true;
            }
         }
         for each(_loc2_ in allBattleList)
         {
            if(_loc2_.Id == param1.Id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addBattleReport(param1:EmailInfo) : void
      {
         param1.report = BattleReportHelp.covertToBattleInfo(param1.Contents);
         addBattle(param1);
      }
      
      public function addBattle(param1:EmailInfo) : void
      {
         allBattleList.unshift(param1);
      }
      
      private function isBattleExist(param1:EmailInfo) : Boolean
      {
         for each(var _loc2_:EmailInfo in allBattleList)
         {
            if(_loc2_.Id == param1.Id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateEmail(param1:EmailInfo) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in allMailList)
         {
            if(param1.Id == _loc2_.Id)
            {
               _loc2_.synchronization(param1);
               return;
            }
         }
         for each(_loc2_ in allBattleList)
         {
            if(param1.Id == _loc2_.Id)
            {
               _loc2_.synchronization(param1);
            }
         }
      }
      
      public function removeEmail(param1:int) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in allMailList)
         {
            if(_loc2_.Id == param1)
            {
               allMailList.splice(allMailList.indexOf(_loc2_),1);
               totalLength = totalLength - 1;
               return;
            }
         }
         for each(_loc2_ in allBattleList)
         {
            if(_loc2_.Id == param1)
            {
               totalLength = totalLength - 1;
               allBattleList.splice(allBattleList.indexOf(_loc2_),1);
               return;
            }
         }
      }
      
      public function getEmailById(param1:int) : EmailInfo
      {
         var _loc2_:* = null;
         for each(_loc2_ in allMailList)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in allBattleList)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function sortMailList() : void
      {
         allMailList.sort(sortMail);
         allBattleList.sort(sortMail);
      }
      
      private function sortMail(param1:EmailInfo, param2:EmailInfo) : int
      {
         if(!param1.isRead && param2.isRead)
         {
            return -1;
         }
         if(param1.isRead && !param2.isRead)
         {
            return 1;
         }
         if(!param1.isRead && !param2.isRead)
         {
            if(param1.sendDate >= param2.sendDate)
            {
               return -1;
            }
            return 1;
         }
         if(param1.hasGoods && !param2.hasGoods)
         {
            return -1;
         }
         if(!param1.hasGoods && param2.hasGoods)
         {
            return 1;
         }
         if(param1.sendDate >= param2.sendDate)
         {
            return -1;
         }
         return 1;
      }
      
      public function refreshAnnex(param1:EmailInfo) : void
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param1.MailType == 4)
         {
            _loc2_ = 1;
            while(_loc2_ <= 5)
            {
               if(param1["IsAnnex" + _loc2_] && annexStarList.hasOwnProperty(param1["Annex" + _loc2_]))
               {
                  delete annexStarList[param1["Annex" + _loc2_]];
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ <= 5)
            {
               if(param1["IsAnnex" + _loc2_] && annexGoodsList.hasOwnProperty(param1["Annex" + _loc2_]))
               {
                  delete annexGoodsList[param1["Annex" + _loc2_]];
               }
               _loc2_++;
            }
         }
      }
   }
}


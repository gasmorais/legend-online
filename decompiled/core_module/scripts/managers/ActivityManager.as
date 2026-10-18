package managers
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.active.ActiveInfoMsg;
   import com.road.yishi.proto.active.ActiveRspMsg;
   import com.road.yishi.proto.active.QueryActiveMsg;
   import flash.events.ErrorEvent;
   import flash.net.URLVariables;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import mvc.module.funny.ActiveInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ActivityManager
   {
      
      private static var _instance:ActivityManager;
      
      private var _activityList:Array = [];
      
      public function ActivityManager()
      {
         super();
      }
      
      public static function get Instance() : ActivityManager
      {
         if(!_instance)
         {
            _instance = new ActivityManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4251,__activityHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 166,__returnActiveStatusHandler);
      }
      
      private function __activityHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc7_:ActiveInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActiveRspMsg = new ActiveRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ActiveRspMsg;
         var _loc3_:Array = _loc2_.activeRspInfo;
         var _loc4_:int = int(_loc3_.length);
         _activityList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new ActiveInfo();
            _loc7_.endDate = DateFormatter.parse(_loc3_[_loc5_].endDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc7_.startDate = DateFormatter.parse(_loc3_[_loc5_].startDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc7_.sort = _loc3_[_loc5_].sort;
            _loc7_.title = _loc3_[_loc5_].title;
            _loc7_.grades = _loc3_[_loc5_].grades;
            _loc7_.activeId = _loc3_[_loc5_].activeId;
            _loc7_.contents = _loc3_[_loc5_].contents;
            _loc7_.consortia = _loc3_[_loc5_].consortia;
            _loc7_.description = _loc3_[_loc5_].description;
            _loc7_.awardContent = _loc3_[_loc5_].awardContent;
            _loc7_.actionTimeContent = _loc3_[_loc5_].actionTimeContent;
            _loc7_.hasKey = _loc3_[_loc5_].hasKey;
            if(_loc3_[_loc5_].title.indexOf("兑换") >= 0)
            {
            }
            _activityList.push(_loc7_);
            _loc5_++;
         }
         _activityList.sortOn("sort",16);
         FunnyManager.instance.model.setActivityBtnState();
      }
      
      private function __returnActiveStatusHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:ActiveInfoMsg = null;
         var _loc7_:int = 0;
         var _loc9_:ActiveInfo = null;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:QueryActiveMsg = new QueryActiveMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as QueryActiveMsg;
         var _loc8_:Array = activityList;
         var _loc4_:int = int(_loc8_.length);
         var _loc5_:Array = _loc2_.actives;
         var _loc11_:int = int(_loc5_.length);
         if(_loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc11_)
            {
               _loc3_ = _loc5_[_loc6_] as ActiveInfoMsg;
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc9_ = _loc8_[_loc7_] as ActiveInfo;
                  if(_loc9_ && _loc3_ && _loc9_.activeId == _loc3_.activeId)
                  {
                     _loc9_.status = _loc3_.state;
                     _loc8_[_loc7_] = _loc9_;
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            _activityList = _loc8_;
         }
         FunnyManager.instance.dispatchEvent(new FunnyEvent("REFRESH_ITEM"));
      }
      
      private function __onLoadError(param1:LoaderInfo, param2:Object) : void
      {
         throw new ErrorEvent(LanguageMgr.GetTranslation("loader.LoadError.Actionmsg"));
      }
      
      private function __onEventComplete(param1:LoaderInfo, param2:Object) : void
      {
         returnResult(String(param2).split("|"));
      }
      
      private function returnResult(param1:Array) : void
      {
         var _loc2_:String = "";
         if(param1[0] == "-1")
         {
            switch(param1[param1.length - 1])
            {
               case "0":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command01");
                  break;
               case "1":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
                  break;
               case "5":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command03");
                  break;
               case "6":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command04");
                  break;
               case "7":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command05");
                  break;
               case "8":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command06");
                  break;
               case "10":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command07");
                  break;
               case "11":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command08");
            }
         }
         else
         {
            switch(param1[param1.length - 1])
            {
               case "0":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command01");
                  break;
               case "2":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command10");
                  break;
               case "1":
               case "3":
               case "4":
               case "5":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command09");
                  break;
               case "6":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command04");
                  break;
               case "7":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command05");
                  break;
               case "8":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command06");
                  break;
               case "10":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command07");
                  break;
               case "11":
               case "12":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command08");
                  break;
               case "15":
                  _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command15");
            }
         }
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function get activityList() : Array
      {
         var _loc3_:Array = _activityList;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].endDate <= playerModel.sysCurTimeBySecond)
            {
               _loc3_.splice(_loc2_,1);
            }
            else if(_loc3_[_loc2_].startDate > playerModel.sysCurTimeBySecond)
            {
               _loc2_++;
            }
            else
            {
               _loc1_.push(_loc3_[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function senActivityCode(param1:String, param2:String) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["userId"] = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         _loc3_["key"] = PlayerManager.instance.currentPlayerModel.userInfo.key;
         _loc3_["activeId"] = param2;
         _loc3_["number"] = param1;
         _loc3_["rnd"] = Math.random();
         var _loc4_:String = PathManager.info.REQUEST_PATH + "activecheck";
         LoaderManagerII.instance.load(_loc4_,7,8,__onEventComplete,null,__onLoadError,null,_loc3_);
      }
      
      public function senActivityCodeServlet(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["userId"] = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         _loc2_["key"] = PlayerManager.instance.currentPlayerModel.userInfo.key;
         _loc2_["number"] = param1;
         _loc2_["rnd"] = Math.random();
         var _loc3_:String = PathManager.info.REQUEST_PATH + "activecodeservlet";
         LoaderManagerII.instance.load(_loc3_,7,8,__onEventComplete,null,__onLoadError,null,_loc2_);
      }
   }
}


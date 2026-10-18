package mvc.module.star
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.StarManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StarModel extends EventDispatcher
   {
      
      public static const PICK_UP:int = 1;
      
      public static const SELL:int = 2;
      
      public static const COMPOSE:int = 3;
      
      private var _randomStarName:Array = [LanguageMgr.GetTranslation("star.view.MakeStarView.greenCrystal.name"),LanguageMgr.GetTranslation("star.view.MakeStarView.whiteCrystal.name"),LanguageMgr.GetTranslation("star.view.MakeStarView.yellowCrystal.name"),LanguageMgr.GetTranslation("star.view.MakeStarView.redCrystal.name"),LanguageMgr.GetTranslation("star.view.MakeStarView.blueCrystal.name")];
      
      public var delWay:int;
      
      public var openCrystal:int;
      
      public var preIndex:int = 0;
      
      public var starTroughs:Vector.<StarTroughInfo>;
      
      private var _autoGoldType:int = 1;
      
      private var _autoSellType:int = 1;
      
      private var _autoComposeType:int = 1;
      
      public function StarModel(param1:IEventDispatcher = null)
      {
         var _loc3_:int = 0;
         var _loc2_:StarTroughInfo = null;
         super(param1);
         starTroughs = new Vector.<StarTroughInfo>();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = new StarTroughInfo();
            _loc2_.gp = 0;
            _loc2_.grade = 0;
            _loc2_.pos = _loc3_;
            _loc2_.type = 0;
            if(_loc3_ > 7)
            {
               _loc2_.type = 1;
            }
            starTroughs.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function get starQuickSellType() : int
      {
         return SharedManager.instance.starQuickSellType;
      }
      
      public function set starQuickSellType(param1:int) : void
      {
         if(SharedManager.instance.starQuickSellType == param1)
         {
            return;
         }
         SharedManager.instance.starQuickSellType = param1;
         SharedManager.instance.save();
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      public function getStarPow() : int
      {
         var _loc2_:int = 0;
         var _loc1_:SimpleDictionary = starManager.getStarListByBagType(2);
         for each(var _loc3_:StarInfo in _loc1_)
         {
            _loc2_ += StarHelper.getStarTotalExp(_loc3_);
         }
         _loc2_ /= 10;
         return int(_loc2_ * (1 + getAvgTroughLv() / 100));
      }
      
      public function getAvgTroughLv() : Number
      {
         var _loc1_:StarTroughInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = starTroughs[_loc2_] as StarTroughInfo;
            _loc3_ += _loc1_.grade;
            _loc2_++;
         }
         return _loc3_ / 8;
      }
      
      public function getNameByIndex(param1:int) : String
      {
         return _randomStarName[param1].toString();
      }
      
      public function quickPickupClick() : void
      {
         if(checkAction(1))
         {
            delWay = 1;
            starManager.sendStarPick(-2);
         }
      }
      
      public function checkAction(param1:int, param2:int = 0) : Boolean
      {
         var _loc7_:int = 0;
         var _loc3_:SimpleDictionary = starManager.tempStarList;
         var _loc5_:int = int(_loc3_.getList().length);
         var _loc4_:String = "";
         if(_loc5_ <= 0)
         {
            if(FrameControllerManager.instance.starController.hasStarFrmae)
            {
               _loc4_ = LanguageMgr.GetTranslation("star.view.DisplayStarView.command02");
               MessageTipManager.instance().show(_loc4_);
            }
            return false;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc7_ = int(starManager.getStarListByBagType(1).getList().length);
               if(_loc7_ + currentStarNum > 12 + playerInfo.starBagCount)
               {
                  if(FrameControllerManager.instance.starController.hasStarFrmae || currentStarNum > 0)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("star.view.DisplayStarView.command03");
                     MessageTipManager.instance().show(_loc4_);
                  }
               }
               if(_loc7_ >= 12 + playerInfo.starBagCount)
               {
                  if(FrameControllerManager.instance.starController.hasStarFrmae || currentStarNum > 0)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("star.view.DisplayStarView.command03");
                     MessageTipManager.instance().show(_loc4_);
                  }
                  return false;
               }
               for each(var _loc6_:StarInfo in _loc3_)
               {
                  if(_loc6_.template.Profile > 1)
                  {
                     return true;
                  }
               }
               if(FrameControllerManager.instance.starController.hasStarFrmae)
               {
                  _loc4_ = LanguageMgr.GetTranslation("star.view.DisplayStarView.command04");
                  MessageTipManager.instance().show(_loc4_);
               }
               return false;
               break;
            case 1:
               for each(var _loc8_:StarInfo in _loc3_)
               {
                  if(_loc8_.template.Profile <= param2 && _loc8_.grade == 1 && _loc8_.gp == 0)
                  {
                     return true;
                  }
               }
               _loc4_ = LanguageMgr.GetTranslation("star.view.DisplayStarView.command05");
               MessageTipManager.instance().show(_loc4_);
               return false;
            default:
               return false;
         }
      }
      
      private function get currentStarNum() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:StarInfo in starManager.tempStarList)
         {
            if(_loc1_.template.Profile > 1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get autoGoldType() : int
      {
         return _autoGoldType;
      }
      
      public function set autoGoldType(param1:int) : void
      {
         if(_autoGoldType == param1)
         {
            return;
         }
         _autoGoldType = param1;
      }
      
      public function get autoSellType() : int
      {
         return _autoSellType;
      }
      
      public function set autoSellType(param1:int) : void
      {
         if(_autoSellType == param1)
         {
            return;
         }
         _autoSellType = param1;
      }
      
      public function get autoComposeType() : int
      {
         return _autoComposeType;
      }
      
      public function set autoComposeType(param1:int) : void
      {
         if(_autoComposeType == param1)
         {
            return;
         }
         _autoComposeType = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}


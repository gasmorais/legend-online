package mvc.module.marry
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.road.yishi.proto.reward.RewardInfo;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class MarryTask implements INotSameHeightListCellData
   {
      
      public var TemplateType:int = -3;
      
      public var hasCompleted:Boolean = false;
      
      public var isNew:Boolean;
      
      public var Sort:int = 0;
      
      public var sortFlag:Boolean;
      
      private var _marryTaskTemp:OfferRewardTemplate;
      
      private var _currTask:RewardInfo;
      
      private var _changeDate:Number;
      
      private var _index:int = 0;
      
      public function MarryTask()
      {
         super();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index != param1)
         {
            _index = param1;
            commit();
         }
      }
      
      public function get changeDate() : Number
      {
         return _changeDate;
      }
      
      public function set changeDate(param1:Number) : void
      {
         _changeDate = param1;
      }
      
      public function get currTask() : RewardInfo
      {
         return _currTask;
      }
      
      public function set currTask(param1:RewardInfo) : void
      {
         _currTask = param1;
      }
      
      public function get marryTaskTemp() : OfferRewardTemplate
      {
         return _marryTaskTemp;
      }
      
      public function set marryTaskTemp(param1:OfferRewardTemplate) : void
      {
         _marryTaskTemp = param1;
      }
      
      public function get Title() : String
      {
         return LanguageMgr.GetTranslation("mvc.module.marry.MarryTask.titleAppend",_index);
      }
      
      public function get conditionList() : Array
      {
         return marryTaskTemp.conditionList;
      }
      
      public function get rewardList() : Array
      {
         return marryTaskTemp.rewardItemList;
      }
      
      public function getProgress() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc2_:OfferRewardConditionTemplate = null;
         var _loc5_:Array = [];
         var _loc3_:int = int(marryTaskTemp.conditionList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = marryTaskTemp.conditionList[_loc4_];
            switch(_loc2_.CondictionType - 16)
            {
               case 0:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 6:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 7:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               default:
                  _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
            }
            _loc5_[_loc4_] = _loc1_;
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function checkCount(param1:OfferRewardConditionTemplate, param2:int) : String
      {
         if(currTask)
         {
            if(currTask["condition_" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + currTask["condition_" + (param2 + 1)] + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      public function get NeedFightId() : int
      {
         return marryTaskTemp.NeedFightId;
      }
      
      public function get isCompleted() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Array = getProgress();
         _loc2_ = 0;
         while(marryTaskTemp.conditionList[_loc2_] != null)
         {
            if(_loc1_[_loc2_] != LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress"))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function commit() : void
      {
         MsgMan.notifyObserver("MarryEventType.TASK_UPDATE");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function getCellHeight() : Number
      {
         if(isCompleted)
         {
            return 43;
         }
         return 36;
      }
   }
}


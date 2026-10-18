package consortia.view.myConsortia.newui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.item.ConsortiaActiveRewardItem;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaQuestInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.ConsortiaQuestConditionTempInfo;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ConsortiaActiveRewardView extends Component
   {
      
      private var _dayHbox:HBox;
      
      private var _weekHbox:HBox;
      
      private var dayList:Vector.<ConsortiaActiveRewardItem>;
      
      private var weekList:Vector.<ConsortiaActiveRewardItem>;
      
      private var _weekTxt:FilterFrameText;
      
      public function ConsortiaActiveRewardView()
      {
         super();
         initView();
         initListView();
         refreshView();
         addEvent();
      }
      
      private function initView() : void
      {
         _dayHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActiveRewardView.dayHbox");
         _weekHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActiveRewardView.weekHbox");
         _weekTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActiveRewardView.weekTxt");
         addChild(_dayHbox);
         addChild(_weekHbox);
         addChild(_weekTxt);
         _weekTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaActiveRewardView.weekTxt.text",0);
      }
      
      private function initListView() : void
      {
         var _loc1_:ConsortiaActiveRewardItem = null;
         var _loc2_:ConsortiaActiveRewardItem = null;
         dayList = new Vector.<ConsortiaActiveRewardItem>();
         var _loc3_:Array = getShowDataByType(1);
         for each(var _loc5_:ConsortiaQuestTempInfo in _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ConsortiaActiveRewardView.rewardItem",[1]);
            _loc1_.tempInfo = _loc5_;
            _dayHbox.addChild(_loc1_);
            dayList.push(_loc1_);
         }
         var _loc6_:Array = getShowDataByType(2);
         weekList = new Vector.<ConsortiaActiveRewardItem>();
         for each(var _loc4_:ConsortiaQuestTempInfo in _loc6_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ConsortiaActiveRewardView.rewardItem",[2]);
            _loc2_.tempInfo = _loc4_;
            _weekHbox.addChild(_loc2_);
            weekList.push(_loc2_);
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("UPDATE_QUEST_INFO",this,__updateQuestHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("UPDATE_QUEST_INFO",this,__updateQuestHandler);
      }
      
      private function __updateQuestHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc1_:ConsortiaActiveRewardItem = null;
         var _loc2_:ConsortiaActiveRewardItem = null;
         var _loc3_:ConsortiaQuestConditionTempInfo = null;
         var _loc5_:ConsortiaQuestInfo = null;
         var _loc4_:Array = getShowDataByType(1);
         var _loc8_:Array = getShowDataByType(2);
         _loc6_ = 0;
         while(_loc6_ < dayList.length)
         {
            _loc1_ = dayList[_loc6_];
            _loc1_.tempInfo = _loc4_[_loc6_];
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < weekList.length)
         {
            _loc2_ = weekList[_loc6_];
            _loc2_.tempInfo = _loc8_[_loc6_];
            _loc6_++;
         }
         var _loc7_:ConsortiaQuestTempInfo = _loc8_[_loc8_.length - 1];
         if(_loc7_)
         {
            _loc3_ = TempleteManager.instance.consortiaQuestConditionTempCate.getTemplateByID(_loc7_.TemplateId);
            if(_loc3_)
            {
               _loc5_ = model.getQuestInfoById(_loc3_.ConditionId);
               if(_loc5_)
               {
                  _weekTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaActiveRewardView.weekTxt.text",_loc5_.process);
               }
            }
         }
      }
      
      private function getShowDataByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = model.taskTempDic[1];
         for each(var _loc4_:ConsortiaQuestTempInfo in _loc3_)
         {
            if(_loc4_.ResetType == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn("Sort",16);
         return _loc2_;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dayHbox);
         _dayHbox = null;
         ObjectUtils.disposeObject(_weekHbox);
         _weekHbox = null;
         LogicUtils.disposeDisplayCollection(dayList);
         dayList = null;
         LogicUtils.disposeDisplayCollection(weekList);
         weekList = null;
         super.dispose();
      }
   }
}


package oldplayerreturn.task
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.base.ProgressPanel;
   
   public class OldPlayerReturnTaskView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _dayTxt:FilterFrameText;
      
      private var _dayNumTxt:FilterFrameText;
      
      private var _dayProgress:ProgressPanel;
      
      private var _weekTxt:FilterFrameText;
      
      private var _weekNumTxt:FilterFrameText;
      
      private var _weekProgress:ProgressPanel;
      
      private var _panel:HRollItemPanel;
      
      private var _itemList:Array = [];
      
      private var _dayBoxItems:Array = [];
      
      private var _weekBoxItems:Array = [];
      
      public function OldPlayerReturnTaskView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskView.bg");
         _dayTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.dayTxt");
         _dayNumTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.dayNumTxt");
         _dayProgress = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnTaskView.dayProgress");
         _weekTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.weekTxt");
         _weekNumTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.weekNumTxt");
         _weekProgress = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnTaskView.weekProgress");
         _panel = new HRollItemPanel();
         _panel.initParams("oldPlayerReturnTaskView.itemBoxs","oldPlayerReturnTaskView.leftBtn","oldPlayerReturnTaskView.rightBtn",3,175,320);
         addChild(_bg);
         addChild(_dayTxt);
         addChild(_dayNumTxt);
         addChild(_dayProgress);
         addChild(_weekTxt);
         addChild(_weekNumTxt);
         addChild(_weekProgress);
         addChild(_panel);
         _dayTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnTaskView.dayTxt.text");
         _weekTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnTaskView.weekTxt.text");
         _dayProgress.initView("oldPlayerReturnTaskView.dayBack","oldPlayerReturnTaskView.dayBar","");
         _dayProgress.barPosxy(0,0);
         _weekProgress.initView("oldPlayerReturnTaskView.weekBack","oldPlayerReturnTaskView.weekBar","");
         _weekProgress.barPosxy(19,2);
         initDayBoxItems();
         initWeekBoxItems();
      }
      
      private function refreshTaskItems() : void
      {
         var _loc1_:OldPlayerReturnTaskItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(model.returnList.length);
         _itemList = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new OldPlayerReturnTaskItem();
            _loc1_.data = model.returnList[_loc3_];
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _panel.updateList(_itemList);
      }
      
      private function initDayBoxItems() : void
      {
         var _loc1_:OldPlayerReturnTaskBoxItem = null;
         var _loc2_:int = 0;
         _dayBoxItems = [];
         _loc2_ = 0;
         while(_loc2_ < dayCount)
         {
            _loc1_ = new OldPlayerReturnTaskBoxItem();
            _loc1_.x = 200 + _loc2_ * 130;
            _loc1_.y = -40;
            addChild(_loc1_);
            _dayBoxItems.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initWeekBoxItems() : void
      {
         var _loc1_:OldPlayerReturnTaskBoxItem = null;
         var _loc2_:int = 0;
         _weekBoxItems = [];
         _loc2_ = 0;
         while(_loc2_ < weekCount)
         {
            _loc1_ = new OldPlayerReturnTaskBoxItem();
            _loc1_.x = 165 + _loc2_ * 110;
            _loc1_.y = 350;
            addChild(_loc1_);
            _weekBoxItems.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc7_:OldPlayerReturnRewardTempInfo = null;
         var _loc8_:OldPlayerReturnRewardTempInfo = null;
         var _loc2_:OldPlayerReturnTaskBoxItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:OldPlayerReturnRewardTempInfo = getInfoByType(1,dayCount);
         if(_loc6_)
         {
            _dayNumTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnTaskView.dayNumTxt.text",model.dailyNum,_loc6_.NeedCount);
         }
         _loc4_ = 0;
         while(_loc4_ < _dayBoxItems.length)
         {
            _loc6_ = getInfoByType(1,_loc4_ + 1);
            if(model.dailyNum <= _loc6_.NeedCount)
            {
               _loc5_ = _loc4_ * 25;
               _loc7_ = getInfoByType(1,_loc4_);
               if(_loc7_)
               {
                  _loc3_ = (model.dailyNum - _loc7_.NeedCount) / (_loc6_.NeedCount - _loc7_.NeedCount) * 25;
               }
               else
               {
                  _loc3_ = model.dailyNum / _loc6_.NeedCount * 25;
               }
               _loc5_ += _loc3_;
               break;
            }
            if(_loc4_ + 1 == _dayBoxItems.length && model.dailyNum > _loc6_.NeedCount)
            {
               _loc5_ = 100;
            }
            _loc4_++;
         }
         _dayProgress.progressValue(_loc5_,100);
         _loc5_ = 0;
         _loc3_ = 0;
         var _loc1_:OldPlayerReturnRewardTempInfo = getInfoByType(2,weekCount);
         if(_loc1_)
         {
            _weekNumTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnTaskView.dayNumTxt.text",model.weekNum,_loc1_.NeedCount);
         }
         _loc4_ = 0;
         while(_loc4_ < _weekBoxItems.length)
         {
            _loc1_ = getInfoByType(2,_loc4_ + 1);
            if(model.weekNum <= _loc1_.NeedCount)
            {
               _loc5_ = _loc4_ * 20;
               _loc7_ = getInfoByType(2,_loc4_);
               if(_loc7_)
               {
                  _loc3_ = (model.weekNum - _loc7_.NeedCount) / (_loc1_.NeedCount - _loc7_.NeedCount) * 20;
               }
               else
               {
                  _loc3_ = model.weekNum / _loc1_.NeedCount * 20;
               }
               _loc5_ += _loc3_;
               break;
            }
            if(_loc4_ + 1 == _weekBoxItems.length && model.weekNum > _loc1_.NeedCount)
            {
               _loc5_ = 100;
            }
            _loc4_++;
         }
         _weekProgress.progressValue(_loc5_,100);
         _loc4_ = 0;
         while(_loc4_ < _dayBoxItems.length)
         {
            _loc2_ = _dayBoxItems[_loc4_];
            _loc8_ = getInfoByType(1,_loc4_ + 1);
            _loc2_.data = _loc8_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _weekBoxItems.length)
         {
            _loc2_ = _weekBoxItems[_loc4_];
            _loc8_ = getInfoByType(2,_loc4_ + 1);
            _loc2_.data = _loc8_;
            _loc4_++;
         }
         refreshTaskItems();
      }
      
      private function get dayCount() : int
      {
         return TempleteManager.instance.oldPlayerReturnRewardTempCate.getCountByType(1);
      }
      
      private function get weekCount() : int
      {
         return TempleteManager.instance.oldPlayerReturnRewardTempCate.getCountByType(2);
      }
      
      private function getInfoByType(param1:int, param2:int) : OldPlayerReturnRewardTempInfo
      {
         return TempleteManager.instance.oldPlayerReturnRewardTempCate.getTempInfoByType(param1,param2);
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_dayTxt);
         _dayTxt = null;
         ObjectUtils.disposeObject(_dayNumTxt);
         _dayNumTxt = null;
         ObjectUtils.disposeObject(_dayProgress);
         _dayProgress = null;
         ObjectUtils.disposeObject(_weekTxt);
         _weekTxt = null;
         ObjectUtils.disposeObject(_weekNumTxt);
         _weekNumTxt = null;
         ObjectUtils.disposeObject(_weekProgress);
         _weekProgress = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         for each(var _loc1_:OldPlayerReturnTaskItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(var _loc3_:OldPlayerReturnTaskBoxItem in _dayBoxItems)
         {
            ObjectUtils.disposeObject(_loc3_);
            _loc3_ = null;
         }
         for each(var _loc2_:OldPlayerReturnTaskBoxItem in _weekBoxItems)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


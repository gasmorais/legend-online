package guidetask
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GuideTaskManager;
   import mvc.module.guidetask.SimpleTaskInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GuideTaskFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _vbox:VBox;
      
      private var _leftBg:Bitmap;
      
      private var _gapImg:MutipleImage;
      
      private var _taskBg:MutipleImage;
      
      private var _tabgroup:SelectedButtonGroup;
      
      private var _taskVbox:VBox;
      
      private var _rewardView:GuideTaskRewardView;
      
      private var _levelView:GuideLevelView;
      
      public var _defaultDay:int = 0;
      
      private var _defaultView:int = 1;
      
      private var _taskButtonGroup:SelectedButtonGroup;
      
      private var _helpBtn:BaseButton;
      
      public function GuideTaskFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:GuideTaskButton = null;
         var _loc3_:int = 0;
         var _loc1_:GuideTaskItem = null;
         _tabgroup = new SelectedButtonGroup();
         _taskButtonGroup = new SelectedButtonGroup();
         titleText = LanguageMgr.GetTranslation("guidetask.GuideTaskFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("guidetask.bg01");
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.guidetask.btnBack");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("guidetask.dayNumBtnVBox");
         _gapImg = ComponentFactory.Instance.creatComponentByStylename("guidetask.gap");
         _taskBg = ComponentFactory.Instance.creatComponentByStylename("guidetask.taskBg");
         _taskVbox = ComponentFactory.Instance.creatComponentByStylename("guidetask.taskItemVBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("guidetask.HelpBtn");
         addToContent(_bg);
         addToContent(_leftBg);
         addToContent(_vbox);
         addToContent(_gapImg);
         addToContent(_taskBg);
         addToContent(_taskVbox);
         addToContent(_helpBtn);
         _levelView = new GuideLevelView();
         _levelView.x = 201;
         _levelView.y = 4;
         addToContent(_levelView);
         _defaultDay = GuideTaskManager.instance.getCurrDay();
         _loc2_ = 1;
         while(_loc2_ < 8)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("guidetask.GuideTaskButton");
            _loc4_.setGradientText(LanguageMgr.GetTranslation("guidetask.GuideTaskFrame.dayBtnTxt0" + _loc2_));
            _tabgroup.addSelectItem(_loc4_);
            _vbox.addChild(_loc4_);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc1_ = new GuideTaskItem();
            _taskVbox.addChild(_loc1_);
            _taskButtonGroup.addSelectItem(_loc1_);
            _loc3_++;
         }
         _rewardView = new GuideTaskRewardView();
         _rewardView.x = 201;
         _rewardView.y = 329;
         addToContent(_rewardView);
         refreshData(_defaultDay);
         _tabgroup.selectIndex = _defaultDay - 1;
      }
      
      public function changePage(param1:int = 1) : void
      {
         _defaultView = param1;
         if(param1)
         {
            _tabgroup.selectIndex = _defaultDay - 1;
         }
         refreshData(_defaultDay);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         _tabgroup.addEventListener("change",__tabgroupChangeHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         _tabgroup.removeEventListener("change",__tabgroupChangeHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("guidetask.HelpFrame");
         _loc2_.show();
      }
      
      public function initData() : void
      {
         refreshData(_defaultDay);
      }
      
      private function refreshData(param1:int) : void
      {
         var _loc8_:GuideTaskButton = null;
         var _loc6_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:GuideTaskItem = null;
         var _loc7_:int = 0;
         var _loc5_:SimpleTaskInfo = null;
         _vbox.spacing = -3;
         _taskVbox.visible = false;
         _levelView.visible = false;
         _loc6_ = 0;
         while(_loc6_ < 7)
         {
            _loc8_ = _vbox.getChildAt(_loc6_) as GuideTaskButton;
            _loc8_.state = GuideTaskManager.instance.getRewardFlagByDay(_loc6_);
            _loc6_++;
         }
         _rewardView.setGetRewardBtnStatu(GuideTaskManager.instance.getRewardFlagByDay(param1 - 1));
         _rewardView.setGetRewardBtnHiden(GuideTaskManager.instance.getHasGetRewardByDay(param1 - 1));
         if(_defaultView == GuideTaskManager.TASK)
         {
            _taskVbox.visible = true;
            _loc2_ = GuideTaskManager.instance.getTaskArrByDay(param1);
            _loc4_ = int(_loc2_.length);
            _loc7_ = 0;
            while(_loc7_ < 7)
            {
               _loc3_ = _taskVbox.getChildAt(_loc7_) as GuideTaskItem;
               _loc5_ = _loc2_[_loc7_] as SimpleTaskInfo;
               if(_loc5_)
               {
                  if(param1 <= DateFormatter.compareDay(GuideTaskManager.instance.model.startTime))
                  {
                     _loc5_.isShow = true;
                  }
                  else
                  {
                     _loc5_.isShow = false;
                  }
               }
               _loc3_.data = _loc5_;
               _loc7_++;
            }
         }
         else if(_defaultView == GuideTaskManager.LEVEL)
         {
            _levelView.visible = true;
            _levelView.refreshData();
            _tabgroup.selectIndex = -1;
         }
         _rewardView.data = GuideTaskManager.instance.getRewardByDay(param1 + 1);
      }
      
      private function __tabgroupChangeHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc2_:ISelectable = _tabgroup.getSelectedItem();
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:int = int(_tabgroup.getIndexByItem(_loc2_));
         var _loc4_:Boolean = Boolean(GuideTaskManager.instance.getCanSee(_loc5_ + 1));
         if(_loc4_)
         {
            _defaultDay = _loc5_ + 1;
            _defaultView = GuideTaskManager.TASK;
            refreshData(_defaultDay);
         }
         else
         {
            _tabgroup.selectIndex = _defaultDay - 1;
            if(_loc5_ == GuideTaskManager.instance.getCurrDay())
            {
               _loc3_ = LanguageMgr.GetTranslation("guidetask.GuideTaskFrame.str");
               MessageTipManager.instance().show(_loc3_);
            }
         }
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}


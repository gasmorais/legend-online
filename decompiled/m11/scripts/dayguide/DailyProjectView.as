package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mvc.module.dayGuide.LeedInfo;
   
   public class DailyProjectView extends Component
   {
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _dailyBtn:SelectedTextButton;
      
      private var _singleBtn:SelectedTextButton;
      
      private var _mutiBtn:SelectedTextButton;
      
      private var _mutiPkBtn:SelectedTextButton;
      
      private var _consortiaBtn:SelectedTextButton;
      
      private var _petAndChildBtn:SelectedTextButton;
      
      private var _investitureBtn:SelectedTextButton;
      
      private var _currentSelected:SelectedButton;
      
      private var projectData:Dictionary;
      
      private var projectItemList:Object = {};
      
      private var maxHight:int = 174;
      
      public function DailyProjectView()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _dailyBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.dailyBtn");
         _singleBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.singleBtn");
         _mutiBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.mutiBtn");
         _mutiPkBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.mutiPkBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.consortiaBtn");
         _petAndChildBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.petAndChildBtn");
         _investitureBtn = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.investitureBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.vBox");
         _buttongroup = new SelectedButtonGroup();
         addChild(_dailyBtn);
         addChild(_singleBtn);
         addChild(_mutiBtn);
         addChild(_mutiPkBtn);
         addChild(_consortiaBtn);
         addChild(_petAndChildBtn);
         addChild(_investitureBtn);
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
         _buttongroup.addSelectItem(_dailyBtn);
         _buttongroup.addSelectItem(_singleBtn);
         _buttongroup.addSelectItem(_mutiBtn);
         _buttongroup.addSelectItem(_mutiPkBtn);
         _buttongroup.addSelectItem(_consortiaBtn);
         _buttongroup.addSelectItem(_petAndChildBtn);
         _buttongroup.addSelectItem(_investitureBtn);
         _buttongroup.selectIndex = 0;
      }
      
      private function addEvent() : void
      {
         _buttongroup.addEventListener("change",__btnChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _buttongroup.removeEventListener("change",__btnChangeHandler);
      }
      
      public function set data(param1:Dictionary) : void
      {
         projectData = param1;
         setSelectTextBtn();
         refreshView();
      }
      
      private function setSelectTextBtn() : void
      {
         _dailyBtn.text = getListDataByIndex(0).length.toString();
         _singleBtn.text = getListDataByIndex(1).length.toString();
         _mutiBtn.text = getListDataByIndex(2).length.toString();
         _mutiPkBtn.text = getListDataByIndex(3).length.toString();
         _consortiaBtn.text = getListDataByIndex(4).length.toString();
         _petAndChildBtn.text = getListDataByIndex(5).length.toString();
         _investitureBtn.text = getListDataByIndex(6).length.toString();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ProjectItem = null;
         _vBox.removeAllChild();
         if(_scrollPanel && _scrollPanel.parent)
         {
            _scrollPanel.parent.removeChild(_scrollPanel);
         }
         var _loc3_:Array = getListDataByIndex(_buttongroup.selectIndex);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = projectItemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("dayGuide.ProjectItem");
               projectItemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc3_[_loc2_];
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         if(_loc3_.length <= 0)
         {
            _scrollPanel.vScrollbar.visible = false;
         }
         else
         {
            addChildAt(_scrollPanel,_buttongroup.selectIndex + 1);
         }
         _scrollPanel.height = _loc3_.length * 29 > maxHight ? maxHight : _loc3_.length * 29;
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
         refreshMenuPos();
      }
      
      private function getListDataByIndex(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:LeedInfo in projectData)
         {
            if(int(_loc3_.sort / 100) == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(sortByStateAndId);
         return _loc2_;
      }
      
      private function sortByStateAndId(param1:LeedInfo, param2:LeedInfo) : int
      {
         if(!param1.isComplete && Boolean(param2.isComplete))
         {
            return -1;
         }
         if(param1.isComplete && !param2.isComplete)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return -1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         _currentSelected = _buttongroup.getSelectedItem() as SelectedButton;
         if(!_currentSelected)
         {
            return;
         }
         SoundManager.instance.play("022",true);
         refreshView();
      }
      
      private function getMenuData() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:LeedInfo in projectData)
         {
            if(_buttongroup.selectIndex == int(_loc2_.sort / 100))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function refreshMenuPos() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < this.numChildren)
         {
            _loc3_ = this.getChildAt(_loc2_);
            _loc3_.y = _loc1_;
            if(_loc3_ is ScrollPanel)
            {
               _loc1_ += (_loc3_ as ScrollPanel).height + 4;
            }
            else
            {
               _loc1_ += _loc3_.height + 4;
            }
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_dailyBtn)
         {
            ObjectUtils.disposeObject(_dailyBtn);
         }
         _dailyBtn = null;
         if(_singleBtn)
         {
            ObjectUtils.disposeObject(_singleBtn);
         }
         _singleBtn = null;
         if(_mutiBtn)
         {
            ObjectUtils.disposeObject(_mutiBtn);
         }
         _mutiBtn = null;
         if(_mutiPkBtn)
         {
            ObjectUtils.disposeObject(_mutiPkBtn);
         }
         _mutiPkBtn = null;
         if(_consortiaBtn)
         {
            ObjectUtils.disposeObject(_consortiaBtn);
         }
         _consortiaBtn = null;
         if(_petAndChildBtn)
         {
            ObjectUtils.disposeObject(_petAndChildBtn);
         }
         _petAndChildBtn = null;
         if(_investitureBtn)
         {
            ObjectUtils.disposeObject(_investitureBtn);
         }
         _investitureBtn = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(projectItemList)
         {
            for(var _loc1_:String in projectItemList)
            {
               ObjectUtils.disposeObject(projectItemList[_loc1_]);
               projectItemList[_loc1_] = null;
            }
            projectItemList = null;
         }
         _buttongroup = null;
         _currentSelected = null;
         projectData = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


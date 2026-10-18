package navigation
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationHelper;
   import mvc.module.navigation.NavigationPortInfo;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.NavigationTaskTempInfo;
   import yishi.manager.NotAlertManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationTaskItem extends Component
   {
      
      private var back:Bitmap;
      
      private var taskIcon:Bitmap;
      
      private var taskText:FilterFrameText;
      
      private var curHasText:FilterFrameText;
      
      private var refreshBtn:IconButton;
      
      private var selectBtn:SelectedTextButton;
      
      private var hasReached:Boolean;
      
      private var refreshCost:int;
      
      private var index:int;
      
      private var _data:NavigationPortInfo;
      
      private var taskTemp:NavigationTaskTempInfo;
      
      private var _preSelectState:Boolean;
      
      private var _comboBox:ComboBox;
      
      private var _defaultTxt:FilterFrameText;
      
      public function NavigationTaskItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.NavigationTaskItem.back");
         taskIcon = ComponentFactory.Instance.creatBitmap("asset.NavigationPortFrame.taskIcon");
         taskText = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.taskText");
         curHasText = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.curHasText");
         refreshBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationTaskItem.refreshBtn");
         selectBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationTaskItem.selectBtn");
         _comboBox = ComponentFactory.Instance.creatComponentByStylename("NavigationTaskItem.comboBox");
         _defaultTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationTaskItem.defaultTxt");
         addChild(back);
         addChild(taskIcon);
         addChild(taskText);
         addChild(curHasText);
         addChild(selectBtn);
         addChild(refreshBtn);
         addChild(_comboBox);
         addChild(_defaultTxt);
         refreshCost = ConfigInfoManager.instance.getNavigationPortTaskRefreshPoint();
         refreshBtn.tipData = LanguageMgr.GetTranslation("NavigationPortFrame.refreshBtn.tipData",refreshCost);
         selectBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.accept");
         _defaultTxt.text = LanguageMgr.GetTranslation("NavigationTaskItem.defaultTxt.text");
      }
      
      private function addEvent() : void
      {
         refreshBtn.addEventListener("click",__refreshClickHandler);
         selectBtn.addEventListener("click",__selectClickHandler);
         _comboBox.listPanel.list.addEventListener("listItemClick",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(refreshBtn)
         {
            refreshBtn.removeEventListener("click",__refreshClickHandler);
         }
         if(selectBtn)
         {
            selectBtn.removeEventListener("click",__selectClickHandler);
         }
         if(_comboBox)
         {
            _comboBox.listPanel.list.removeEventListener("listItemClick",__onClickHandler);
         }
      }
      
      private function __onClickHandler(param1:ListItemEvent) : void
      {
         refreshView();
      }
      
      private function __refreshClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("navigation.NavigationPortFrame.refresh.alertText",refreshCost);
         NotAlertManager.ins.needAlert("navigation.NavigationPortFrame.refreshAlert",refreshResultHandler,_loc2_,_loc3_);
      }
      
      private function refreshResultHandler(param1:Boolean) : void
      {
         if(!data || !taskTemp)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(refreshCost,param1))
         {
            return;
         }
         var _loc2_:int = param1 ? 0 : 1;
         NavigationManager.instance.sendNavigationOperate(9,data.portId,"",_loc2_,index);
      }
      
      private function __selectClickHandler(param1:MouseEvent) : void
      {
         if(data.isTasking)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationPortFrame.hasPatrol"));
            selectBtn.selected = _preSelectState;
            return;
         }
         if(!hasReached)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationPortFrame.nomatrial"));
            selectBtn.selected = false;
            return;
         }
      }
      
      public function get data() : NavigationPortInfo
      {
         return _data;
      }
      
      public function set data(param1:NavigationPortInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(!data)
         {
            return;
         }
         initBox();
         if(data["taskNum" + index])
         {
            _loc2_ = int(data["taskNum" + index]);
            _comboBox.listPanel.list.defaultSelectItemByCellValue = LanguageMgr.GetTranslation("NavigationTaskItem.comboBox.text",_loc2_);
         }
         else
         {
            _comboBox.listPanel.list.defaultSelectItemByCellValue = LanguageMgr.GetTranslation("NavigationTaskItem.comboBox.text",1);
         }
         if(data.isTasking)
         {
            _comboBox.mouseEnabled = _comboBox.mouseChildren = false;
         }
         else
         {
            _comboBox.mouseEnabled = _comboBox.mouseChildren = true;
         }
      }
      
      private function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = 0;
         taskTemp = data.getTaskTemp(data["taskId" + index]);
         if(taskTemp)
         {
            _loc4_ = taskTemp.ConsumedItems.split(",");
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[0]);
            _loc3_ = Number(NavigationHelper.getNumByTempId(_loc4_[0]));
            taskIcon.visible = true;
            selectBtn.visible = true;
            _loc1_ = _comboBox.currentSelectedIndex + 1;
            hasReached = _loc3_ >= _loc4_[1] * _loc1_;
            taskText.text = LanguageMgr.GetTranslation("NavigationPortFrame.taskText.desc",_loc2_.TemplateName,_loc4_[1] * _loc1_,taskTemp.ObtainedCurrency * _loc1_);
            curHasText.text = LanguageMgr.GetTranslation("NavigationPortFrame.curHasText.text",_loc2_.TemplateName,_loc4_[1] * _loc1_,_loc3_);
            hasReached ? curHasText.setFrame(1) : curHasText.setFrame(2);
            taskText.setFrame(taskTemp.Quality);
            if(data["selectedTask" + index])
            {
               selectBtn.selected = true;
            }
            else if(!hasReached)
            {
               selectBtn.selected = false;
            }
         }
         else
         {
            taskIcon.visible = false;
            taskText.text = "";
            curHasText.text = "";
            refreshBtn.visible = false;
            selectBtn.visible = false;
            selectBtn.selected = false;
         }
         refreshBtn.enable = !data.isTasking;
         _preSelectState = selectBtn.selected;
      }
      
      private function initBox() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= _data.currentTemplte.Data)
         {
            _comboBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("NavigationTaskItem.comboBox.text",_loc1_));
            _loc1_++;
         }
      }
      
      public function get isSelect() : Boolean
      {
         return selectBtn.selected;
      }
      
      public function get comboSelectedIndex() : int
      {
         return _comboBox.currentSelectedIndex + 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_comboBox);
         _comboBox = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(taskText);
         taskText = null;
         ObjectUtils.disposeObject(curHasText);
         curHasText = null;
         ObjectUtils.disposeObject(refreshBtn);
         refreshBtn = null;
         ObjectUtils.disposeObject(selectBtn);
         selectBtn = null;
         super.dispose();
      }
   }
}


package archaeology
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mvc.module.archeology.ArchaeologyItemInfo;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.ArchaeologyManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class ArchaeologyMakeLeftView extends Component
   {
      
      private var _btnVbox:Component;
      
      private var _mapAllBtn:SelectedIconButton;
      
      private var _map1Btn:SelectedIconButton;
      
      private var _map2Btn:SelectedIconButton;
      
      private var _map3Btn:SelectedIconButton;
      
      private var _map4Btn:SelectedIconButton;
      
      private var _map5Btn:SelectedIconButton;
      
      private var _listPanel:ListPanel;
      
      private var _currentSelected:SelectedButton;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _exchangeImg:Bitmap;
      
      private var _checkBtn:SelectedButton;
      
      private var _checkedPanel:ArchaeologyLeftCheckPanel;
      
      private var _typeTipsView0:MovieClip;
      
      private var _typeTipsView1:MovieClip;
      
      private var _typeTipsView2:MovieClip;
      
      private var _typeTipsView3:MovieClip;
      
      private var _typeTipsView4:MovieClip;
      
      private var _typeTipsView5:MovieClip;
      
      private var _selectedInfo:ArchaeologyItemInfo;
      
      private var _listDic:SimpleDictionary;
      
      private var _infoDic:SimpleDictionary;
      
      public function ArchaeologyMakeLeftView()
      {
         super();
         initView();
         addEvent();
         setFirstInfoSelected();
         __updateGoodListHandler(null,null);
      }
      
      private function initView() : void
      {
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.btnVbox");
         _mapAllBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.mapAllBtn");
         _map1Btn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.map1Btn");
         _map2Btn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.map2Btn");
         _map3Btn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.map3Btn");
         _map4Btn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.map4Btn");
         _map5Btn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.map5Btn");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.listPanel");
         _exchangeImg = ComponentFactory.Instance.creatBitmap("asset.archaeologyFrame.exchangeImage");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.checkButton");
         addChild(_btnVbox);
         _btnVbox.addChild(_mapAllBtn);
         _btnVbox.addChild(_map1Btn);
         _btnVbox.addChild(_map2Btn);
         _btnVbox.addChild(_map3Btn);
         _btnVbox.addChild(_map4Btn);
         _btnVbox.addChild(_map5Btn);
         _btnVbox.addChild(_listPanel);
         addChild(_exchangeImg);
         addChild(_checkBtn);
         _buttongroup = new SelectedButtonGroup();
         _buttongroup.addSelectItem(_mapAllBtn);
         _buttongroup.addSelectItem(_map1Btn);
         _buttongroup.addSelectItem(_map2Btn);
         _buttongroup.addSelectItem(_map3Btn);
         _buttongroup.addSelectItem(_map4Btn);
         _buttongroup.addSelectItem(_map5Btn);
         _buttongroup.selectIndex = 0;
         _typeTipsView0 = getBtnTipView();
         _typeTipsView1 = getBtnTipView();
         _typeTipsView2 = getBtnTipView();
         _typeTipsView3 = getBtnTipView();
         _typeTipsView4 = getBtnTipView();
         _typeTipsView5 = getBtnTipView();
         _mapAllBtn.addChild(_typeTipsView0);
         _map1Btn.addChild(_typeTipsView1);
         _map2Btn.addChild(_typeTipsView2);
         _map3Btn.addChild(_typeTipsView3);
         _map4Btn.addChild(_typeTipsView4);
         _map5Btn.addChild(_typeTipsView5);
         _listDic = new SimpleDictionary();
         _infoDic = new SimpleDictionary();
      }
      
      private function updateListView() : void
      {
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc1_:Array = _infoDic.getList().sortOn("groupId");
         for each(var _loc2_:ArchaeologyItemInfo in _loc1_)
         {
            _listPanel.vectorListModel.append(_loc2_);
            if(_loc2_.selected)
            {
               _listPanel.vectorListModel.appendAll(_listDic[_loc2_.groupId]);
            }
         }
         updateListPanelView();
         _listPanel.commitChanges();
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
         refreshBtnPos();
      }
      
      private function updateListPanelView() : void
      {
         if(_listPanel.list)
         {
            _listPanel.list.updateListView();
         }
         if(model.selectedDic[model.selectedType + "scrollValue"] > 0 && _listPanel.vScrollbar)
         {
            _listPanel.vScrollbar.scrollValue = model.selectedDic[model.selectedType + "scrollValue"];
         }
      }
      
      private function refreshData() : void
      {
         var _loc3_:ArchaeologyItemInfo = null;
         var _loc1_:Array = null;
         var _loc2_:ArchaeologyItemInfo = null;
         var _loc8_:ArchaeologyItemInfo = null;
         var _loc6_:int = 0;
         var _loc4_:ArchaeologyItemInfo = null;
         _listDic.clear();
         _infoDic.clear();
         var _loc5_:Array = model.getGoodsListByMapId(_buttongroup.selectIndex);
         for each(var _loc7_:ArchaeologyItemTemplate in _loc5_)
         {
            _loc8_ = model.getItemInfoById(_loc7_.Id);
            if(!_loc8_)
            {
               _loc8_ = new ArchaeologyItemInfo();
               _loc8_.tempId = _loc7_.Id;
               _loc8_.chipCount = 0;
               _loc8_.itemCount = 0;
            }
            _loc8_.groupId = _loc7_.Type;
            _loc8_.selected = false;
            _loc8_.cellType = 2;
            _loc6_ = int(_loc7_.Type);
            _loc3_ = _infoDic[_loc6_];
            _loc1_ = _listDic[_loc6_];
            if(!_loc3_)
            {
               _loc3_ = new ArchaeologyItemInfo();
               _loc3_.tempId = 0;
               _loc3_.chipCount = 0;
               _loc3_.itemCount = 0;
               _loc3_.groupId = _loc6_;
               _loc3_.cellType = 1;
               if(model.selectedDic["1_" + _loc6_] != null && model.selectedDic["1_" + _loc6_].groupId == _loc6_)
               {
                  _loc3_.selected = true;
                  _selectedInfo = _loc3_;
               }
               _infoDic.add(_loc6_,_loc3_);
            }
            if(!_loc1_)
            {
               _loc1_ = [];
               _listDic.add(_loc6_,_loc1_);
            }
            if(model.selectedDic["2_" + _loc6_] != null && model.selectedDic["2_" + _loc6_].groupId == _loc6_ && model.selectedDic["2_" + _loc6_].tempId == _loc8_.tempId)
            {
               _loc8_.selected = true;
               model.selectItemInfo = _loc8_;
            }
            _loc1_.push(_loc8_);
            if(!_loc2_)
            {
               _loc2_ = _loc8_;
            }
         }
         if(!model.selectItemInfo)
         {
            if(_loc2_)
            {
               _loc2_.selected = true;
               model.selectItemInfo = _loc2_;
               if(_infoDic[_loc2_.groupId])
               {
                  _loc4_ = _infoDic[_loc2_.groupId];
                  _loc4_.selected = true;
               }
            }
         }
         refreshMenuCanMakeCount();
      }
      
      private function refreshMenuCanMakeCount() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_:ArchaeologyItemInfo in _infoDic)
         {
            _loc2_ = 0;
            for each(var _loc3_:ArchaeologyItemInfo in _listDic[_loc1_.groupId])
            {
               _loc2_ += _loc3_.canMakeCount;
            }
            _loc1_.canMakeCount = _loc2_;
         }
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         return _loc1_;
      }
      
      private function updateBtnTipView(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            this["_typeTipsView" + _loc2_].visible = false;
            if(model.typeBtnArr[_loc2_] > 0)
            {
               this["_typeTipsView" + _loc2_].txt.text = model.typeBtnArr[_loc2_].toString();
               this["_typeTipsView" + _loc2_].visible = true;
            }
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _buttongroup.addEventListener("change",__btnChangeHandler);
         _listPanel.list.addEventListener("listItemClick",__leftItemSelectedHandler);
         MsgMan.addObserver("GOOD_lIST_UPDATE",this,__updateGoodListHandler);
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
         _checkBtn.addEventListener("select",__onCheckBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _buttongroup.removeEventListener("change",__btnChangeHandler);
         _listPanel.list.removeEventListener("listItemClick",__leftItemSelectedHandler);
         MsgMan.removeObserver("GOOD_lIST_UPDATE",this,__updateGoodListHandler);
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
         _checkBtn.removeEventListener("select",__onCheckBtnHandler);
      }
      
      private function __onCheckBtnHandler(param1:Event) : void
      {
         __updateGoodListHandler(null,null);
      }
      
      protected function __changeHandler(param1:InteractiveEvent) : void
      {
         if(_listPanel.vScrollbar)
         {
            model.selectedDic[model.selectedType + "scrollValue"] = _listPanel.vScrollbar ? _listPanel.vScrollbar.scrollValue : 0;
         }
      }
      
      private function __updateGoodListHandler(param1:String, param2:Object) : void
      {
         if(_checkBtn.selected)
         {
            if(!_checkedPanel)
            {
               _checkedPanel = new ArchaeologyLeftCheckPanel();
               _checkedPanel.x = 35;
               _checkedPanel.y = 145;
            }
            if(_btnVbox.parent)
            {
               this.removeChild(_btnVbox);
            }
            if(!_checkedPanel.parent)
            {
               this.addChild(_checkedPanel);
            }
            _checkedPanel.updateCheckListData();
         }
         else
         {
            if(!_btnVbox.parent)
            {
               addChild(_btnVbox);
            }
            if(_checkedPanel && _checkedPanel.parent)
            {
               this.removeChild(_checkedPanel);
            }
            refreshData();
            updateListView();
            updateBtnTipView();
            MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",model.selectItemInfo);
         }
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         _currentSelected = _buttongroup.getSelectedItem() as SelectedButton;
         if(!_currentSelected)
         {
            return;
         }
         SoundManager.instance.play("022",true);
         for(var _loc2_:String in model.selectedDic)
         {
            delete model.selectedDic[_loc2_];
         }
         setFirstInfoSelected();
         refreshData();
         updateListView();
      }
      
      private function setFirstInfoSelected() : void
      {
         var _loc2_:ArchaeologyItemInfo = model.getFirstInfoByMapId(_buttongroup.selectIndex);
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:ArchaeologyItemInfo = new ArchaeologyItemInfo();
         _loc1_.tempId = 0;
         _loc1_.chipCount = 0;
         _loc1_.itemCount = 0;
         _loc1_.groupId = _loc2_.groupId;
         _loc1_.cellType = 1;
         model.selectedDic["1_" + _loc2_.groupId] = _loc1_;
         model.selectedDic["2_" + _loc2_.groupId] = _loc2_;
      }
      
      private function __leftItemSelectedHandler(param1:ListItemEvent) : void
      {
         selectedByInfo(param1.cellValue);
      }
      
      private function selectedByInfo(param1:ArchaeologyItemInfo) : void
      {
         if(!param1)
         {
            return;
         }
         model.selectedType = param1.cellType;
         switch(int(param1.cellType) - 1)
         {
            case 0:
               if(!_selectedInfo)
               {
                  _selectedInfo = param1;
                  model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] = param1;
                  _selectedInfo.selected = true;
                  updateListView();
                  return;
               }
               if(_selectedInfo == param1)
               {
                  _selectedInfo.selected = !_selectedInfo.selected;
                  if(_selectedInfo.selected)
                  {
                     model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] = param1;
                     if(model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] != null)
                     {
                        model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] = null;
                     }
                  }
                  updateListView();
                  return;
               }
               if(model.selectItemInfo)
               {
                  model.selectItemInfo.selected = false;
                  model.selectItemInfo = null;
               }
               _selectedInfo.selected = false;
               _selectedInfo = param1;
               _selectedInfo.selected = true;
               model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] = param1;
               resetFirstInfoSelected();
               if(model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] != null)
               {
                  model.selectedDic[model.selectedType + "_" + _selectedInfo.groupId] = null;
               }
               updateListView();
               return;
               break;
            case 1:
               if(model.selectItemInfo == param1)
               {
                  return;
               }
               if(model.selectItemInfo)
               {
                  resetCurInfoSelected();
                  model.selectItemInfo.selected = false;
               }
               model.selectItemInfo = param1;
               if(model.selectedDic[model.selectedType + "_" + param1.groupId] != null)
               {
                  model.selectedDic[model.selectedType + "_" + param1.groupId] = null;
               }
               model.selectedDic[model.selectedType + "_" + param1.groupId] = param1;
               model.selectItemInfo.selected = true;
               updateListPanelView();
         }
      }
      
      private function resetFirstInfoSelected() : void
      {
         var _loc1_:ArchaeologyItemInfo = model.getFirstInfoByMapIdAndType(_buttongroup.selectIndex,_selectedInfo.groupId);
         if(!_loc1_)
         {
            return;
         }
         model.selectItemInfo = _loc1_;
         model.selectedDic["2_" + _selectedInfo.groupId] = _loc1_;
         for each(var _loc2_:ArchaeologyItemInfo in _listDic[_loc1_.groupId])
         {
            if(_loc2_.tempId == _loc1_.tempId)
            {
               _loc2_.selected = true;
               return;
            }
         }
      }
      
      private function resetCurInfoSelected() : void
      {
         for each(var _loc1_:ArchaeologyItemInfo in _listDic[model.selectItemInfo.groupId])
         {
            if(_loc1_.tempId == model.selectItemInfo.tempId)
            {
               _loc1_.selected = false;
               return;
            }
         }
      }
      
      private function refreshBtnPos() : void
      {
         _mapAllBtn.y = 0;
         switch(int(_buttongroup.selectIndex))
         {
            case 0:
               _map1Btn.y = 40 + _listPanel.height;
               _map2Btn.y = 80 + _listPanel.height;
               _map3Btn.y = 120 + _listPanel.height;
               _map4Btn.y = 160 + _listPanel.height;
               _map5Btn.y = 200 + _listPanel.height;
               break;
            case 1:
               _map1Btn.y = 40;
               _map2Btn.y = 80 + _listPanel.height;
               _map3Btn.y = 120 + _listPanel.height;
               _map4Btn.y = 160 + _listPanel.height;
               _map5Btn.y = 200 + _listPanel.height;
               break;
            case 2:
               _map1Btn.y = 40;
               _map2Btn.y = 80;
               _map3Btn.y = 120 + _listPanel.height;
               _map4Btn.y = 160 + _listPanel.height;
               _map5Btn.y = 200 + _listPanel.height;
               break;
            case 3:
               _map1Btn.y = 40;
               _map2Btn.y = 80;
               _map3Btn.y = 120;
               _map4Btn.y = 160 + _listPanel.height;
               _map5Btn.y = 200 + _listPanel.height;
               break;
            case 4:
               _map1Btn.y = 40;
               _map2Btn.y = 80;
               _map3Btn.y = 120;
               _map4Btn.y = 160;
               _map5Btn.y = 200 + _listPanel.height;
               break;
            case 5:
               _map1Btn.y = 40;
               _map2Btn.y = 80;
               _map3Btn.y = 120;
               _map4Btn.y = 160;
               _map5Btn.y = 200;
         }
         _listPanel.y = 40 * (_buttongroup.selectIndex + 1);
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_btnVbox)
         {
            ObjectUtils.disposeObject(_btnVbox);
         }
         _btnVbox = null;
         if(_map1Btn)
         {
            ObjectUtils.disposeObject(_map1Btn);
         }
         _map1Btn = null;
         if(_map2Btn)
         {
            ObjectUtils.disposeObject(_map2Btn);
         }
         _map2Btn = null;
         if(_map3Btn)
         {
            ObjectUtils.disposeObject(_map3Btn);
         }
         _map3Btn = null;
         if(_map4Btn)
         {
            ObjectUtils.disposeObject(_map4Btn);
         }
         _map4Btn = null;
         if(_map5Btn)
         {
            ObjectUtils.disposeObject(_map5Btn);
         }
         _map5Btn = null;
         if(_mapAllBtn)
         {
            ObjectUtils.disposeObject(_mapAllBtn);
         }
         _mapAllBtn = null;
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         if(_checkBtn)
         {
            ObjectUtils.disposeObject(_checkBtn);
         }
         _checkBtn = null;
         if(_typeTipsView0)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView0);
         }
         _typeTipsView0 = null;
         if(_typeTipsView1)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView1);
         }
         _typeTipsView1 = null;
         if(_typeTipsView2)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView2);
         }
         _typeTipsView2 = null;
         if(_typeTipsView3)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView3);
         }
         _typeTipsView3 = null;
         if(_typeTipsView4)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView4);
         }
         _typeTipsView4 = null;
         if(_typeTipsView5)
         {
            ObjectUtils.disposeViolentMc(_typeTipsView5);
         }
         _typeTipsView5 = null;
         if(_checkedPanel)
         {
            _checkedPanel.dispose();
            ObjectUtils.disposeObject(_checkedPanel);
            _checkedPanel = null;
         }
         _selectedInfo = null;
         _currentSelected = null;
         _buttongroup = null;
         model.selectItemInfo = null;
         _listDic = null;
         _infoDic = null;
         for(var _loc1_:String in model.selectedDic)
         {
            delete model.selectedDic[_loc1_];
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


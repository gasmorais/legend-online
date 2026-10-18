package store.compose
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.controler.StoreControler;
   import mvc.module.store.ComposeGoodsInfo;
   import mvc.module.store.StoreModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class ComposeSubListView extends Sprite implements Disposeable, IComposeList
   {
      
      private var _listPanel:ListPanel;
      
      private var _listWidth:int;
      
      private var _listHeight:int;
      
      private var _listDic:SimpleDictionary;
      
      private var _infoDic:SimpleDictionary;
      
      private var _selectedInfo:ComposeGoodsInfo;
      
      private var _currComposeInfo:ComposeGoodsInfo;
      
      public function ComposeSubListView(param1:int, param2:int)
      {
         super();
         _listWidth = param1;
         _listHeight = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _listDic = new SimpleDictionary();
         _infoDic = new SimpleDictionary();
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("store.ComposeGoodsListPanel");
         addChild(_listPanel);
      }
      
      public function setListPanelHeight(param1:int) : void
      {
         if(_listPanel)
         {
            _listPanel.height = param1;
         }
      }
      
      public function setListPanelWidth(param1:int) : void
      {
         if(_listPanel)
         {
            _listPanel.width = param1;
         }
      }
      
      private function addEvent() : void
      {
         _listPanel.list.addEventListener("listItemClick",__listItemClickHandler);
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _listPanel.list.removeEventListener("listItemClick",__listItemClickHandler);
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
      }
      
      protected function __changeHandler(param1:InteractiveEvent) : void
      {
         if(_listPanel.vScrollbar)
         {
            model.selectedDic[model.selectedType + "scrollValue"] = _listPanel.vScrollbar ? _listPanel.vScrollbar.scrollValue : 0;
         }
      }
      
      private function __listItemClickHandler(param1:ListItemEvent) : void
      {
         selectedByInfo(param1.cellValue);
      }
      
      private function refreshData() : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:ComposeGoodsInfo = null;
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         _listDic.clear();
         _infoDic.clear();
         var _loc7_:Vector.<ComposeGoodsInfo> = model.getComposeListByType();
         var _loc4_:int = PlayerManager.instance.currentPlayerModel.playerInfo.job % 3;
         if(_loc4_ == 0)
         {
            _loc4_ = 3;
         }
         var _loc6_:Array = [361,362,363,364,365,366,367,368,369];
         for each(var _loc8_:ComposeGoodsInfo in _loc7_)
         {
            if(!(model.isCanMake && _loc8_.canMakeCount <= 0))
            {
               if(_loc6_.indexOf(_loc8_.template.Types) == -1)
               {
                  _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_.template.NewMaterial);
                  if(!VersionSwitch.STORE_SHOW)
                  {
                     if(_loc8_.template.NeedMinLevel > thane.grades)
                     {
                        continue;
                     }
                     if((_loc2_.SonType == 117 || _loc2_.SonType == 118) && thane.vocationGrades <= 0)
                     {
                        continue;
                     }
                  }
                  else if(_loc8_.template.NewMaterial.toString().substr(0,3) == "218")
                  {
                     if(_loc8_.template.NeedMinLevel > thane.grades)
                     {
                        continue;
                     }
                     if((_loc2_.SonType == 117 || _loc2_.SonType == 118) && thane.vocationGrades <= 0)
                     {
                        continue;
                     }
                  }
                  else
                  {
                     if(_loc8_.template.NeedMinLevel > thane.grades + 10)
                     {
                        continue;
                     }
                     if((_loc2_.SonType == 117 || _loc2_.SonType == 118) && thane.vocationGrades <= 0)
                     {
                        continue;
                     }
                  }
                  if(int(_loc2_.Job) != _loc4_ && int(_loc2_.Job) != 0 && int(_loc2_.Job) != 4)
                  {
                     continue;
                  }
               }
               switch(int(model.composeType) - 1)
               {
                  case 0:
                     if(_loc2_.NeedChangeJob == 1)
                     {
                        _loc5_ = 85;
                     }
                     else if(_loc8_.template.Types == 9)
                     {
                        _loc5_ = 100;
                     }
                     else if(_loc8_.template.Types == 20)
                     {
                        _loc5_ = 105;
                     }
                     else if(_loc8_.template.Types == 13)
                     {
                        _loc5_ = 110;
                     }
                     else if(_loc8_.template.Types == 17)
                     {
                        _loc5_ = 115;
                     }
                     else if(_loc8_.template.Types == 18)
                     {
                        _loc5_ = 116;
                     }
                     else if(_loc8_.template.Types == 19)
                     {
                        _loc5_ = 117;
                     }
                     else if(_loc2_.SonType != 117 && _loc2_.SonType != 118)
                     {
                        _loc5_ = int(_loc8_.template.NeedMinLevel);
                     }
                     else
                     {
                        _loc5_ = 90;
                     }
                     break;
                  case 2:
                     _loc5_ = int(_loc8_.template.Types);
                     break;
                  case 3:
                     _loc5_ = int(_loc8_.template.Types);
                     break;
                  case 4:
                     _loc5_ = int(_loc8_.template.Types);
               }
               _loc3_ = _infoDic[_loc5_];
               _loc1_ = _listDic[_loc5_];
               if(!_loc3_)
               {
                  _loc3_ = new ComposeGoodsInfo();
                  switch(int(model.composeType) - 1)
                  {
                     case 0:
                        _loc3_.cellType = 1;
                        break;
                     case 2:
                        _loc3_.cellType = 3;
                        break;
                     case 3:
                        _loc3_.cellType = 5;
                        break;
                     case 4:
                        _loc3_.cellType = 6;
                  }
                  _loc3_.groupId = _loc5_;
                  if(model.selectedDic[model.selectedType] != null && model.selectedDic[model.selectedType].groupId == _loc5_)
                  {
                     _loc3_.selected = true;
                     _selectedInfo = _loc3_;
                  }
                  _infoDic.add(_loc5_,_loc3_);
               }
               if(!_loc1_)
               {
                  _loc1_ = [];
                  _listDic.add(_loc5_,_loc1_);
               }
               _loc8_.cellType = 4;
               if(model.selectedDic[model.selectedType + "SUIT_SUBCELL"] != null && model.selectedDic[model.selectedType + "SUIT_SUBCELL"].templateId == _loc8_.templateId)
               {
                  _loc8_.selected = true;
                  model.selectedCompose = _loc8_;
               }
               _loc1_.push(_loc8_);
            }
         }
         refreshMenuCanMakeCount();
      }
      
      private function refreshMenuCanMakeCount() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_:ComposeGoodsInfo in _infoDic)
         {
            _loc2_ = 0;
            for each(var _loc3_:ComposeGoodsInfo in _listDic[_loc1_.groupId])
            {
               _loc2_ += _loc3_.canMakeCount;
               if(_loc1_.groupId == 9)
               {
                  _loc2_ = int(_loc3_.canMakeCount);
               }
            }
            _loc1_.canMakeCount = _loc2_;
         }
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         var _loc6_:Array = null;
         var _loc9_:ComposeGoodsInfo = null;
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
         _listPanel.vectorListModel.clear();
         _listPanel.beginChanges();
         var _loc2_:Array = _infoDic.getList().sortOn("groupId",16);
         var _loc7_:* = -1;
         var _loc3_:* = -1;
         for each(var _loc10_:ComposeGoodsInfo in _loc2_)
         {
            _listPanel.vectorListModel.append(_loc10_);
            if(_loc10_.selected)
            {
               _loc8_ = _listDic[_loc10_.groupId] as Array;
               if(_loc10_.cellType == 1)
               {
                  _loc8_.sort(sortArr);
               }
               if(_loc10_.cellType == 3)
               {
                  if(param1)
                  {
                     _loc4_ = 0;
                     for each(var _loc5_:ComposeGoodsInfo in _loc8_)
                     {
                        if(model.isCanMake && _currComposeInfo)
                        {
                           if(_loc5_.template.NewMaterial > _currComposeInfo.template.NewMaterial)
                           {
                              if(_loc6_ == null)
                              {
                                 _loc7_ = _loc4_;
                                 _loc9_ = _loc5_;
                                 if(_loc6_ == null)
                                 {
                                    _loc6_ = [_loc7_,_loc9_];
                                 }
                              }
                              break;
                           }
                        }
                        else
                        {
                           if(_currComposeInfo && _loc5_ == _currComposeInfo)
                           {
                              _loc3_ = _loc4_;
                           }
                           if(_loc5_.canMakeCount > 0)
                           {
                              _loc7_ = _loc4_;
                              _loc9_ = _loc5_;
                              if(_loc3_ != -1 && _loc4_ > _loc3_)
                              {
                                 break;
                              }
                              if(_loc6_ == null)
                              {
                                 _loc6_ = [_loc7_,_loc9_];
                              }
                           }
                        }
                        _loc4_++;
                     }
                     if(_loc6_)
                     {
                        if(_loc7_ == _loc6_[0])
                        {
                           _loc7_ = int(_loc6_[0]);
                           _loc9_ = _loc6_[1];
                        }
                     }
                  }
               }
               _listPanel.vectorListModel.appendAll(_loc8_);
            }
         }
         updateListView();
         _listPanel.commitChanges();
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
         autoSelectNextMakeCount(_loc7_,_loc9_);
      }
      
      private function autoSelectNextMakeCount(param1:int, param2:ComposeGoodsInfo) : void
      {
         if(param1 == -1)
         {
            return;
         }
         _listPanel.vScrollbar.scrollValue = param1 * 22;
         _listPanel.list.defaultSelectItemByCellValue = param2;
      }
      
      private function sortArr(param1:ComposeGoodsInfo, param2:ComposeGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.template.NewMaterial);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.template.NewMaterial);
         if(!_loc4_ || !_loc3_)
         {
            return -1;
         }
         if(_loc4_.Profile < _loc3_.Profile)
         {
            return -1;
         }
         if(_loc4_.Profile > _loc3_.Profile)
         {
            return 1;
         }
         if(_loc4_.TemplateId < _loc3_.TemplateId)
         {
            return -1;
         }
         if(_loc4_.TemplateId > _loc3_.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function updateListView() : void
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
      
      private function selectedByInfo(param1:ComposeGoodsInfo) : void
      {
         if(!param1)
         {
            return;
         }
         switch(int(param1.cellType) - 1)
         {
            case 0:
            case 2:
            case 4:
            case 5:
               if(!_selectedInfo)
               {
                  _selectedInfo = param1;
                  model.selectedDic[model.selectedType] = param1;
                  _selectedInfo.selected = true;
                  refreshView();
                  return;
               }
               if(_selectedInfo == param1)
               {
                  _selectedInfo.selected = !_selectedInfo.selected;
                  if(_selectedInfo.selected)
                  {
                     model.selectedDic[model.selectedType] = param1;
                     if(model.selectedDic[model.selectedType + "SUIT_SUBCELL"] != null)
                     {
                        model.selectedDic[model.selectedType + "SUIT_SUBCELL"] = null;
                     }
                  }
                  refreshView();
                  return;
               }
               if(model.selectedCompose)
               {
                  model.selectedCompose.selected = false;
                  model.selectedCompose = null;
               }
               _selectedInfo.selected = false;
               _selectedInfo = param1;
               _selectedInfo.selected = true;
               model.selectedDic[model.selectedType] = param1;
               if(model.selectedDic[model.selectedType + "SUIT_SUBCELL"] != null)
               {
                  model.selectedDic[model.selectedType + "SUIT_SUBCELL"] = null;
               }
               refreshView();
               return;
               break;
            case 3:
               if(model.selectedCompose == param1)
               {
                  return;
               }
               if(model.selectedCompose)
               {
                  model.selectedCompose.selected = false;
               }
               model.selectedCompose = param1;
               model.selectedDic[model.selectedType + "SUIT_SUBCELL"] = param1;
               model.selectedCompose.selected = true;
               updateListView();
         }
      }
      
      public function selectedByType(param1:int, param2:ComposeGoodsInfo) : void
      {
         if(model.composeType == param1)
         {
            return;
         }
         model.composeType = param1;
         update(null);
      }
      
      public function update(param1:ComposeGoodsInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = param1 ? true : false;
         if(_loc3_)
         {
            _loc2_ = int(_listPanel.list.currentSelectedIndex);
            _currComposeInfo = _listPanel.vectorListModel.get(_loc2_);
            if(_currComposeInfo && _currComposeInfo.canMakeCount > 0)
            {
               _loc3_ = false;
            }
            if(model.autoBuy)
            {
               _loc3_ = false;
            }
         }
         else
         {
            _currComposeInfo = null;
         }
         refreshData();
         refreshView(_loc3_);
      }
      
      public function set defaultEquipSelected(param1:ComposeGoodsInfo) : void
      {
         var curTemplateInfo:GoodsTemplateInfo;
         var isWzOrSw:Boolean;
         var info:ComposeGoodsInfo = param1;
         var getComposeInfoByGroupId:* = function(param1:uint):ComposeGoodsInfo
         {
            var _loc2_:ComposeGoodsInfo = null;
            for each(var _loc3_:ComposeGoodsInfo in _infoDic)
            {
               if(_loc3_.groupId == param1)
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            return _loc2_;
         };
         if(!info || !info.template)
         {
            return;
         }
         curTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(info.template.NewMaterial);
         isWzOrSw = Boolean(GoodsSonType.checkNewEquip(curTemplateInfo));
         if(isWzOrSw)
         {
            _selectedInfo = getComposeInfoByGroupId(90);
         }
         else
         {
            _selectedInfo = getComposeInfoByGroupId(info.template.NeedMinLevel);
         }
         if(_selectedInfo != null)
         {
            _selectedInfo.selected = true;
         }
         refreshView();
         selectedByInfo(info);
      }
      
      public function get viewHeight() : Number
      {
         return _listHeight;
      }
      
      private function get model() : StoreModel
      {
         return control.model;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_listPanel)
         {
            _listPanel.dispose();
         }
         _listPanel = null;
         if(_listDic)
         {
            _listDic.clear();
         }
         _listDic = null;
         if(_infoDic)
         {
            _infoDic.clear();
         }
         _infoDic = null;
         _selectedInfo = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _currComposeInfo = null;
      }
   }
}


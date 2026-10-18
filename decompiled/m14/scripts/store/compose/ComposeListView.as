package store.compose
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
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
   
   public class ComposeListView extends Sprite implements Disposeable, IComposeList
   {
      
      private var _listPanel:ListPanel;
      
      private var _listHeight:int;
      
      private var _listWidth:int;
      
      public function ComposeListView(param1:int, param2:int)
      {
         super();
         _listHeight = param2;
         _listWidth = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
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
      
      private function initEvent() : void
      {
         _listPanel.list.addEventListener("listItemClick",__itemSelectedHandler);
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _listPanel.list.removeEventListener("listItemClick",__itemSelectedHandler);
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
      }
      
      protected function __changeHandler(param1:InteractiveEvent) : void
      {
         if(_listPanel.vScrollbar)
         {
            model.selectedDic[model.selectedType + "scrollValue"] = _listPanel.vScrollbar ? _listPanel.vScrollbar.scrollValue : 0;
         }
      }
      
      private function __itemSelectedHandler(param1:ListItemEvent) : void
      {
         if(model.selectedCompose == param1.cellValue)
         {
            return;
         }
         if(model.selectedCompose)
         {
            model.selectedCompose.selected = false;
         }
         model.selectedCompose = param1.cellValue;
         if(model.selectedCompose)
         {
            model.selectedCompose.selected = true;
         }
         if(_listPanel.list)
         {
            _listPanel.list.updateListView();
         }
      }
      
      public function update(param1:ComposeGoodsInfo) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         _listPanel.vScrollbar.removeEventListener("stateChange",__changeHandler);
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc8_:ComposeGoodsInfo = param1;
         var _loc7_:Vector.<ComposeGoodsInfo> = model.getComposeListByType();
         if(!_loc7_)
         {
            return;
         }
         var _loc4_:int = int(_loc7_.length);
         var _loc5_:int = PlayerManager.instance.currentPlayerModel.playerInfo.job % 3;
         if(_loc5_ == 0)
         {
            _loc5_ = 3;
         }
         _loc6_ = 0;
         for(; _loc6_ < _loc4_; _loc6_++)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_[_loc6_].template.NewMaterial);
            if(!(int(_loc3_.Job) != _loc5_ && int(_loc3_.Job) != 0 && int(_loc3_.Job) != 4))
            {
               if(!(model.isCanMake && _loc7_[_loc6_].canMakeCount <= 0))
               {
                  if(!VersionSwitch.STORE_SHOW)
                  {
                     if(_loc7_[_loc6_].template.NeedMinLevel > thane.grades)
                     {
                        continue;
                     }
                  }
                  else if(_loc7_[_loc6_].template.NewMaterial.toString().substr(0,3) == "218")
                  {
                     if(_loc7_[_loc6_].template.NeedMinLevel > thane.grades)
                     {
                        continue;
                     }
                  }
                  else if(_loc7_[_loc6_].template.NeedMinLevel > thane.grades + 10)
                  {
                     continue;
                  }
                  if(!_loc8_)
                  {
                     _loc8_ = _loc7_[_loc6_];
                  }
                  else if(_loc8_.templateId == _loc7_[_loc6_].templateId)
                  {
                     _loc8_ = _loc7_[_loc6_];
                  }
                  _listPanel.vectorListModel.append(_loc7_[_loc6_]);
               }
            }
         }
         var _loc2_:Boolean = false;
         if(model.isCanMake)
         {
            if(_loc8_ && _loc8_.canMakeCount <= 0)
            {
               _loc2_ = true;
               _loc8_ = _listPanel.vectorListModel.first();
            }
         }
         _listPanel.list.defaultSelectItemByCellValue = _loc8_;
         if(_loc2_)
         {
            _listPanel.vScrollbar.scrollValue = 0;
            model.selectedDic[model.selectedType + "scrollValue"] = 0;
         }
         else if(model.selectedDic[model.selectedType + "scrollValue"] > 0 && _listPanel.vScrollbar)
         {
            _listPanel.vScrollbar.scrollValue = model.selectedDic[model.selectedType + "scrollValue"];
         }
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
         _listPanel.commitChanges();
         _listPanel.vScrollbar.addEventListener("stateChange",__changeHandler);
      }
      
      public function selectedByType(param1:int, param2:ComposeGoodsInfo) : void
      {
         if(model.composeType == param1)
         {
            return;
         }
         if(model.selectedCompose)
         {
            model.selectedCompose.selected = false;
            model.selectedCompose = null;
         }
         model.composeType = param1;
         update(param2);
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
      
      private function uninit() : void
      {
         _listPanel.dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
      }
   }
}


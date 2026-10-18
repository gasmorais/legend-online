package archaeology
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.utils.ArrayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.archeology.ArchaeologyItemInfo;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.ArchaeologyManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class ArchaeologyLeftCheckPanel extends Sprite
   {
      
      private var _selectedListPanel:ListPanel;
      
      private var _checkSelectedTypeInfo:ArchaeologyItemInfo;
      
      private var _checkSelectedItemInfo:ArchaeologyItemInfo;
      
      private var infoDic:SimpleDictionary = new SimpleDictionary();
      
      private var listDic:SimpleDictionary = new SimpleDictionary();
      
      public function ArchaeologyLeftCheckPanel()
      {
         super();
         _selectedListPanel = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeLeftView.listPanel");
         _selectedListPanel.height = 356;
         this.addChild(_selectedListPanel);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _selectedListPanel.list.addEventListener("listItemClick",__leftItemCheckSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectedListPanel)
         {
            _selectedListPanel.list.removeEventListener("listItemClick",__leftItemCheckSelectedHandler);
         }
      }
      
      public function updateCheckListData() : void
      {
         var _loc6_:ArchaeologyItemInfo = null;
         var _loc4_:ArchaeologyItemInfo = null;
         var _loc2_:Array = null;
         var _loc3_:ArchaeologyItemTemplate = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:ArchaeologyItemInfo = null;
         var _loc7_:int = 0;
         infoDic.clear();
         listDic.clear();
         var _loc11_:Array = ArrayUtils.dictionaryToArray(model.getAllGoodsDic());
         _loc11_.sortOn(["Type","Id"],16);
         var _loc1_:Dictionary = new Dictionary();
         var _loc9_:Dictionary = new Dictionary();
         _loc8_ = 0;
         _loc5_ = int(_loc11_.length);
         while(_loc8_ < _loc5_)
         {
            _loc3_ = _loc11_[_loc8_];
            _loc12_ = model.getItemInfoById(_loc3_.Id);
            if(!_loc12_)
            {
               _loc12_ = new ArchaeologyItemInfo();
               _loc12_.tempId = _loc3_.Id;
               _loc12_.chipCount = 0;
               _loc12_.itemCount = 0;
               _loc12_.groupId = _loc3_.Type;
            }
            if(_loc12_.canMakeCount != 0)
            {
               _loc4_ = infoDic[_loc3_.Type];
               if(!_loc4_)
               {
                  _loc4_ = new ArchaeologyItemInfo();
                  _loc4_.tempId = 0;
                  _loc4_.chipCount = 0;
                  _loc4_.itemCount = 0;
                  _loc4_.groupId = _loc3_.Type;
                  _loc4_.cellType = 1;
                  infoDic.add(_loc3_.Type,_loc4_);
                  _loc1_[_loc4_.groupId] = _loc4_;
                  if(!_loc6_)
                  {
                     _loc6_ = _loc4_;
                  }
               }
               _loc2_ = listDic[_loc3_.Type];
               if(!_loc2_)
               {
                  _loc2_ = [];
                  listDic.add(_loc3_.Type,_loc2_);
               }
               _loc9_[_loc12_.tempId] = _loc12_;
               _loc2_.push(_loc12_);
            }
            _loc8_++;
         }
         if(_loc6_)
         {
            if(_checkSelectedTypeInfo)
            {
               if(!_checkSelectedTypeInfo.selected)
               {
                  _checkSelectedTypeInfo = _loc6_;
               }
            }
            else
            {
               _checkSelectedTypeInfo = _loc6_;
            }
            _checkSelectedTypeInfo = _loc1_[_checkSelectedTypeInfo.groupId];
            if(!_checkSelectedTypeInfo)
            {
               _checkSelectedTypeInfo = _loc6_;
            }
            _checkSelectedTypeInfo.selected = true;
            if(_checkSelectedItemInfo)
            {
               if(!_checkSelectedItemInfo.selected)
               {
                  _checkSelectedItemInfo = listDic[_checkSelectedTypeInfo.groupId][0];
               }
            }
            else
            {
               _checkSelectedItemInfo = listDic[_checkSelectedTypeInfo.groupId][0];
            }
            _checkSelectedItemInfo = _loc9_[_checkSelectedItemInfo.tempId];
            if(!_checkSelectedItemInfo)
            {
               _checkSelectedItemInfo = listDic[_checkSelectedTypeInfo.groupId][0];
            }
            for each(var _loc10_:ArchaeologyItemInfo in _loc9_)
            {
               _loc10_.selected = false;
            }
            _checkSelectedItemInfo.selected = true;
            MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",_checkSelectedItemInfo);
         }
         else if(_checkSelectedItemInfo)
         {
            _checkSelectedItemInfo.chipCount = 0;
            MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",_checkSelectedItemInfo);
         }
         for each(_loc4_ in infoDic)
         {
            _loc7_ = 0;
            for each(_loc12_ in listDic[_loc4_.groupId])
            {
               _loc7_ += _loc12_.canMakeCount;
            }
            _loc4_.canMakeCount = _loc7_;
         }
         updateCheckListPanel();
      }
      
      private function __leftItemCheckSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:ArchaeologyItemInfo = param1.cellValue;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.cellType == 1)
         {
            if(_checkSelectedTypeInfo == _loc3_)
            {
               _checkSelectedTypeInfo.selected = !_checkSelectedTypeInfo.selected;
               updateCheckListPanel();
               return;
            }
            if(_checkSelectedTypeInfo.selected)
            {
               _checkSelectedTypeInfo.selected = false;
            }
            _checkSelectedTypeInfo = _loc3_;
            _checkSelectedTypeInfo.selected = true;
            _loc2_ = listDic[_loc3_.groupId];
            if(_loc2_.length > 0)
            {
               _checkSelectedItemInfo.selected = false;
               _checkSelectedItemInfo = _loc2_[0];
               _checkSelectedItemInfo.selected = true;
               MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",_checkSelectedItemInfo);
            }
            updateCheckListPanel();
         }
         else if(_loc3_.cellType == 2)
         {
            MsgMan.notifyObserver("ARCHAEOLOGY_LEFTITEM_SELECT",_loc3_);
            if(_checkSelectedItemInfo == _loc3_)
            {
               return;
            }
            _checkSelectedItemInfo.selected = false;
            _loc3_.selected = true;
            _checkSelectedItemInfo = _loc3_;
            updateCheckListPanel();
         }
      }
      
      private function updateCheckListPanel() : void
      {
         _selectedListPanel.beginChanges();
         _selectedListPanel.vectorListModel.clear();
         var _loc1_:Array = infoDic.getList().sortOn("groupId");
         for each(var _loc2_:ArchaeologyItemInfo in _loc1_)
         {
            _selectedListPanel.vectorListModel.append(_loc2_);
            if(_loc2_.selected)
            {
               _selectedListPanel.vectorListModel.appendAll(listDic[_loc2_.groupId]);
            }
         }
         if(_selectedListPanel.list)
         {
            _selectedListPanel.list.updateListView();
         }
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      public function dispose() : void
      {
         this.removeEvent();
         if(_selectedListPanel)
         {
            ObjectUtils.disposeAllGrandson(_selectedListPanel);
         }
         _selectedListPanel = null;
         if(infoDic)
         {
            infoDic.clear();
            infoDic = null;
         }
         if(listDic)
         {
            listDic.clear();
            listDic = null;
         }
         _checkSelectedItemInfo = null;
         _checkSelectedTypeInfo = null;
      }
   }
}


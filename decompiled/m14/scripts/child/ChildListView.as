package child
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class ChildListView extends Component
   {
      
      private var itemVbox:VBox;
      
      private var scrollPanel:ScrollPanel;
      
      private var itemList:Vector.<ChildListItemView>;
      
      private var enterWarChild:ChildData;
      
      public function ChildListView()
      {
         super();
         initView();
         initChildListView();
         addEvent();
         setFirstSelect();
      }
      
      private function getChildEnterWar() : ChildData
      {
         for each(var _loc1_:ChildData in model.noNsChildList)
         {
            if(_loc1_.fightUserId == playerModel.userInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function getChildSlavedEnterWar() : ChildData
      {
         for each(var _loc1_:ChildData in model.noNsChildList)
         {
            if(_loc1_.fightSlaveUserId == playerModel.userInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function setFirstSelect() : void
      {
         if(getChildEnterWar())
         {
            enterWarChild = getChildEnterWar();
            model.selectItemTemp = enterWarChild.childTempInfo;
         }
         else if(getChildSlavedEnterWar())
         {
            enterWarChild = getChildSlavedEnterWar();
            model.selectItemTemp = enterWarChild.childTempInfo;
         }
         else
         {
            model.selectItemTemp = itemList[0].data;
         }
      }
      
      public function resetSelect() : void
      {
         refreshChildListView();
      }
      
      private function initView() : void
      {
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("ChildListView.itemVbox");
         scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ChildListView.scrollPanel");
         addChild(scrollPanel);
         scrollPanel.setView(itemVbox);
      }
      
      private function initChildListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildListItemView = null;
         itemList = new Vector.<ChildListItemView>();
         _loc2_ = 0;
         while(_loc2_ < showList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildListView.ChildListView");
            _loc1_.data = showList[_loc2_];
            itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         itemVbox.commitChanges();
         scrollPanel.invalidateViewport();
         itemVbox.beginChanges();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__updateItemTempSelect);
         MsgMan.addObserver("ChildEvent.CHILD_ITEMTEMP_SELECT",this,__updateItemTempSelect);
         MsgMan.addObserver("ChildEvent.CHILD_LISTVIEW_UPDATE",this,__updateListViewHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__updateItemTempSelect);
         MsgMan.removeObserver("ChildEvent.CHILD_ITEMTEMP_SELECT",this,__updateItemTempSelect);
         MsgMan.removeObserver("ChildEvent.CHILD_LISTVIEW_UPDATE",this,__updateListViewHandler);
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
      }
      
      public function refreshSortView() : void
      {
         if(model.selectedChild)
         {
            refreshChildListView();
         }
      }
      
      private function __updateListViewHandler(param1:String, param2:Object) : void
      {
         itemVbox.commitChanges();
         scrollPanel.invalidateViewport();
         itemVbox.beginChanges();
      }
      
      private function __updateItemTempSelect(param1:String, param2:Object) : void
      {
         refreshChildListView();
      }
      
      private function refreshChildListView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            itemList[_loc1_].data = _loc1_ < showList.length ? showList[_loc1_] : null;
            if(itemList[_loc1_].data && itemList[_loc1_].data.JobType == model.selectItemTemp.JobType)
            {
               model.selectItemTemp = itemList[_loc1_].data;
               itemList[_loc1_].selected = true;
               itemList[_loc1_].selectState = true;
            }
            else
            {
               itemList[_loc1_].selected = false;
               itemList[_loc1_].selectState = false;
            }
            _loc1_++;
         }
         __updateListViewHandler("",null);
      }
      
      private function get showList() : Array
      {
         return model.collectionTempList;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(scrollPanel);
         scrollPanel = null;
         ObjectUtils.disposeObject(itemVbox);
         itemVbox = null;
         if(itemList)
         {
            while(itemList.length > 0)
            {
               itemList.pop().dispose();
            }
            itemList = null;
         }
         enterWarChild = null;
         super.dispose();
      }
   }
}


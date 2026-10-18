package avenger.view
{
   import avenger.item.AvengerChildNsItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   
   public class AvengerChildNsListView extends Component
   {
      
      private var itemVbox:VBox;
      
      private var itemList:Vector.<AvengerChildNsItem>;
      
      public function AvengerChildNsListView()
      {
         super();
         nsModel.nsTempList.sort(nsModel.sortNsTempList);
         initView();
         initListView();
         addEvent();
         nsModel.selectedNsChildTemp = itemList[0].tempInfo;
         if(nsModel.selectedNsChildTemp)
         {
            nsModel.selectedNsChild = nsModel.getNsChildDataByJob(nsModel.selectedNsChildTemp.JobType);
         }
      }
      
      private function initView() : void
      {
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritListView.itemVbox");
         addChild(itemVbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AvengerChildNsItem = null;
         itemList = new Vector.<AvengerChildNsItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerChildNsListView.nsItem");
            _loc1_.tempInfo = _loc2_ < nsModel.nsTempList.length ? nsModel.nsTempList[_loc2_] : null;
            itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         itemVbox.commitChanges();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__changeHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__changeHandler);
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         if(nsModel.selectedNsChildTemp)
         {
            refreshView();
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(nsModel.selectedNsChildTemp)
         {
            nsModel.selectedNsChild = nsModel.getNsChildDataByJob(nsModel.selectedNsChildTemp.JobType);
         }
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            itemList[_loc1_].tempInfo = _loc1_ < nsModel.nsTempList.length ? nsModel.nsTempList[_loc1_] : null;
            if(itemList[_loc1_].tempInfo && itemList[_loc1_].tempInfo.JobType == nsModel.selectedNsChildTemp.JobType)
            {
               itemList[_loc1_].selected = true;
            }
            else
            {
               itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(itemVbox);
         itemVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


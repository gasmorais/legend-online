package alchemical.makeview
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.alchemical.AlchemicalModel;
   import utils.LogicUtils;
   import yishi.manager.AlchemicalManager;
   import yishi.utils.MsgMan;
   
   public class AlchemicalMakeBagView extends Component
   {
      
      private var list:SimpleTileList;
      
      private var bagScroll:ScrollPanel;
      
      private var defaultCount:int;
      
      private var rowCount:int;
      
      private var columnCount:int;
      
      private var itemList:Vector.<AlchemicalMakeBagCell>;
      
      public function AlchemicalMakeBagView(param1:int, param2:int)
      {
         super();
         rowCount = param1;
         columnCount = param2;
         defaultCount = rowCount * columnCount;
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         list = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeBagView.SimpleTileList",[columnCount]);
         bagScroll = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeBagView.equipStrengScroll");
         bagScroll.setView(list);
         addChild(bagScroll);
      }
      
      private function initListView() : void
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:AlchemicalMakeBagCell = null;
         if(rowCount > 0 && columnCount > 0)
         {
            _loc1_ = model.alchemicamlItemTempList;
            itemList = new Vector.<AlchemicalMakeBagCell>();
            list.beginChanges();
            _loc3_ = 0;
            while(_loc3_ < defaultCount)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeBagView.BagCell");
               list.addChild(_loc2_);
               _loc2_.tempInfo = _loc3_ < _loc1_.length ? _loc1_[_loc3_] : null;
               itemList.push(_loc2_);
               _loc3_++;
            }
            list.commitChanges();
            bagScroll.invalidateViewport();
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ALCHEMICAL_ITEM_UPDATE",this,__updateItemListHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ALCHEMICAL_ITEM_UPDATE",this,__updateItemListHandler);
      }
      
      private function __updateItemListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         if(!bagScroll || !bagScroll.viewPort)
         {
            return;
         }
         var _loc1_:Array = model.alchemicamlItemTempList;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            itemList[_loc3_].tempInfo = _loc3_ < _loc1_.length ? _loc1_[_loc3_] : null;
            _loc3_++;
         }
         bagScroll.invalidateViewport();
         var _loc2_:IntPoint = new IntPoint(0,0);
         bagScroll.viewPort.viewPosition = _loc2_;
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(list)
         {
            ObjectUtils.disposeObject(list);
         }
         list = null;
         if(bagScroll)
         {
            ObjectUtils.disposeObject(bagScroll);
         }
         bagScroll = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


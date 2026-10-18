package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import monster.item.MonsterListItem;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   
   public class MonsterListView extends Component
   {
      
      private var _itemBox:VBox;
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<MonsterListItem>;
      
      private var pageCount:int = 4;
      
      public function MonsterListView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("MonsterListView.itemBox");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("MonsterListView.pageBar");
         addChild(_itemBox);
         addChild(_pageBar);
      }
      
      private function initListView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:MonsterListItem = null;
         var _loc5_:Array = model.showMonsterList;
         setSelectMonster();
         var _loc3_:int = int(model.showMonsterList.indexOf(model.selectMonster));
         var _loc6_:int = _loc3_ == -1 ? 1 : int(_loc3_ / pageCount) + 1;
         _pageBar.setAutoPagingData(_loc5_,pageCount);
         _pageBar.setCurPage(_loc6_);
         var _loc1_:Array = _pageBar.getCurPageDatas();
         itemList = new Vector.<MonsterListItem>();
         _loc4_ = 0;
         while(_loc4_ < pageCount)
         {
            _loc2_ = new MonsterListItem();
            _itemBox.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _pageBar.addEventListener("change",_pageChangeHandler);
         MsgMan.addObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
         MsgMan.addObserver("MONSTER_EXPLORE_IDLIST",this,__updateSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         MsgMan.removeObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
         MsgMan.removeObserver("MONSTER_EXPLORE_IDLIST",this,__updateSelectHandler);
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshPageView();
      }
      
      private function __updateSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView(param1:Boolean = false) : void
      {
         var _loc2_:Array = model.showMonsterList;
         setSelectMonster();
         _pageBar.setAutoPagingData(_loc2_,pageCount);
         _pageBar.setCurPage(_pageBar.getCurPage(),false);
         refreshPageView();
      }
      
      private function refreshPageView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MonsterListItem = null;
         var _loc1_:Array = _pageBar.getCurPageDatas();
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = _loc1_.length > _loc3_ ? _loc1_[_loc3_] : null;
            if(_loc2_.data && model.selectMonster && _loc2_.data.monsterId == model.selectMonster.monsterId)
            {
               itemList[_loc3_].selected = true;
            }
            else
            {
               itemList[_loc3_].selected = false;
            }
            _loc3_++;
         }
      }
      
      private function setSelectMonster() : void
      {
         if(model.selectMonster)
         {
            return;
         }
         if(model.enterWarMonster)
         {
            model.selectMonster = model.enterWarMonster;
         }
         else if(model.showMonsterList.length > 0)
         {
            model.selectMonster = model.showMonsterList[0];
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


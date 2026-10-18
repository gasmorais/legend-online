package map.campaign.view.house
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.utils.WorldBossHelper;
   
   public class FurnitureTypeView extends Component
   {
      
      private static const NUM:int = 8;
      
      private var _showType:int;
      
      private var _current:int;
      
      private var _total:int;
      
      private var _group:SelectedButtonGroup;
      
      private var _box:SimpleTileList;
      
      private var _typeList:Vector.<int>;
      
      private var _preBtn:TextButton;
      
      private var _nextBtn:TextButton;
      
      public function FurnitureTypeView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _showType = 1;
         _current = 1;
         _total = 2;
         _typeList = new Vector.<int>();
         if(inHouse)
         {
            _typeList.push(1);
            _typeList.push(11);
            _typeList.push(2);
            _typeList.push(3);
            _typeList.push(4);
            _typeList.push(5);
            _typeList.push(6);
            _typeList.push(7);
            _typeList.push(8);
            _typeList.push(9);
            _typeList.push(10);
         }
         else if(inHome)
         {
            _typeList.push(1);
            _typeList.push(2);
            _typeList.push(3);
            _typeList.push(4);
            _typeList.push(5);
            _typeList.push(6);
         }
      }
      
      private function initView() : void
      {
         _box = ComponentFactory.Instance.creatCustomObject("FurnitureTypeView.box",[3]);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureTypeView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureTypeView.nextBtn");
         _group = new SelectedButtonGroup();
         addChild(_box);
         addChild(_preBtn);
         addChild(_nextBtn);
         _preBtn.text = LanguageMgr.GetTranslation("public.prePage");
         _nextBtn.text = LanguageMgr.GetTranslation("public.nextPage");
         refreshView();
      }
      
      private function unitView() : void
      {
         _typeList = null;
         if(_box)
         {
            _box.dispose();
         }
         _box = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
      }
      
      private function refreshView() : void
      {
         var _loc2_:SelectedTextButton = null;
         var _loc1_:int = 0;
         _box.disposeAllChildren();
         _group.removeAllItem();
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            if(_typeList.length > (_current - 1) * 8 + _loc1_)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("FurnitureTypeView.btn");
               if(inHouse)
               {
                  _loc2_.text = LanguageMgr.GetTranslation("house.FurnitureTypeView.FurnitureName" + _typeList[(_current - 1) * 8 + _loc1_]);
               }
               else if(inHome)
               {
                  _loc2_.text = LanguageMgr.GetTranslation("house.FurnitureTypeView.FurnitureName_" + _typeList[(_current - 1) * 8 + _loc1_]);
               }
               _box.addChild(_loc2_);
               _group.addSelectItem(_loc2_);
            }
            _loc1_++;
         }
         _preBtn.visible = _current > 1 && _typeList.length > 8;
         _nextBtn.visible = _current < _total && _typeList.length > 8;
         _group.selectIndex = 0;
         __selectedHandler(null);
      }
      
      private function initEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnHandler);
         }
         if(_group)
         {
            _group.addEventListener("change",__selectedHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
         }
         if(_group)
         {
            _group.removeEventListener("change",__selectedHandler);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         if(_group)
         {
            _showType = _typeList[(_current - 1) * 8 + _group.selectIndex];
            dispatchEvent(new Event("change"));
         }
      }
      
      private function __preBtnHandler(param1:MouseEvent) : void
      {
         if(_current > 1)
         {
            _current -= 1;
         }
         refreshView();
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         if(_current < _total)
         {
            _current += 1;
         }
         refreshView();
      }
      
      public function get showType() : int
      {
         return _showType;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}


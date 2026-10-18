package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class HeroRoadItemView extends Component
   {
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _itemList:Array = [];
      
      private var _index:int;
      
      public function HeroRoadItemView()
      {
         super();
         initView();
         initEvent();
         _selectedBtnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:HeroRoadTopButton = null;
         var _loc1_:StripView = null;
         _selectedBtnGroup = new SelectedButtonGroup();
         var _loc6_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.isChangeJob ? 80 + thane.vocationGrades : thane.vocationGrades);
         var _loc2_:Array = [HeroRoadManager.MASTER_GROW,HeroRoadManager.MASTER_EXPL,HeroRoadManager.MASTER_PETS,HeroRoadManager.MASTER_CHILD,HeroRoadManager.MASTER_OTHER,HeroRoadManager.MASTER_ADVANCED];
         _loc4_ = 1;
         while(_loc4_ <= 6)
         {
            _loc5_ = int(_loc2_[_loc4_ - 1]);
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("heroroad.heroRoadTopButton" + _loc5_);
            addChild(_loc7_);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("heroroad.topStrip" + _loc5_);
            addChild(_loc1_);
            _loc1_.visible = false;
            _loc1_.setHitArea(0,0,67,64);
            _selectedBtnGroup.addSelectItem(_loc7_);
            if(HeroRoadManager.instance.hasTaskData(_loc5_))
            {
               _loc3_ = int(HeroRoadManager.instance.getMinLevelByMasterType(_loc5_));
               if(thane.grades + _loc6_ < _loc3_)
               {
                  _loc7_.enable = false;
                  _loc1_.visible = true;
                  if(_loc3_ > 80)
                  {
                     _loc1_.tipData = LanguageMgr.GetTranslation("runeitemView.tip02");
                  }
                  else
                  {
                     _loc1_.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",_loc3_);
                  }
               }
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         __updateViewHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:HeroRoadItem = null;
         while(_itemList.length)
         {
            ObjectUtils.disposeObject(_itemList.pop());
         }
         if(_index == 5)
         {
            _loc2_ = HeroRoadManager.instance.getItemsByMasterType(HeroRoadManager.MASTER_ADVANCED);
         }
         else
         {
            _loc2_ = HeroRoadManager.instance.getItemsByMasterType(_index + 1);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new HeroRoadItem();
            _loc3_.x = -186 + _loc4_ * 178;
            _loc3_.y = 68;
            _loc3_.data = _loc2_[_loc4_];
            addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         _index = _selectedBtnGroup.selectIndex;
         __updateViewHandler(null);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}


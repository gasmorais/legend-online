package thessbox.view
{
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.storehouse.StoreHouseAddSkillMsg;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import thessbox.ui.ThessBoxAddNUI;
   import thessbox.ui.ThessboxChooseUI;
   
   public class ThessBoxChooseView extends ThessboxChooseUI
   {
      
      private var _data:StoreHouseAddSkillMsg;
      
      private var _tab:SelectedButtonGroup;
      
      public function ThessBoxChooseView()
      {
         super();
         _tab = new SelectedButtonGroup();
         _desTxt.text = LanguageMgr.GetTranslation("thessbox.threeOfOne");
      }
      
      public function set data(param1:StoreHouseAddSkillMsg) : void
      {
         _data = param1;
         if(_data)
         {
            _addNSK1.data = _data.addSkills[0];
            _addNSK2.data = _data.addSkills[1];
            _addNSK3.data = _data.addSkills[2];
            _tab.addSelectItem(_addNSK1);
            _tab.addSelectItem(_addNSK2);
            _tab.addSelectItem(_addNSK3);
            _tab.selectIndex = 0;
            initEvent();
         }
      }
      
      private function initEvent() : void
      {
         _comfrimBtn.addEventListener("click",comfrimHandler);
      }
      
      private function removeEvent() : void
      {
         _comfrimBtn.removeEventListener("click",comfrimHandler);
      }
      
      private function comfrimHandler(param1:MouseEvent) : void
      {
         var _loc2_:ThessBoxAddNUI = _tab.getSelectedItem() as ThessBoxAddNUI;
         if(_loc2_.data > 0)
         {
            TheseussoulManager.Instance.opThessbox(3,_loc2_.data);
         }
         _comfrimBtn.enable = false;
      }
      
      public function getFlyPoint() : Point
      {
         var _loc2_:ThessBoxAddNUI = _tab.getSelectedItem() as ThessBoxAddNUI;
         return this.localToGlobal(new Point(_loc2_.x,_loc2_.y));
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tab);
         _tab = null;
         super.dispose();
         _data = null;
      }
   }
}


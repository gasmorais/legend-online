package buildings.seminary.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class InternalTechnologyList extends Sprite implements Disposeable
   {
      
      public static var itemGroup:SelectedButtonGroup = new SelectedButtonGroup();
      
      protected var _firstBuild:BuildInfo;
      
      private var _activeList:SimpleDictionary;
      
      private var _itemList:Dictionary;
      
      private var _length:int;
      
      private var _row:int;
      
      private var _column:int;
      
      public function InternalTechnologyList()
      {
         super();
         if(!itemGroup)
         {
            itemGroup = new SelectedButtonGroup();
         }
         init();
      }
      
      protected function init() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BuildInfo = null;
         var _loc4_:BuildingTempInfo = null;
         _itemList = new Dictionary();
         _activeList = BuildingManager.instance.model.buildingListByID;
         var _loc1_:Array = _activeList.getList();
         _loc1_.sortOn("sonType");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as BuildInfo;
            _loc4_ = _loc2_.templeteInfo;
            if(_loc4_.MasterType == 13)
            {
               addInterTecItem(_loc2_);
            }
            _loc3_++;
         }
         _loc1_ = null;
      }
      
      public function addInterTecItem(param1:BuildInfo) : void
      {
         var _loc2_:TechnologyItem = ComponentFactory.Instance.creatCustomObject("seminary.TechnologyItem");
         _loc2_.data = param1;
         _row = _length / 4;
         _column = _length % 4;
         _loc2_.x = _column * 87 + 21;
         _loc2_.y = _row * 105 + 8;
         addChild(_loc2_);
         itemGroup.addSelectItem(_loc2_);
         _itemList[param1.sonType] = _loc2_;
         _length = _length + 1;
         if(!_firstBuild)
         {
            _firstBuild = param1;
         }
      }
      
      private function unit() : void
      {
         for each(var _loc1_:TechnologyItem in _itemList)
         {
            _loc1_.dispose();
         }
         if(itemGroup)
         {
            itemGroup.dispose();
            itemGroup = null;
         }
         _itemList = null;
         _activeList = null;
      }
      
      public function dispose() : void
      {
         unit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function getTechnologyTemplates() : Array
      {
         return TempleteManager.instance.buildTemplateCate.getInternalTechnologyTemplates();
      }
      
      public function get itemList() : Dictionary
      {
         return _itemList;
      }
      
      public function get firstBuild() : BuildInfo
      {
         return _firstBuild;
      }
   }
}


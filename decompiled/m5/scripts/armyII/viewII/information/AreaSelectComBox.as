package armyII.viewII.information
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.SNSManager;
   import mvc.module.sns.SNSModel;
   import yishi.filter.UIFilter;
   
   public class AreaSelectComBox extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _countryComBox:ComboBox;
      
      private var _provinceComBox:ComboBox;
      
      private var _cityComBox:ComboBox;
      
      private var _townComBox:ComboBox;
      
      private var _uiFilter:UIFilter;
      
      private var _defaultObj:Object;
      
      public function AreaSelectComBox()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("armyII.AreaSelectComBoxBg");
         _countryComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.AreaSelectCountryComBox");
         _provinceComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.AreaSelectProvinceComBox");
         _cityComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.AreaSelectCityComBox");
         _townComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.AreaSelectTownComBox");
         _townComBox.mouseChildren = false;
         _uiFilter = new UIFilter();
         _uiFilter.setGrayFilter(_townComBox);
         addChild(_bg);
         addChild(_countryComBox);
         addChild(_provinceComBox);
         addChild(_cityComBox);
         addChild(_townComBox);
      }
      
      private function addEvent() : void
      {
         _countryComBox.listPanel.list.addEventListener("listItemClick",__countrySelectedHandler);
         _provinceComBox.listPanel.list.addEventListener("listItemClick",__provinceSelectedHandler);
         _cityComBox.listPanel.list.addEventListener("listItemClick",__citySelectedHandler);
      }
      
      private function removeEvent() : void
      {
         _countryComBox.listPanel.list.removeEventListener("listItemClick",__countrySelectedHandler);
         _provinceComBox.listPanel.list.removeEventListener("listItemClick",__provinceSelectedHandler);
         _cityComBox.listPanel.list.removeEventListener("listItemClick",__citySelectedHandler);
      }
      
      private function __countrySelectedHandler(param1:ListItemEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = param1.cellValue as Object;
         _provinceComBox.listPanel.vectorListModel.clear();
         _provinceComBox.listPanel.vectorListModel.append(_defaultObj);
         if(_loc2_ && int(_loc2_["id"]) > 0 && snsManager.model.provinceList[_loc2_["id"]])
         {
            _loc3_ = snsManager.model.provinceList[_loc2_["id"]];
            for each(var _loc4_:Object in _loc3_)
            {
               _provinceComBox.listPanel.vectorListModel.append(_loc4_);
            }
         }
         _provinceComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
      }
      
      private function __provinceSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = param1.cellValue as Object;
         _cityComBox.listPanel.vectorListModel.clear();
         _cityComBox.listPanel.vectorListModel.append(_defaultObj);
         if(_loc2_ && int(_loc2_["id"]) > 0 && snsManager.model.cityList[_loc2_["id"]])
         {
            _loc4_ = snsManager.model.cityList[_loc2_["id"]];
            for each(var _loc3_:Object in _loc4_)
            {
               _cityComBox.listPanel.vectorListModel.append(_loc3_);
            }
         }
         _cityComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
      }
      
      private function __citySelectedHandler(param1:ListItemEvent) : void
      {
      }
      
      private function get snsManager() : SNSManager
      {
         return SNSManager.instance;
      }
      
      private function get snsModel() : SNSModel
      {
         return SNSManager.instance.model;
      }
      
      public function get countryComBox() : ComboBox
      {
         return _countryComBox;
      }
      
      public function get provinceComBox() : ComboBox
      {
         return _provinceComBox;
      }
      
      public function get cityComBox() : ComboBox
      {
         return _cityComBox;
      }
      
      public function get curSelectedCountry() : *
      {
         return _countryComBox.currentSelectedCellValue;
      }
      
      public function get curSelectedProvince() : *
      {
         return _provinceComBox.currentSelectedCellValue;
      }
      
      public function get curSelectedCity() : *
      {
         return _cityComBox.currentSelectedCellValue;
      }
      
      public function initComBox() : void
      {
         _defaultObj = {
            "id":0,
            "name":LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.pleaseChoose")
         };
         _countryComBox.listPanel.vectorListModel.append(_defaultObj);
         _provinceComBox.listPanel.vectorListModel.append(_defaultObj);
         _cityComBox.listPanel.vectorListModel.append(_defaultObj);
         _townComBox.listPanel.vectorListModel.append(_defaultObj);
         for each(var _loc1_:Object in snsManager.model.countryList)
         {
            _countryComBox.listPanel.vectorListModel.append(_loc1_);
         }
         _countryComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
         _provinceComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
         _cityComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
         _townComBox.listPanel.list.defaultSelectItemByCellValue = _defaultObj;
      }
      
      public function getArea() : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc1_:String = null;
         var _loc2_:Object = _countryComBox.currentSelectedCellValue as Object;
         var _loc3_:Object = _provinceComBox.currentSelectedCellValue as Object;
         var _loc6_:Object = _cityComBox.currentSelectedCellValue as Object;
         if(_loc2_ && _loc2_["id"] > 0)
         {
            _loc4_ = _loc2_["name"];
            _loc5_ = _loc3_ && _loc3_["id"] > 0 ? _loc3_["name"] : "";
            _loc1_ = _loc6_ && _loc6_["id"] > 0 ? _loc6_["name"] : "";
            return _loc4_ + " " + _loc5_ + " " + _loc1_;
         }
         return LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.pleaseChoose");
      }
      
      public function setArea(param1:int, param2:int, param3:int) : void
      {
         if(param1 > 0)
         {
            _countryComBox.listPanel.list.defaultSelectItemByCellValue = snsModel.getCountryObj(param1);
            _provinceComBox.listPanel.list.defaultSelectItemByCellValue = param2 > 0 ? snsModel.getProvinceObj(param2) : _defaultObj;
            _cityComBox.listPanel.list.defaultSelectItemByCellValue = param3 > 0 ? snsModel.getCityObj(param3) : _defaultObj;
         }
         else
         {
            reset();
         }
      }
      
      public function isTargetOrContain(param1:DisplayObject) : Boolean
      {
         if(DisplayUtils.isTargetOrContain(param1,this) || Boolean(DisplayUtils.isTargetOrContain(param1,_countryComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(param1,_provinceComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(param1,_cityComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(param1,_townComBox.listPanel)))
         {
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         _countryComBox.listPanel.selectFirst();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_countryComBox)
         {
            _countryComBox.dispose();
         }
         _countryComBox = null;
         if(_provinceComBox)
         {
            _provinceComBox.dispose();
         }
         _provinceComBox = null;
         if(_cityComBox)
         {
            _cityComBox.dispose();
         }
         _cityComBox = null;
         if(_townComBox)
         {
            _townComBox.filters = null;
            _townComBox.dispose();
            _townComBox = null;
         }
         _uiFilter = null;
         _defaultObj = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


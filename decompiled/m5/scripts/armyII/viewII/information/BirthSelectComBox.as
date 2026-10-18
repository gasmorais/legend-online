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
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class BirthSelectComBox extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _yearComBox:ComboBox;
      
      private var _monthComBox:ComboBox;
      
      private var _dayComBox:ComboBox;
      
      private var _defaultStr:String;
      
      public function BirthSelectComBox()
      {
         super();
         initView();
         initComBox();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("armyII.BirthSelectComBoxBg");
         _yearComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.BirthSelectYearComBox");
         _monthComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.BirthSelectMonthComBox");
         _dayComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.BirthSelectDayComBox");
         addChild(_bg);
         addChild(_yearComBox);
         addChild(_monthComBox);
         addChild(_dayComBox);
      }
      
      private function initComBox() : void
      {
         var _loc1_:int = 0;
         _defaultStr = LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.pleaseChoose");
         _yearComBox.listPanel.vectorListModel.append(_defaultStr);
         _monthComBox.listPanel.vectorListModel.append(_defaultStr);
         _dayComBox.listPanel.vectorListModel.append(_defaultStr);
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.fullYear);
         _loc1_ = _loc2_;
         while(_loc1_ >= 1950)
         {
            _yearComBox.listPanel.vectorListModel.append(String(_loc1_));
            _loc1_--;
         }
         _yearComBox.listPanel.list.defaultSelectItemByCellValue = _defaultStr;
         _monthComBox.listPanel.list.defaultSelectItemByCellValue = _defaultStr;
         _dayComBox.listPanel.list.defaultSelectItemByCellValue = _defaultStr;
      }
      
      private function addEvent() : void
      {
         _yearComBox.listPanel.list.addEventListener("listItemClick",__yearSelectedHandler);
         _monthComBox.listPanel.list.addEventListener("listItemClick",__monthSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         _yearComBox.listPanel.list.removeEventListener("listItemClick",__yearSelectedHandler);
         _monthComBox.listPanel.list.removeEventListener("listItemClick",__monthSelectedHandler);
      }
      
      private function __yearSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(param1.cellValue);
         _monthComBox.listPanel.vectorListModel.clear();
         if(_loc3_ && _loc3_ > 0)
         {
            _loc2_ = 1;
            while(_loc2_ <= 12)
            {
               _monthComBox.listPanel.vectorListModel.append(String(_loc2_));
               _loc2_++;
            }
            _monthComBox.listPanel.selectFirst();
         }
         else
         {
            _monthComBox.listPanel.vectorListModel.append(_defaultStr);
            _monthComBox.listPanel.list.defaultSelectItemByCellValue = _defaultStr;
         }
      }
      
      private function __monthSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = int(param1.cellValue);
         _dayComBox.listPanel.vectorListModel.clear();
         if(_loc3_ && _loc3_ > 0)
         {
            _loc4_ = int(DateFormatter.getMonthMaxDay(_loc3_ - 1,int(_yearComBox.currentSelectedCellValue)));
            _loc2_ = 1;
            while(_loc2_ <= _loc4_)
            {
               _dayComBox.listPanel.vectorListModel.append(String(_loc2_));
               _loc2_++;
            }
            _dayComBox.listPanel.selectFirst();
         }
         else
         {
            _dayComBox.listPanel.vectorListModel.append(_defaultStr);
            _dayComBox.listPanel.list.defaultSelectItemByCellValue = _defaultStr;
         }
      }
      
      public function get yearComBox() : ComboBox
      {
         return _yearComBox;
      }
      
      public function get monthComBox() : ComboBox
      {
         return _monthComBox;
      }
      
      public function get dayComBox() : ComboBox
      {
         return _dayComBox;
      }
      
      public function get curSelectedYear() : *
      {
         return _yearComBox.currentSelectedCellValue;
      }
      
      public function get curSelectedMonth() : *
      {
         return _monthComBox.currentSelectedCellValue;
      }
      
      public function get curSelectedDay() : *
      {
         return _dayComBox.currentSelectedCellValue;
      }
      
      public function getBirth(param1:String) : String
      {
         var _loc4_:int = int(_yearComBox.currentSelectedCellValue);
         var _loc2_:int = int(_monthComBox.currentSelectedCellValue);
         var _loc3_:int = int(_dayComBox.currentSelectedCellValue);
         if(_loc4_ > 0 && _loc2_ > 0 && _loc3_ > 0)
         {
            return LanguageMgr.GetTranslation(param1,_loc4_,_loc2_,_loc3_);
         }
         return LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.pleaseChoose");
      }
      
      public function setBirth(param1:int, param2:int, param3:int) : void
      {
         if(param1 > 0 && param2 > 0 && param3 > 0)
         {
            _yearComBox.listPanel.list.defaultSelectItemByCellValue = String(param1);
            _monthComBox.listPanel.list.defaultSelectItemByCellValue = String(param2);
            _dayComBox.listPanel.list.defaultSelectItemByCellValue = String(param3);
         }
         else
         {
            reset();
         }
      }
      
      public function isTargetOrContain(param1:DisplayObject) : Boolean
      {
         if(DisplayUtils.isTargetOrContain(param1,this) || Boolean(DisplayUtils.isTargetOrContain(param1,_yearComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(param1,_monthComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(param1,_dayComBox.listPanel)))
         {
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         _yearComBox.listPanel.selectFirst();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_yearComBox)
         {
            _yearComBox.dispose();
         }
         _yearComBox = null;
         if(_monthComBox)
         {
            _monthComBox.dispose();
         }
         _monthComBox = null;
         if(_dayComBox)
         {
            _dayComBox.dispose();
         }
         _dayComBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


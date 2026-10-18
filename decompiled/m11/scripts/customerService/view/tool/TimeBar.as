package customerService.view.tool
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import yishi.manager.PlayerManager;
   
   public class TimeBar extends Sprite implements Disposeable
   {
      
      private static const BIG_YEAR:Array = [31,29,31,30,31,30,31,31,30,31,30,31];
      
      private static const SMALL_YEAR:Array = [31,28,31,30,31,30,31,31,30,31,30,31];
      
      private var yearComBox:ComboBox;
      
      private var yearTxt:Bitmap;
      
      private var monthComBox:ComboBox;
      
      private var monthTxt:Bitmap;
      
      private var dayComBox:ComboBox;
      
      private var dayTxt:Bitmap;
      
      private var _dataList:Dictionary;
      
      private var _yearList:Vector.<Object>;
      
      private var _monthList:Vector.<Object>;
      
      private var _dayList:Vector.<Object>;
      
      private var yearNumber:Number;
      
      private var monthNumber:Number;
      
      private var dayNumber:Number;
      
      private var baseYear:Number;
      
      public function TimeBar()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      public function set dataList(param1:Dictionary) : void
      {
         _dataList = param1;
         refreshBar();
      }
      
      private function initView() : void
      {
         yearComBox = ComponentFactory.Instance.creatComponentByStylename("customerservice.TimeComboBox_year");
         yearTxt = ComponentFactory.Instance.creatBitmap("asset.customerservice.YearTxt");
         monthComBox = ComponentFactory.Instance.creatComponentByStylename("customerservice.TimeComboBox_month");
         monthTxt = ComponentFactory.Instance.creatBitmap("asset.customerservice.MonthTxt");
         dayComBox = ComponentFactory.Instance.creatComponentByStylename("customerservice.TimeComboBox_day");
         dayTxt = ComponentFactory.Instance.creatBitmap("asset.customerservice.DayTxt");
         refreshBar();
         addChild(yearComBox);
         addChild(yearTxt);
         addChild(monthComBox);
         addChild(monthTxt);
         addChild(dayComBox);
         addChild(dayTxt);
      }
      
      private function refreshBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         yearComBox.listPanel.vectorListModel.removeRange(0,yearComBox.listPanel.vectorListModel.elements.length);
         monthComBox.listPanel.vectorListModel.removeRange(0,monthComBox.listPanel.vectorListModel.elements.length);
         dayComBox.listPanel.vectorListModel.removeRange(0,dayComBox.listPanel.vectorListModel.elements.length);
         _loc1_ = 0;
         while(_loc1_ < _yearList.length)
         {
            yearComBox.listPanel.vectorListModel.append(_yearList[_loc1_]);
            _loc1_++;
         }
         yearComBox.listPanel.list.defaultSelectItemByCellValue = _yearList[0];
         _loc2_ = 0;
         while(_loc2_ < _monthList.length)
         {
            monthComBox.listPanel.vectorListModel.append(_monthList[_loc2_]);
            _loc2_++;
         }
         monthComBox.listPanel.list.defaultSelectItemByCellValue = _monthList[0];
         _loc3_ = 0;
         while(_loc3_ < _dayList.length)
         {
            dayComBox.listPanel.vectorListModel.append(_dayList[_loc3_]);
            _loc3_++;
         }
         dayComBox.listPanel.list.defaultSelectItemByCellValue = _dayList[0];
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         baseYear = PlayerManager.instance.currentPlayerModel.sysCurtime.fullYear - 1;
         _yearList = new Vector.<Object>();
         _monthList = new Vector.<Object>();
         _dayList = new Vector.<Object>();
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _monthList.push({
               "id":_loc1_,
               "name":(_loc1_ + 1).toString()
            });
            _yearList.push({
               "id":_loc1_,
               "name":(_loc1_ + baseYear).toString()
            });
            _loc1_++;
         }
         yearNumber = baseYear + 1;
         monthNumber = 1;
         dayNumber = 1;
         updateDayList(yearNumber,1);
      }
      
      private function refreshDayCombox() : void
      {
         var _loc1_:int = 0;
         dayComBox.listPanel.vectorListModel.removeRange(0,dayComBox.listPanel.vectorListModel.elements.length);
         _loc1_ = 0;
         while(_loc1_ < _dayList.length)
         {
            dayComBox.listPanel.vectorListModel.append(_dayList[_loc1_]);
            _loc1_++;
         }
         dayComBox.listPanel.list.defaultSelectItemByCellValue = _dayList[0];
      }
      
      public function updateDayList(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         _dayList.length = 0;
         _loc3_ = 0;
         while(_loc3_ < getDayNumber(param1,param2))
         {
            _dayList.push({
               "id":_loc3_,
               "name":_loc3_ + 1
            });
            _loc3_++;
         }
      }
      
      private function yearChangeHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("022");
         yearNumber = parseInt(yearComBox.currentSelectedCellValue.name);
         if(getDayNumber(yearNumber,monthNumber) != _dayList.length)
         {
            updateDayList(yearNumber,monthNumber);
            refreshDayCombox();
         }
      }
      
      private function monthChangeHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("022");
         monthNumber = parseInt(monthComBox.currentSelectedCellValue.name);
         if(getDayNumber(yearNumber,monthNumber) != _dayList.length)
         {
            updateDayList(yearNumber,monthNumber);
            refreshDayCombox();
         }
      }
      
      private function dayChangeHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("022");
         dayNumber = parseInt(dayComBox.currentSelectedCellValue.name);
      }
      
      private function _clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function initEvent() : void
      {
         yearComBox.addEventListener("stateChange",yearChangeHandler);
         monthComBox.addEventListener("stateChange",monthChangeHandler);
         dayComBox.addEventListener("stateChange",dayChangeHandler);
         yearComBox.button.addEventListener("click",_clickHandler);
         monthComBox.button.addEventListener("click",_clickHandler);
         dayComBox.button.addEventListener("click",_clickHandler);
      }
      
      private function removeEvent() : void
      {
         yearComBox.removeEventListener("stateChange",yearChangeHandler);
         monthComBox.removeEventListener("stateChange",monthChangeHandler);
         dayComBox.removeEventListener("stateChange",dayChangeHandler);
         yearComBox.button.removeEventListener("click",_clickHandler);
         monthComBox.button.removeEventListener("click",_clickHandler);
         dayComBox.button.removeEventListener("click",_clickHandler);
      }
      
      public function set date(param1:Date) : void
      {
         yearNumber = param1.getFullYear();
         yearComBox.listPanel.list.defaultSelectItemByCellValue = _yearList[yearNumber - baseYear];
         monthNumber = param1.getMonth() + 1;
         monthComBox.listPanel.list.defaultSelectItemByCellValue = _monthList[monthNumber - 1];
         dayNumber = param1.getDate();
         dayComBox.listPanel.list.defaultSelectItemByCellValue = _dayList[dayNumber - 1];
      }
      
      public function get date() : Date
      {
         return new Date(yearNumber,monthNumber,dayNumber);
      }
      
      private function getDayNumber(param1:int, param2:int) : int
      {
         if(param1 % 4 == 0 && param1 % 100 !== 0 || param1 % 400 == 0)
         {
            return BIG_YEAR[param2 - 1];
         }
         return SMALL_YEAR[param2 - 1];
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(yearComBox);
         yearComBox = null;
         ObjectUtils.disposeObject(monthComBox);
         monthComBox = null;
         ObjectUtils.disposeObject(dayComBox);
         dayComBox = null;
         ObjectUtils.disposeObject(yearTxt);
         yearTxt = null;
         ObjectUtils.disposeObject(monthTxt);
         monthTxt = null;
         ObjectUtils.disposeObject(dayTxt);
         dayTxt = null;
         _dataList = null;
         _yearList = null;
         _monthList = null;
         _dayList = null;
      }
   }
}


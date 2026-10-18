package appell.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import managers.AppellSocketOutManager;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.manager.ArmyManager;
   import yishi.utils.MsgMan;
   
   public class AppellItem extends Component implements ISelectable, IListCell
   {
      
      private var _overBg:Scale9CornerImage;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var _title:GradientText;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      private var _data:AppellInfoTemplate;
      
      private var _appellId:int;
      
      protected var _selected:Boolean;
      
      public function AppellItem()
      {
         super();
         initView();
         initEvents();
         _colorMatrix = [0.41,0.34,0.05,0,12.7,0.17,0.58,0.05,0,12.7,0.17,0.34,0.29,0,12.7,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatComponentByStylename("appellItem.overBg");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("appellItem.selectBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("appellItem.title");
         addChild(_overBg);
         addChild(_selectBtn);
         addChild(_title);
         _overBg.visible = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__equipBtnClickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("click",__equipBtnClickHandler);
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __equipBtnClickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _selectBtn)
         {
            if(_appellId != ArmyManager.instance.thane.appellId)
            {
               AppellSocketOutManager.exchangeAppell(_appellId);
            }
         }
         MsgMan.notifyObserver("showAppell",_data);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_selected)
         {
            return;
         }
         _overBg.visible = true;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_selected)
         {
            return;
         }
         _overBg.visible = false;
      }
      
      private function clean() : void
      {
         _selectBtn.selected = false;
         _title.text = "";
      }
      
      private function setEquip(param1:Boolean) : void
      {
         _selectBtn.selected = param1;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _overBg.visible = param1;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as AppellInfoTemplate;
         clean();
         var _loc2_:Boolean = ArmyManager.instance.thane.appellId == _data.TemplateId;
         setEquip(_loc2_);
         if(_data)
         {
            _appellId = _data.TemplateId;
            _title.text = doFilterStr(_data.Title,6);
            if(!_data.isGet)
            {
               filters = [_colorFilter];
               _selectBtn.enable = false;
            }
            else
            {
               filters = null;
               _selectBtn.enable = true;
            }
         }
      }
      
      private function doFilterStr(param1:String, param2:int) : String
      {
         var _loc3_:int = param2;
         var _loc5_:Boolean = false;
         if(_loc3_ > param1.length)
         {
            _loc3_ = param1.length;
         }
         else
         {
            _loc5_ = true;
         }
         var _loc4_:String = param1.substr(0,_loc3_);
         if(_loc5_)
         {
            _loc4_ += "...";
         }
         return _loc4_;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         uintView();
         super.dispose();
      }
   }
}


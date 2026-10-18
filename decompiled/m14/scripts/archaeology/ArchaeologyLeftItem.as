package archaeology
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyItemInfo;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.TempleteManager;
   
   public class ArchaeologyLeftItem extends SelectedTextButton implements IListCell
   {
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_numberStyle:String = "numberStyle";
      
      private var _iconStyle:String;
      
      private var _numberStyle:String;
      
      private var _numberTxt:FilterFrameText;
      
      private var _icon:ScaleFrameImage;
      
      private var _data:ArchaeologyItemInfo;
      
      private var _select:Boolean = false;
      
      private var _list:List;
      
      public function ArchaeologyLeftItem()
      {
         super();
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(_iconStyle == param1)
         {
            return;
         }
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set numberStyle(param1:String) : void
      {
         if(_numberStyle == param1)
         {
            return;
         }
         _numberStyle = param1;
         onPropertiesChanged("numberStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_numberTxt)
         {
            addChild(_numberTxt);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatComponentByStylename(_iconStyle);
         }
         if(_changedPropeties["numberStyle"])
         {
            _numberTxt = ComponentFactory.Instance.creatComponentByStylename(_numberStyle);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as ArchaeologyItemInfo;
         if(_data)
         {
            updateView();
         }
         else
         {
            if(_textField)
            {
               _textField["text"] = "";
            }
            if(_numberTxt)
            {
               _numberTxt.text = "";
            }
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:ArchaeologyItemTemplate = null;
         if(_textField)
         {
            _textField["text"] = "";
         }
         if(!_data)
         {
            return;
         }
         if(_data.cellType == 1)
         {
            if(_textField)
            {
               _textField["text"] = LanguageMgr.GetTranslation("archaeology.leftItem.typeName" + _data.groupId);
            }
            iconVisible = true;
         }
         else
         {
            _loc1_ = TempleteManager.instance.archaeologyItemTemplateCate.getTemplateByID(_data.tempId);
            if(_textField && _loc1_)
            {
               _textField["text"] = _loc1_.Name;
            }
            iconVisible = false;
         }
         _numberTxt.text = canMakeCount;
         selectedView = selected;
      }
      
      private function setNameFrame(param1:int) : void
      {
         if(_data.cellType == 1)
         {
            if(_textField)
            {
               (_textField as FilterFrameText).setFrame(param1);
            }
         }
         else if(_textField)
         {
            (_textField as FilterFrameText).setFrame(param1 + 3);
         }
         if(_numberTxt)
         {
            if(param1 == 4)
            {
               _numberTxt.setFrame(1);
            }
            else
            {
               _numberTxt.setFrame(param1);
            }
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _list = param1;
         _select = param2;
      }
      
      override public function get selected() : Boolean
      {
         return _data && _data.selected;
      }
      
      override public function set selected(param1:Boolean) : void
      {
      }
      
      private function set selectedView(param1:Boolean) : void
      {
         if(_selectedButton)
         {
            _selectedButton.visible = selected;
         }
         if(_unSelectedButton)
         {
            _unSelectedButton.visible = !selected;
         }
         if(selected)
         {
            setNameFrame(3);
         }
         else if(canMakeCount)
         {
            setNameFrame(2);
         }
         else if(isActive)
         {
            setNameFrame(1);
         }
         else
         {
            setNameFrame(4);
         }
         setIconFrame();
      }
      
      private function setIconFrame() : void
      {
         if(_icon)
         {
            selected ? _icon.setFrame(2) : _icon.setFrame(1);
         }
      }
      
      private function set iconVisible(param1:Boolean) : void
      {
         if(_icon)
         {
            if(param1)
            {
               setIconFrame();
               addChild(_icon);
            }
            else if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
         }
      }
      
      private function get canMakeCount() : String
      {
         if(!_data)
         {
            return "";
         }
         if(_data.canMakeCount <= 0)
         {
            return "";
         }
         return " (" + _data.canMakeCount + ")";
      }
      
      private function get isActive() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(!_data.cellType == 1)
         {
            return true;
         }
         if(ArchaeologyManager.instance.model.getGoodItemStateById(_data.tempId) == 1)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(_numberTxt)
         {
            ObjectUtils.disposeObject(_numberTxt);
         }
         _numberTxt = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         _data = null;
         super.dispose();
      }
   }
}


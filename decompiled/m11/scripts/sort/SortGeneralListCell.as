package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.sort.SortData;
   import yishi.utils.MoneyUtils;
   
   public class SortGeneralListCell extends Sprite implements IListCell, Disposeable
   {
      
      public static const TYPE_WARLORDS:int = 1;
      
      private var _disObj1:DisplayObject;
      
      private var _disObj2:DisplayObject;
      
      private var _disObj3:DisplayObject;
      
      private var _disObj4:DisplayObject;
      
      private var _disObj5:DisplayObject;
      
      private var _disObj6:DisplayObject;
      
      private var _disObj7:DisplayObject;
      
      private var _disObj8:DisplayObject;
      
      private var _disObj9:DisplayObject;
      
      private var _disObj10:DisplayObject;
      
      private var _disObj11:DisplayObject;
      
      private var _disObj12:DisplayObject;
      
      private var _disObj13:DisplayObject;
      
      private var _first:Boolean = true;
      
      private var _selected:Boolean;
      
      private var _cellType:int;
      
      private var _data:SortData;
      
      public function SortGeneralListCell()
      {
         super();
         addEvent();
      }
      
      public function get cellType() : int
      {
         return _cellType;
      }
      
      public function set cellType(param1:int) : void
      {
         _cellType = param1;
      }
      
      public function set disObjStyle1(param1:String) : void
      {
         if(_disObj1)
         {
            ObjectUtils.disposeObject(_disObj1);
         }
         _disObj1 = null;
         _disObj1 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj1);
      }
      
      public function set disObjStyle2(param1:String) : void
      {
         if(_disObj2)
         {
            ObjectUtils.disposeObject(_disObj2);
         }
         _disObj2 = null;
         _disObj2 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj2);
      }
      
      public function set disObjStyle3(param1:String) : void
      {
         if(_disObj3)
         {
            ObjectUtils.disposeObject(_disObj3);
         }
         _disObj3 = null;
         _disObj3 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj3);
      }
      
      public function set disObjStyle4(param1:String) : void
      {
         if(_disObj4)
         {
            ObjectUtils.disposeObject(_disObj4);
         }
         _disObj4 = null;
         _disObj4 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj4);
      }
      
      public function set disObjStyle5(param1:String) : void
      {
         if(_disObj5)
         {
            ObjectUtils.disposeObject(_disObj5);
         }
         _disObj5 = null;
         _disObj5 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj5);
      }
      
      public function set disObjStyle6(param1:String) : void
      {
         if(_disObj6)
         {
            ObjectUtils.disposeObject(_disObj6);
         }
         _disObj6 = null;
         _disObj6 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj6);
      }
      
      public function set disObjStyle7(param1:String) : void
      {
         if(_disObj7)
         {
            ObjectUtils.disposeObject(_disObj7);
         }
         _disObj7 = null;
         _disObj7 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj7);
      }
      
      public function set disObjStyle8(param1:String) : void
      {
         if(_disObj8)
         {
            ObjectUtils.disposeObject(_disObj8);
         }
         _disObj8 = null;
         _disObj8 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj8);
      }
      
      public function set disObjStyle9(param1:String) : void
      {
         if(_disObj9)
         {
            ObjectUtils.disposeObject(_disObj9);
         }
         _disObj9 = null;
         _disObj9 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj9);
      }
      
      public function set disObjStyle10(param1:String) : void
      {
         if(_disObj10)
         {
            ObjectUtils.disposeObject(_disObj10);
         }
         _disObj10 = null;
         _disObj10 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj10);
      }
      
      public function set disObjStyle11(param1:String) : void
      {
         if(_disObj11)
         {
            ObjectUtils.disposeObject(_disObj11);
         }
         _disObj11 = null;
         _disObj11 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj11);
      }
      
      public function set disObjStyle12(param1:String) : void
      {
         if(_disObj12)
         {
            ObjectUtils.disposeObject(_disObj12);
         }
         _disObj12 = null;
         _disObj12 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj12);
      }
      
      public function set disObjStyle13(param1:String) : void
      {
         if(_disObj13)
         {
            ObjectUtils.disposeObject(_disObj13);
         }
         _disObj13 = null;
         _disObj13 = ComponentFactory.Instance.creat(param1) as DisplayObject;
         addChild(_disObj13);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         overBgVisible = true;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            overBgVisible = false;
         }
      }
      
      private function set overBgVisible(param1:Boolean) : void
      {
         if(!_data)
         {
            return;
         }
         switch(_cellType - 1)
         {
            case 0:
               var _temp_1:* = _disObj1;
               _disObj1["setFrame"](param1 ? 2 : 1);
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _selected = param2;
         overBgVisible = _selected;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as SortData;
         doOnlyFirst();
         if(_data)
         {
            switch(_cellType - 1)
            {
               case 0:
                  _disObj2["text"] = LanguageMgr.GetTranslation("sort.SortGeneralListCell.str01",MoneyUtils.toCNUpper(_data.orderId,true));
                  if(_data.army.baseHero.IsVipAndNoExpirt)
                  {
                     _disObj3.visible = true;
                     _disObj4.visible = false;
                     _disObj3["text"] = _data.army.baseHero.nickName;
                     _disObj5.x = _disObj3.x + _disObj3.width;
                  }
                  else
                  {
                     _disObj3.visible = false;
                     _disObj4.visible = true;
                     _disObj4["text"] = _data.army.baseHero.nickName;
                     _disObj5.x = _disObj4.x + _disObj4.width;
                  }
                  _disObj5["text"] = "[" + _data.army.baseHero.serviceName + "]";
            }
         }
         else
         {
            _disObj2["text"] = "";
            _disObj3["text"] = "";
            _disObj4["text"] = "";
            _disObj5["text"] = "";
         }
      }
      
      private function doOnlyFirst() : void
      {
         if(_first)
         {
            _first = false;
            switch(_cellType - 1)
            {
               case 0:
                  _disObj1["setFrame"](1);
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_disObj1);
         _disObj1 = null;
         ObjectUtils.disposeObject(_disObj2);
         _disObj2 = null;
         ObjectUtils.disposeObject(_disObj3);
         _disObj3 = null;
         ObjectUtils.disposeObject(_disObj4);
         _disObj4 = null;
         ObjectUtils.disposeObject(_disObj5);
         _disObj5 = null;
         ObjectUtils.disposeObject(_disObj6);
         _disObj6 = null;
         ObjectUtils.disposeObject(_disObj7);
         _disObj7 = null;
         ObjectUtils.disposeObject(_disObj8);
         _disObj8 = null;
         ObjectUtils.disposeObject(_disObj9);
         _disObj9 = null;
         ObjectUtils.disposeObject(_disObj10);
         _disObj10 = null;
         ObjectUtils.disposeObject(_disObj11);
         _disObj11 = null;
         ObjectUtils.disposeObject(_disObj12);
         _disObj12 = null;
         ObjectUtils.disposeObject(_disObj13);
         _disObj13 = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


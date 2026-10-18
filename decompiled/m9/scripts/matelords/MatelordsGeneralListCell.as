package matelords
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.matelords.MatelordsModel;
   import mvc.module.matelords.MatelordsPlayerInfo;
   import yishi.manager.MatelordsManager;
   
   public class MatelordsGeneralListCell extends Sprite implements IListCell, Disposeable
   {
      
      public static const TYPE_RANK:int = 1;
      
      public static const TYPE_FINAL_RANK:int = 2;
      
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
      
      private var _cellType:int;
      
      private var _data:MatelordsPlayerInfo;
      
      private var _tipButton:BaseButton;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      public function MatelordsGeneralListCell()
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
         overBgVisible = false;
      }
      
      private function set overBgVisible(param1:Boolean) : void
      {
         switch(_cellType - 1)
         {
            case 0:
               if(_disObj1)
               {
                  _disObj1.visible = param1;
               }
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as MatelordsPlayerInfo;
         if(_data)
         {
            doOnlyFirst();
            switch(_cellType - 1)
            {
               case 0:
                  if(_data.curOrder >= 1 && _data.curOrder <= 3)
                  {
                     _disObj3.visible = false;
                     _disObj2.visible = true;
                     _disObj2["setFrame"](_data.curOrder);
                  }
                  else
                  {
                     _disObj2.visible = false;
                     _disObj3.visible = true;
                     _disObj3["text"] = _data.curOrder;
                  }
                  _disObj4.visible = _disObj5.visible = false;
                  _disObj6.visible = true;
                  _disObj6["text"] = _data.teamName;
                  _disObj7.x = _disObj6.x + _disObj6.width;
                  _disObj7["text"] = "[" + _data.serverName + "]";
                  _disObj9["text"] = _data.grades;
                  _disObj9.x = _disObj8.x + _disObj8.width;
                  _disObj10["text"] = _data.fightPower;
                  _disObj11["text"] = _data.totalScore + "";
                  _disObj8.visible = false;
                  _disObj9.visible = false;
                  break;
               case 1:
                  if(_data.curOrder >= 1 && _data.curOrder <= 3)
                  {
                     _disObj2.visible = false;
                     _disObj1.visible = true;
                     _disObj1["setFrame"](_data.curOrder);
                     _disObj3["setFrame"](2);
                     _disObj4["setFrame"](2);
                  }
                  else
                  {
                     _disObj1.visible = false;
                     _disObj2.visible = true;
                     _disObj2["text"] = _data.curOrder;
                     _disObj3["setFrame"](1);
                     _disObj4["setFrame"](1);
                  }
                  _disObj3["text"] = _data.teamName;
                  _disObj4["text"] = _data.totalScore + "";
                  if(_tipButton)
                  {
                     ObjectUtils.disposeObject(_tipButton);
                     _tipButton = null;
                  }
                  if(String(_disObj3["text"]).substring(String(_disObj3["text"]).length - 3) == "..." && _data.teamName.substring(_data.teamName.length) != "...")
                  {
                     _tipButton = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
                     _tipButton.x = _disObj3.x;
                     _tipButton.y = _disObj3.y;
                     _tipButton.width = _disObj3.width;
                     _tipButton.height = _disObj3.height;
                     _tipButton.alpha = 0;
                     _tipButton.tipData = _data.teamName;
                     _tipButton.buttonMode = false;
                     addChild(_tipButton);
                     _tipButton.tipGapH = 0;
                     _tipButton.tipGapV = 0;
                  }
            }
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
               case 1:
                  _disObj1.visible = false;
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
         if(_tipButton)
         {
            ObjectUtils.disposeObject(_tipButton);
            _tipButton = null;
         }
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


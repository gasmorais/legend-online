package singlepass.order
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.singlepass.SinglePassModel;
   import mvc.module.singlepass.SinglePassOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.view.community.PlayerMenu;
   
   public class SinglePassOrderItemView extends SelectedButton implements IListCell
   {
      
      private var _line:MutipleImage;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _orderTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipnameTxt:GradientText;
      
      private var _layerTxt:FilterFrameText;
      
      private var _vipIcon:Bitmap;
      
      private var _data:SinglePassOrderInfo;
      
      public function SinglePassOrderItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemBg");
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextValueStyle1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextValueStyle2");
         _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextStyle2_vip");
         _layerTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextValueStyle3");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _line = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemLine");
         addChild(_itemBg);
         addChild(_orderTxt);
         addChild(_layerTxt);
         addChild(_line);
         _itemBg.setFrame(1);
         _vipnameTxt.x = _nameTxt.x;
         _vipnameTxt.y = _nameTxt.y;
         _vipnameTxt.width = _nameTxt.width;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_layerTxt);
         _layerTxt = null;
         ObjectUtils.disposeObject(_vipnameTxt);
         _vipnameTxt = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override protected function addEvent() : void
      {
         addEventListener("click",__onItemClick);
         addEventListener("rollOver",__onItemOver);
         addEventListener("rollOut",__onItemOut);
      }
      
      override protected function removeEvent() : void
      {
         removeEventListener("click",__onItemClick);
         removeEventListener("rollOver",__onItemOver);
         removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc4_:Point = parent.localToGlobal(new Point(x,y + 20));
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.userId = _data.userId;
         _loc2_.job = _data.job;
         _loc2_.nickName = _data.nickName;
         _loc2_.consortiaName = _data.consortiaName;
         _loc2_.grades = _data.grades;
         _loc2_.fightingCapacity = _data.fightingCapacity;
         var _loc3_:PlayerMenu = new PlayerMenu();
         _loc3_.setData(_loc2_);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         LayerManager.Instance.addToLayer(_loc3_,7);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _itemBg.setFrame(2);
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         if(_selected || !_data)
         {
            return;
         }
         _itemBg.setFrame(1);
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(_data)
         {
            _data.selected = param1;
            selectedEffect(param1);
         }
      }
      
      private function selectedEffect(param1:Boolean) : void
      {
         if(param1)
         {
            _itemBg.setFrame(2);
         }
         else
         {
            _itemBg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         data = param1 as SinglePassOrderInfo;
      }
      
      public function set data(param1:SinglePassOrderInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         selectedEffect(_data.selected);
         _nameTxt.parent && _nameTxt.parent.removeChild(_nameTxt);
         _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
         _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
         _vipnameTxt.text = _data.nickName;
         _nameTxt.text = _data.nickName;
         _vipIcon.x = 79;
         _vipIcon.y = _vipnameTxt.y + 2;
         if(_data.isVip)
         {
            addChild(_vipnameTxt);
            addChild(_vipIcon);
         }
         else
         {
            addChild(_nameTxt);
         }
         _orderTxt.text = String(_data.order);
         var _loc1_:int = (_data.index - 1) / 10 + 1;
         var _loc2_:int = _data.index % 10;
         if(_loc2_ == 0)
         {
            _loc2_ = 10;
         }
         _layerTxt.text = LanguageMgr.GetTranslation("singlepass.order.SinglePassOrderFrame.ItemTxt",SinglePassModel.FLOOR_STR[_loc1_],_loc2_);
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


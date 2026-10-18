package crosscost.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mvc.module.crosscost.CrossCostItemData;
   import mvc.module.crosscost.CrossCostModel;
   import yishi.manager.FrameControllerManager;
   
   public class CrossCostItem extends Sprite implements Disposeable, ISelectable, IManualSize
   {
      
      public var _routineImage:Bitmap;
      
      public var _rankText:FilterFrameText;
      
      public var _userNameText:FilterFrameText;
      
      public var _gradeText:FilterFrameText;
      
      public var _agencyServerText:FilterFrameText;
      
      public var _exchargeNumberText:FilterFrameText;
      
      public var _bg:ScaleFrameImage;
      
      private var _data:CrossCostItemData;
      
      private var _model:CrossCostModel;
      
      public function CrossCostItem()
      {
         super();
         _model = FrameControllerManager.instance.crossCostControler.model;
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,598,30);
      }
      
      private function initView() : void
      {
         _routineImage = ComponentFactory.Instance.creatBitmap("asset.crosscost.vipIcon");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("crosscost.dataItem.rankText");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("crosscost.dataItem.userNameText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("crosscost.dataItem.levelText");
         _agencyServerText = ComponentFactory.Instance.creatComponentByStylename("crosscost.dataItem.agencyServerText");
         _exchargeNumberText = ComponentFactory.Instance.creatComponentByStylename("crosscost.dataItem.exchargeNumberText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("crosscostview.item.bg");
         addChild(_bg);
         if(_bg)
         {
            _bg.setFrame(1);
         }
         addChild(_routineImage);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_gradeText);
         addChild(_agencyServerText);
         addChild(_exchargeNumberText);
         _routineImage.visible = false;
      }
      
      private function uinitView() : void
      {
         ObjectUtils.disposeObject(_routineImage);
         _routineImage = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userNameText);
         _userNameText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_agencyServerText);
         _agencyServerText = null;
         ObjectUtils.disposeObject(_exchargeNumberText);
         _exchargeNumberText = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",_selectedItem);
         addEventListener("mouseOut",_unSelectItem);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",_selectedItem);
         removeEventListener("mouseOut",_unSelectItem);
      }
      
      private function _selectedItem(param1:MouseEvent) : void
      {
         if(_bg)
         {
            _bg.setFrame(2);
         }
      }
      
      private function _unSelectItem(param1:MouseEvent) : void
      {
         if(_bg)
         {
            _bg.setFrame(1);
         }
      }
      
      public function get data() : CrossCostItemData
      {
         return _data;
      }
      
      public function set data(param1:CrossCostItemData) : void
      {
         if(!param1)
         {
            return;
         }
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _rankText.text = String(_data.rank);
         _userNameText.text = _data.nickName;
         if(_data.grade != 0)
         {
            _gradeText.text = String(_data.grade);
         }
         _agencyServerText.text = _data.agencyServer;
         _exchargeNumberText.text = _data.amount.replace("Necessário Consumir","");
         _exchargeNumberText.y = 4 - (_exchargeNumberText.numLines - 1) * 7;
         if(_data.isVip == 1)
         {
            _routineImage.visible = true;
            _userNameText.textColor = 16774656;
         }
      }
      
      private function clear() : void
      {
         _rankText.text = "";
         _userNameText.text = "";
         _gradeText.text = "";
         _agencyServerText.text = "";
         _exchargeNumberText.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         uinitView();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}


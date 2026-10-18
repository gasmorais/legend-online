package auction.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionListItemData;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class AuctionListItemBase extends Sprite implements Disposeable, ISelectable
   {
      
      private var unselectedView:DisplayObject;
      
      private var selectedView:DisplayObject;
      
      private var mouseOverView:DisplayObject;
      
      private var _selected:Boolean;
      
      private var _data:AuctionListItemData;
      
      protected var _itemIcon:DisplayObject;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _gradeTxt:FilterFrameText;
      
      protected var _timeLeftTxt:FilterFrameText;
      
      protected var _salerTxt:FilterFrameText;
      
      protected var _fixedPriceBack:Sprite;
      
      protected var _fixedPriceTxt:FilterFrameText;
      
      protected var _currPriceBack:Sprite;
      
      protected var _currPriceTxt:FilterFrameText;
      
      protected var _icon:BaseItemView;
      
      protected var _auctionedIcon:Image;
      
      protected var _itemTipView:StripView;
      
      private var _tipView:StripView;
      
      private var _fixedPriceTipView:StripView;
      
      private var _currPriceTipView:StripView;
      
      public function AuctionListItemBase(param1:String, param2:String, param3:String)
      {
         super();
         unselectedView = ComponentFactory.Instance.creatComponentByStylename(param2);
         addChild(unselectedView);
         selectedView = ComponentFactory.Instance.creatComponentByStylename(param1);
         addChild(selectedView);
         selectedView.visible = false;
         mouseOverView = ComponentFactory.Instance.creatComponentByStylename(param3);
         addChild(mouseOverView);
         mouseOverView.visible = false;
         addHandler();
      }
      
      public function setData(param1:AuctionListItemData) : void
      {
         if(_data)
         {
            _data.removeEventListener("change",onDataChange);
            _icon.removeEventListener("interactive_double_click",iconDoubleClickHandler);
         }
         _data = param1;
         if(!_data)
         {
            selected = false;
            onMouseOut(null);
            mouseChildren = this.mouseEnabled = false;
         }
         else
         {
            refreshView();
            showDataView();
            _data.addEventListener("change",onDataChange);
            _icon.addEventListener("interactive_double_click",iconDoubleClickHandler);
         }
      }
      
      private function iconDoubleClickHandler(param1:Event) : void
      {
         MsgMan.notifyObserver("ICON_DOUBLE_CLICK",_data.name);
      }
      
      private function onDataChange(param1:Event) : void
      {
         updateValue();
      }
      
      protected function refreshView() : void
      {
      }
      
      private function showDataView() : void
      {
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_timeLeftTxt);
         addChild(_salerTxt);
         addChild(_fixedPriceBack);
         addChild(_fixedPriceTxt);
         addChild(_currPriceBack);
         addChild(_currPriceTxt);
         addItemTip();
         addChild(_icon);
         DoubleClickManager.Instance.enableDoubleClick(_icon);
         if(_auctionedIcon)
         {
            addChild(_auctionedIcon);
            _auctionedIcon.tipData = LanguageMgr.GetTranslation("Auction.AuctionedTips");
         }
         updateValue();
         setTimeLeftTip();
         setUnitPriceTip();
         _nameTxt.doubleClickEnabled = _gradeTxt.doubleClickEnabled = _timeLeftTxt.doubleClickEnabled = _salerTxt.doubleClickEnabled = _fixedPriceTxt.doubleClickEnabled = _currPriceTxt.doubleClickEnabled = true;
         DisplayObjectContainer(mouseOverView).doubleClickEnabled = DisplayObjectContainer(selectedView).doubleClickEnabled = true;
         _fixedPriceBack.mouseChildren = _currPriceBack.mouseChildren = false;
         _fixedPriceBack.mouseEnabled = _currPriceBack.mouseEnabled = false;
      }
      
      private function addItemTip() : void
      {
         if(_itemTipView)
         {
            addChild(_itemTipView);
         }
      }
      
      private function updateValue() : void
      {
         _nameTxt.text = _data.name;
         _gradeTxt.text = _data.grade + "";
         _timeLeftTxt.text = _data.timeLeft;
         _salerTxt.text = _data.saler;
         _fixedPriceTxt.text = _data.fixedPrice + "";
         _currPriceTxt.text = _data.currPrice + "";
         _icon.data = _data.getGoodsInfo();
         if(_auctionedIcon)
         {
            _auctionedIcon.visible = _data.auctioned;
         }
         if(_itemTipView)
         {
            if(_data.selfPrice < _data.currPrice)
            {
               _itemTipView.tipData = LanguageMgr.GetTranslation("Auction.AuctionItemOverTips");
               filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               _itemTipView.tipData = "";
               filters = null;
            }
         }
         if(_tipView)
         {
            _tipView.tipData = getLeftTimeTip();
         }
         if(_fixedPriceTipView)
         {
            _fixedPriceTipView.tipData = LanguageMgr.GetTranslation("auction.view.common.AuctionListItemBase.count01") + getUnitPriceValue(_data.fixedPrice);
         }
         if(_currPriceTipView)
         {
            _currPriceTipView.tipData = LanguageMgr.GetTranslation("auction.view.common.AuctionListItemBase.count02") + getUnitPriceValue(_data.currPrice);
         }
      }
      
      private function setTimeLeftTip() : void
      {
         ObjectUtils.disposeObject(_tipView);
         _tipView = ComponentFactory.Instance.creatCustomObject("auction.timeLeftTip");
         _tipView.graphics.beginFill(0,0);
         _tipView.graphics.drawRect(0,0,_timeLeftTxt.width,_timeLeftTxt.height);
         _tipView.graphics.endFill();
         _tipView.x = _timeLeftTxt.x;
         _tipView.y = _timeLeftTxt.y;
         _tipView.tipData = getLeftTimeTip();
         _tipView.doubleClickEnabled = true;
         addChild(_tipView);
      }
      
      private function setUnitPriceTip() : void
      {
         ObjectUtils.disposeObject(_fixedPriceTipView);
         _fixedPriceTipView = ComponentFactory.Instance.creatCustomObject("auction.UnitPriceTip");
         _fixedPriceTipView.graphics.beginFill(0,0);
         _fixedPriceTipView.graphics.drawRect(0,0,_fixedPriceTxt.width,_fixedPriceTxt.height);
         _fixedPriceTipView.graphics.endFill();
         _fixedPriceTipView.x = _fixedPriceTxt.x;
         _fixedPriceTipView.y = _fixedPriceTxt.y;
         _fixedPriceTipView.tipData = LanguageMgr.GetTranslation("auction.view.common.AuctionListItemBase.count01") + getUnitPriceValue(_data.fixedPrice);
         _fixedPriceTipView.doubleClickEnabled = true;
         ObjectUtils.disposeObject(_currPriceTipView);
         _currPriceTipView = ComponentFactory.Instance.creatCustomObject("auction.UnitPriceTip");
         _currPriceTipView.graphics.beginFill(0,0);
         _currPriceTipView.graphics.drawRect(0,0,_currPriceTxt.width,_currPriceTxt.height);
         _currPriceTipView.graphics.endFill();
         _currPriceTipView.x = _currPriceTxt.x;
         _currPriceTipView.y = _currPriceTxt.y;
         _currPriceTipView.tipData = LanguageMgr.GetTranslation("auction.view.common.AuctionListItemBase.count02") + getUnitPriceValue(_data.currPrice);
         _currPriceTipView.doubleClickEnabled = true;
         addChild(_currPriceTipView);
         addChild(_fixedPriceTipView);
      }
      
      private function getLeftTimeTip() : String
      {
         var _loc2_:String = "Auction.LeftTimeTip";
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.nowDate - _data.startTime.time;
         var _loc1_:Number = _data.hour * 3600 * 1000 - _loc3_;
         _loc1_ /= 3600000;
         if(_loc1_ >= 12)
         {
            _loc2_ += "1";
         }
         else if(_loc1_ >= 2 && _loc1_ < 12)
         {
            _loc2_ += "2";
         }
         else if(_loc1_ >= 0.5 && _loc1_ < 2)
         {
            _loc2_ += "3";
         }
         else
         {
            _loc2_ += "4";
         }
         return LanguageMgr.GetTranslation(_loc2_);
      }
      
      private function getUnitPriceValue(param1:int) : String
      {
         var _loc2_:int = 0;
         if(_data)
         {
            _loc2_ = int(_data.getGoodsInfo().count);
            return (Math.round(param1 / _loc2_ * 10) / 10).toString();
         }
         return "";
      }
      
      public function getData() : AuctionListItemData
      {
         return _data;
      }
      
      private function addHandler() : void
      {
         addEventListener("rollOver",onMouseOver);
         addEventListener("rollOut",onMouseOut);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         mouseOverView.visible = true;
         this.buttonMode = true;
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         mouseOverView.visible = false;
         this.buttonMode = false;
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
         _selected = param1;
         if(_selected)
         {
            unselectedView.visible = false;
            selectedView.visible = true;
         }
         else
         {
            unselectedView.visible = true;
            selectedView.visible = false;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function get height() : Number
      {
         return 44;
      }
      
      public function dispose() : void
      {
         removeEventListener("rollOver",onMouseOver);
         removeEventListener("rollOut",onMouseOut);
         if(_data)
         {
            _data.removeEventListener("change",onDataChange);
            DoubleClickManager.Instance.disableDoubleClick(_icon);
            _icon.removeEventListener("interactive_double_click",iconDoubleClickHandler);
         }
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}


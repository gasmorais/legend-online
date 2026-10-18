package auction.view.sell
{
   import auction.view.AuctionAlert;
   import auction.view.common.AuctionListColWidthConst;
   import auction.view.common.AuctionListComponent;
   import auction.view.common.AuctionListItem1;
   import auction.view.common.AuctionListTitleComponent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TitleButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mediator.AuctionMessageSender;
   import mvc.module.auction.AuctionListItemData;
   import mvc.module.auction.AuctionModel;
   import mvc.module.auction.AuctionResultListData;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AuctionSellResultPane extends Sprite implements Disposeable
   {
      
      private var _border:DisplayObject;
      
      private var _listTitle:AuctionListTitleComponent;
      
      private var _listComponent:AuctionListComponent;
      
      private var _bottomBar:AuctionSellBottomBar;
      
      private var _corner1:DisplayObject;
      
      private var _corner2:DisplayObject;
      
      private var _corner3:DisplayObject;
      
      private var _corner4:DisplayObject;
      
      private var _data:AuctionResultListData;
      
      private var _bag:*;
      
      private var _bagDefPoint:Point = new Point(70,25);
      
      private var _delayShowBagTimer:Timer;
      
      private var _goodsType:int;
      
      private var _currentOrder:String;
      
      private var __currentOrderType:int;
      
      public function AuctionSellResultPane(param1:int = 1)
      {
         _goodsType = param1;
         super();
         var _loc2_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _data = _loc2_.soldList;
         init();
         addHandler();
      }
      
      private function init() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.sell.resultBack");
         addChild(_border);
         var _loc1_:Array = AuctionListColWidthConst.short;
         var _loc2_:Array = AuctionListColWidthConst.shortX;
         _listTitle = new AuctionListTitleComponent("auction.listTitleBmdS",_loc1_,_loc2_);
         _listTitle.x = 1;
         _listTitle.y = 1;
         addChild(_listTitle);
         _listComponent = new AuctionListComponent(AuctionListItem1,9,-3);
         _listComponent.setData(_data.getList());
         _listComponent.x = 3;
         _listComponent.y = 31;
         addChild(_listComponent);
         _bottomBar = new AuctionSellBottomBar();
         _bottomBar.x = 2;
         _bottomBar.y = 398;
         addChild(_bottomBar);
         _corner1 = ComponentFactory.Instance.creatComponentByStylename("auction.sellResultCorner1");
         _corner2 = ComponentFactory.Instance.creatComponentByStylename("auction.sellResultCorner2");
         _corner3 = ComponentFactory.Instance.creatComponentByStylename("auction.sellResultCorner3");
         _corner4 = ComponentFactory.Instance.creatComponentByStylename("auction.sellResultCorner4");
         addChild(_corner1);
         addChild(_corner2);
         addChild(_corner3);
         addChild(_corner4);
         if(_goodsType == 1)
         {
            _bag = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionBagFrame",[_goodsType]);
         }
         else if(_goodsType == 2)
         {
            _bag = ComponentFactory.Instance.creatComponentByStylename("auction.PetSellView");
         }
      }
      
      public function addHandler() : void
      {
         _data.addEventListener("change",onListDataChange);
         _bottomBar.getCancelBtn().addEventListener("click",onCancelBtnClick);
         StageReferance.stage.addEventListener("resize",layout);
         addEventListener("addedToStage",onAddedToStage);
         _bag.addEventListener("FRAME_MOVE_COMPLETE",onBagMoveEvent);
         _listTitle.titleGrade.addEventListener("click",__onTitleClick);
         _listTitle.titleTime.addEventListener("click",__onTitleClick);
         _listTitle.titlePrice.addEventListener("click",__onTitleClick);
         _listTitle.titleCurPrice.addEventListener("click",__onTitleClick);
      }
      
      private function __onTitleClick(param1:MouseEvent) : void
      {
         var _loc2_:TitleButton = param1.currentTarget as TitleButton;
         switch(_loc2_)
         {
            case _listTitle.titleGrade:
               _currentOrder = "grade";
               break;
            case _listTitle.titleTime:
               _currentOrder = "hour";
               break;
            case _listTitle.titlePrice:
               _currentOrder = "fixedPrice";
               break;
            case _listTitle.titleCurPrice:
               _currentOrder = "currPrice";
         }
         if(_listTitle.currentSelectBut(_loc2_) == 2)
         {
            __currentOrderType = 0;
         }
         else
         {
            __currentOrderType = 2;
         }
         var _loc3_:Array = _data.getList().sortOn(_currentOrder,0x10 | __currentOrderType);
         _listComponent.setData(_loc3_);
      }
      
      private function onBagMoveEvent(param1:Event) : void
      {
         _bagDefPoint = _bag.parent.localToGlobal(new Point(_bag.x,_bag.y));
         _bagDefPoint = this.globalToLocal(_bagDefPoint);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         _delayShowBagTimer = new Timer(20,1);
         _delayShowBagTimer.addEventListener("timerComplete",onDelayShowBagTimerComplete);
         _delayShowBagTimer.start();
      }
      
      private function onDelayShowBagTimerComplete(param1:TimerEvent) : void
      {
         removeDelayTimer();
         _bag.show();
         layout(null);
      }
      
      private function removeDelayTimer() : void
      {
         if(_delayShowBagTimer)
         {
            _delayShowBagTimer.stop();
            _delayShowBagTimer.removeEventListener("timerComplete",onDelayShowBagTimerComplete);
            _delayShowBagTimer = null;
         }
      }
      
      private function layout(param1:Event) : void
      {
         var _loc2_:Point = null;
         if(_bag && _bag.parent)
         {
            _loc2_ = _bagDefPoint.clone();
            _loc2_ = this.localToGlobal(_loc2_);
            _loc2_ = _bag.parent.globalToLocal(_loc2_);
            _bag.x = _loc2_.x;
            _bag.y = _loc2_.y;
         }
      }
      
      private function onListDataChange(param1:Event) : void
      {
         var _loc2_:Array = null;
         if(_currentOrder)
         {
            _loc2_ = _data.getList().sortOn(_currentOrder,__currentOrderType);
            _listComponent.setData(_loc2_);
         }
         else
         {
            _listComponent.setData(_data.getList());
         }
      }
      
      private function onCancelBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc2_:AuctionListItemData = _listComponent.getSelectedItemData();
         if(_loc2_)
         {
            SimpleAlertHelper.instance.data = [cancelSell,_loc2_.goodId];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc3_ = LanguageMgr.GetTranslation("Action.SellGoods.CancelSell");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc3_,_loc4_,_loc5_,true,false,false,2);
         }
         else
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.PleaseSelectGood"));
         }
      }
      
      private function cancelSell(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            AuctionMessageSender.sendCancelItemMessage(param3);
         }
      }
      
      public function openBag() : void
      {
         if(_bag && !_bag.isOpen())
         {
            _bagDefPoint = new Point(70,25);
            _bag.show();
            layout(null);
         }
      }
      
      public function getBagPane() : Disposeable
      {
         return _bag.getBagPane();
      }
      
      public function dispose() : void
      {
         _listTitle.titleGrade.removeEventListener("click",__onTitleClick);
         _listTitle.titleTime.removeEventListener("click",__onTitleClick);
         _listTitle.titlePrice.removeEventListener("click",__onTitleClick);
         _listTitle.titleCurPrice.removeEventListener("click",__onTitleClick);
         _data.removeEventListener("change",onListDataChange);
         _bottomBar.getCancelBtn().removeEventListener("click",onCancelBtnClick);
         StageReferance.stage.removeEventListener("resize",layout);
         removeEventListener("addedToStage",onAddedToStage);
         removeDelayTimer();
         if(_bag)
         {
            _bag.removeEventListener("FRAME_MOVE_COMPLETE",onBagMoveEvent);
            _bag.dispose();
            _bag = null;
         }
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_listTitle);
         _listTitle = null;
         ObjectUtils.disposeObject(_listComponent);
         _listComponent = null;
         ObjectUtils.disposeObject(_bottomBar);
         _bottomBar = null;
         ObjectUtils.disposeObject(_corner1);
         _corner1 = null;
         ObjectUtils.disposeObject(_corner2);
         _corner2 = null;
         ObjectUtils.disposeObject(_corner3);
         _corner3 = null;
         ObjectUtils.disposeObject(_corner4);
         _corner4 = null;
         ObjectUtils.disposeObject(_bag);
         _bag = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


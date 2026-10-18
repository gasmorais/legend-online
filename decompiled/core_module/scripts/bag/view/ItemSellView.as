package bag.view
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.dragontalker.SellTalismanInfo;
   import com.road.yishi.proto.item.ItemSellReqMsg;
   import com.road.yishi.proto.item.SelledItemInfo;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ItemSellView extends Frame
   {
      
      public static const SELL_TYPE_DRAGON_TALKER:int = 1;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _priceImage:MutipleImage;
      
      private var _sellBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _number:FilterFrameText;
      
      private var _delete:FilterFrameText;
      
      private var _totalPrice:FilterFrameText;
      
      private var _total:int;
      
      private var _panel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<SellItem>;
      
      private var _sellType:int;
      
      public function ItemSellView(param1:int = 0)
      {
         super();
         _sellType = param1;
         _itemList = new Vector.<SellItem>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.titleText");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.bg1");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.titleBg");
         _priceImage = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.priceImage");
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.sellBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.cancelBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.name");
         _number = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.number");
         _delete = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.delete");
         _totalPrice = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.totalPrice");
         _panel = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.panel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.vBox");
         addToContent(_bg1);
         addToContent(_titleBg);
         addToContent(_priceImage);
         addToContent(_sellBtn);
         addToContent(_cancelBtn);
         addToContent(_name);
         addToContent(_number);
         addToContent(_delete);
         _name.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.nameText");
         _number.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.numberText");
         _delete.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.deleteText");
         addToContent(_totalPrice);
         addToContent(_panel);
         _panel.setView(_vBox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sellBtn.addEventListener("click",__sellHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _vBox.addEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.addEventListener("COUNT_CHANGE",__chanceHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__deleteFromBagHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateFromBagHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sellBtn.removeEventListener("click",__sellHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _vBox.removeEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.removeEventListener("COUNT_CHANGE",__chanceHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__deleteFromBagHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateFromBagHandler);
      }
      
      private function __updateFromBagHandler(param1:BagEvent) : void
      {
         _total = 0;
         for each(var _loc2_:SellItem in _itemList)
         {
            if(_loc2_.info && _loc2_.info.id == param1.info.id)
            {
               _loc2_.info = _loc2_.info;
            }
            if(_loc2_.info.templateInfo.MasterType != 5 && _loc2_.info.templateInfo.MasterType != 1)
            {
               _total += GoodsCheck.getSellGold(_loc2_.info) * _loc2_.count;
            }
            else
            {
               _total += GoodsCheck.getPetEquipSellGold(_loc2_.info);
            }
         }
         _totalPrice.text = "" + _total;
      }
      
      private function __deleteFromBagHandler(param1:BagEvent) : void
      {
         for each(var _loc2_:SellItem in _itemList)
         {
            if(_loc2_.info && _loc2_.info.id == param1.info.id)
            {
               if(_loc2_.info.count <= param1.info.count)
               {
                  _loc2_.dispatchEvent(new BagEvent("SELLITEM_DELETE",_loc2_.info,null,true));
                  _loc2_.dispose();
               }
               else
               {
                  _loc2_.info = param1.info;
               }
            }
         }
      }
      
      private function __chanceHandler(param1:BagEvent) : void
      {
         param1.stopPropagation();
         _total = 0;
         for each(var _loc2_:SellItem in _itemList)
         {
            if(_loc2_.info.templateInfo.MasterType != 5 && _loc2_.info.templateInfo.MasterType != 1)
            {
               _total += GoodsCheck.getSellGold(_loc2_.info) * _loc2_.count;
            }
            else
            {
               _total += GoodsCheck.getPetEquipSellGold(_loc2_.info);
            }
         }
         _totalPrice.text = "" + _total;
      }
      
      private function __deleteHandler(param1:BagEvent) : void
      {
         param1.stopPropagation();
         GoodsManager.instance.setSellPos(param1.info,false);
         for each(var _loc2_:SellItem in _itemList)
         {
            if(_loc2_.info === param1.info)
            {
               if(_loc2_.info.templateInfo.MasterType != 5 && _loc2_.info.templateInfo.MasterType != 1)
               {
                  _total -= GoodsCheck.getSellGold(_loc2_.info) * _loc2_.count;
               }
               else
               {
                  _total -= GoodsCheck.getPetEquipSellGold(_loc2_.info);
               }
               _itemList.splice(_itemList.indexOf(_loc2_),1);
               break;
            }
         }
         _totalPrice.text = "" + _total;
         _panel.invalidateViewport();
         NotificationManager.instance.sendNotification("FILTR_BY_SELL");
         if(_itemList.length == 0)
         {
            NotificationManager.instance.sendNotification("FILTER_GOODS");
         }
      }
      
      private function __sellHandler(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc2_:int = int(_itemList.length);
         if(_loc2_ <= 0)
         {
            return;
         }
         if(_total + ResourceManager.instance.gold.count >= 2147483647 || _total + ResourceManager.instance.gold.count < 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.itemSellView.sell.overMaxAlert"));
            return;
         }
         if(ResourceManager.instance.gold.count + _total > 2147483647)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.view.GoldOvertopView.goldOvertop"));
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         _loc6_ = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.simpleGoodsHtml",_itemList.length,_total);
         if(_sellType == 1)
         {
            SimpleAlertHelper.instance.data = [__dragonTalkerAlertResponse];
         }
         else
         {
            SimpleAlertHelper.instance.data = [__alertResponse];
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,false,true);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         var _loc7_:PackageOut = null;
         var _loc4_:ItemSellReqMsg = null;
         var _loc5_:int = 0;
         var _loc6_:SelledItemInfo = null;
         if(param1)
         {
            _loc7_ = new PackageOut(8624);
            _loc4_ = new ItemSellReqMsg();
            _loc5_ = 0;
            while(_loc5_ < _itemList.length)
            {
               _loc6_ = new SelledItemInfo();
               if(_itemList[_loc5_])
               {
                  _loc6_.pos = _itemList[_loc5_].info.pos;
                  _loc6_.count = _itemList[_loc5_].count;
                  _loc6_.bagType = _itemList[_loc5_].info.bagType;
                  _loc4_.selledItemInfos.push(_loc6_);
               }
               _loc5_++;
            }
            SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc4_);
            dispose();
         }
      }
      
      private function __dragonTalkerAlertResponse(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         var _loc4_:Array = null;
         var _loc7_:SellTalismanInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc4_ = [];
            _loc5_ = 0;
            while(_loc5_ < _itemList.length)
            {
               if(_itemList[_loc5_])
               {
                  _loc6_ = _itemList[_loc5_].info;
                  _loc7_ = new SellTalismanInfo();
                  _loc7_.id = _loc6_.dragonTalkerEquipId;
                  _loc7_.count = _itemList[_loc5_].count;
                  _loc4_.push(_loc7_);
               }
               _loc5_++;
            }
            DragonTalkerManager.instance.sendSellItems(_loc4_);
            dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function addSellGoods(param1:GoodsInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_:SellItem in _itemList)
         {
            if(_loc2_.info === param1)
            {
               return;
            }
         }
         var _loc3_:SellItem = new SellItem();
         _loc3_.info = param1;
         _itemList.push(_loc3_);
         _vBox.addChild(_loc3_);
         _panel.invalidateViewport();
         if(param1.templateInfo.MasterType != 5 && param1.templateInfo.MasterType != 1)
         {
            _total += GoodsCheck.getSellGold(param1) * param1.count;
         }
         else
         {
            _total += GoodsCheck.getPetEquipSellGold(param1);
         }
         _totalPrice.text = "" + _total;
         GoodsManager.instance.setSellPos(param1,true);
         NotificationManager.instance.sendNotification("FILTR_BY_SELL");
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg1);
         ObjectUtils.disposeObject(_titleBg);
         ObjectUtils.disposeObject(_priceImage);
         ObjectUtils.disposeObject(_sellBtn);
         ObjectUtils.disposeObject(_cancelBtn);
         ObjectUtils.disposeObject(_name);
         ObjectUtils.disposeObject(_number);
         ObjectUtils.disposeObject(_delete);
         ObjectUtils.disposeObject(_totalPrice);
         ObjectUtils.disposeObject(_panel);
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeObject(_vBox);
         if(_itemList)
         {
            cleanList();
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         GoodsManager.instance.setSellPos(null,false,true);
         NotificationManager.instance.sendNotification("FILTR_BY_SELL");
         NotificationManager.instance.sendNotification("FILTER_GOODS");
      }
      
      private function cleanList() : void
      {
         while(_itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
         _itemList = null;
      }
   }
}


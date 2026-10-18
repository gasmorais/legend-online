package sale
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.SaleManager;
   import mvc.module.sale.SaleData;
   import mvc.module.sale.SaleEvent;
   import mvc.module.sale.SaleModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   
   public class SaleStorageFrame extends Frame implements IManualSize
   {
      
      private var _saleBagView:SaleBagView;
      
      private var _storageRightBg:Image;
      
      private var _typeSelect:FilterFrameText;
      
      private var _fieldName:FilterFrameText;
      
      private var _goodsName:FilterFrameText;
      
      private var _leftTime:FilterFrameText;
      
      private var _auctionPrice:FilterFrameText;
      
      private var _fixedPrice:FilterFrameText;
      
      private var _combox:ComboBox;
      
      private var _smallPointImg:Bitmap;
      
      private var _smallPointImg2:Bitmap;
      
      private var _bottleBagScrollPanel:ScrollPanel;
      
      public function SaleStorageFrame()
      {
         super();
         model.previewType = 1;
         initView();
         initCombox();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,693,506);
      }
      
      private function initView() : void
      {
         _storageRightBg = ComponentFactory.Instance.creatComponentByStylename("sale.storageRightBg");
         _saleBagView = new SaleBagView();
         _saleBagView.x = -7;
         _saleBagView.y = 11;
         _typeSelect = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.typeSelect");
         _fieldName = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.fieldName");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.goodsName");
         _leftTime = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.leftTime");
         _auctionPrice = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.auctionPrice");
         _fixedPrice = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.fixedPrice");
         _combox = ComponentFactory.Instance.creatComponentByStylename("SaleStorageFrame.Combox");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _smallPointImg2 = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _bottleBagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("sale.saleBagScrollPanel");
         addToContent(_storageRightBg);
         addToContent(_bottleBagScrollPanel);
         _bottleBagScrollPanel.setView(_saleBagView);
         _bottleBagScrollPanel.invalidateViewport();
         addToContent(_typeSelect);
         _typeSelect.text = LanguageMgr.GetTranslation("SaleStorageFrame.selectType");
         addToContent(_fieldName);
         _fieldName.text = LanguageMgr.GetTranslation("SaleStorageFrame.prompt");
         addToContent(_goodsName);
         _goodsName.text = "";
         addToContent(_leftTime);
         _leftTime.text = "";
         addToContent(_auctionPrice);
         _auctionPrice.text = "";
         addToContent(_fixedPrice);
         _fixedPrice.text = "";
         addToContent(_combox);
         addToContent(_smallPointImg);
         _smallPointImg.y = 150;
         _smallPointImg.visible = false;
         addToContent(_smallPointImg2);
         _smallPointImg2.y = 194;
         _smallPointImg2.visible = false;
      }
      
      private function initCombox() : void
      {
         _combox.beginChanges();
         _combox.selctedPropName = "formatText";
         var _loc1_:VectorListModel = _combox.listPanel.vectorListModel;
         _loc1_.clear();
         _loc1_.append({
            "Type":1,
            "TypeText":LanguageMgr.GetTranslation("SaleStorageFrame.comboAll")
         });
         _loc1_.append({
            "Type":2,
            "TypeText":LanguageMgr.GetTranslation("SaleStorageFrame.combo1")
         });
         _loc1_.append({
            "Type":3,
            "TypeText":LanguageMgr.GetTranslation("SaleStorageFrame.combo2")
         });
         _loc1_.append({
            "Type":4,
            "TypeText":LanguageMgr.GetTranslation("SaleStorageFrame.combo3")
         });
         _combox.listPanel.list.updateListView();
         _combox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_PREVIEW_ITEM_CLICK",__itemClickHandle);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_PREVIEW_LOADED",__salePreviweLoadedHandler);
         _combox.listPanel.list.addEventListener("listItemClick",__selectedCampaignChange);
      }
      
      private function __selectedCampaignChange(param1:ListItemEvent) : void
      {
         var _loc2_:int = int(param1.cellValue.Type);
         model.previewType = _loc2_;
         _saleBagView.reFreshAll();
      }
      
      public function __salePreviweLoadedHandler(param1:SaleEvent) : void
      {
         _saleBagView.reFreshAll();
      }
      
      protected function __itemClickHandle(param1:SaleEvent) : void
      {
         var _loc3_:Array = ["正常未参与竞{invalid_utf8=230}{invalid_utf8=139}?","出售成功","正处于竞{invalid_utf8=230}{invalid_utf8=139}?","流拍"];
         var _loc4_:GoodsInfo = param1.data as GoodsInfo;
         var _loc2_:SaleData = SaleManager.instance.model.getItemByAuctionId(_loc4_.id);
         _goodsName.text = _loc4_.templateInfo.TemplateName;
         _leftTime.text = DateFormatter.getCountDateByMS(_loc2_.seconds);
         _auctionPrice.text = _loc2_.startPoint + "";
         _fixedPrice.text = _loc2_.fixPoint + "";
         _smallPointImg.x = _auctionPrice.x + _auctionPrice.textWidth + 10;
         _smallPointImg.visible = true;
         _smallPointImg2.x = _fixedPrice.x + _fixedPrice.textWidth + 10;
         _smallPointImg2.visible = true;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("SaleEvent.SALE_PREVIEW_ITEM_CLICK",__itemClickHandle);
         NotificationManager.instance.removeEventListener("SaleEvent.SALE_PREVIEW_LOADED",__salePreviweLoadedHandler);
         _combox && _combox.listPanel && _combox.listPanel.list && _combox.listPanel.list.removeEventListener("listItemClick",__selectedCampaignChange);
      }
      
      protected function __onPayBtnClick(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function get model() : SaleModel
      {
         return SaleManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("SaleStorageFrame.title");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}


package sale
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SaleManager;
   import mvc.module.sale.SaleData;
   import mvc.module.sale.SaleEvent;
   import mvc.module.sale.SaleModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SaleRightView extends Component
   {
      
      private var _data:SaleData;
      
      private var _iconBg:Image;
      
      private var _icon:BaseItemView;
      
      private var _goodsPreviewBtn:IconButton;
      
      private var _luckyPlayerTxtImg:Image;
      
      private var _todayOverflowGoods:FilterFrameText;
      
      private var _goodsName:FilterFrameText;
      
      private var _fixedPrice:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _saleStorageFrame:SaleStorageFrame;
      
      private var _smallPointImg:Bitmap;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function SaleRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("sale.iconBg");
         _icon = ComponentFactory.Instance.creatCustomObject("sale.saleGoodsBaseItemView");
         _goodsPreviewBtn = ComponentFactory.Instance.creatComponentByStylename("SaleRightView.goodsPreviewBtn");
         _luckyPlayerTxtImg = ComponentFactory.Instance.creatComponentByStylename("sale.luckyPlayerTxtImg");
         _todayOverflowGoods = ComponentFactory.Instance.creatComponentByStylename("SaleRightView.todayOverflowGoods");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("SaleRightView.goodsName");
         _fixedPrice = ComponentFactory.Instance.creatComponentByStylename("SaleRightView.fixedPrice");
         _price = ComponentFactory.Instance.creatComponentByStylename("SaleRightView.price");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("sale.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("sale.Vbox");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         addChild(_iconBg);
         addChild(_icon);
         _icon.x = 137;
         _icon.y = 68;
         _iconBg.x = _icon.x - 2;
         _iconBg.y = _icon.y - 1;
         addChild(_goodsPreviewBtn);
         addChild(_luckyPlayerTxtImg);
         addChild(_todayOverflowGoods);
         addChild(_goodsName);
         addChild(_fixedPrice);
         addChild(_price);
         addChild(_scrolPanel);
         addChild(_smallPointImg);
         _smallPointImg.y = 109;
         _smallPointImg.visible = false;
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         __updateLuckShowInfoHandler(null);
      }
      
      public function set data(param1:SaleData) : void
      {
         var _loc3_:GoodsInfo = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         _todayOverflowGoods.text = LanguageMgr.GetTranslation("SaleRightView.todaySuperItem");
         _goodsName.text = _loc2_.TemplateName;
         if(_goodsName.text.length > 18)
         {
            _goodsName.text = _goodsName.text.substr(0,14) + "...";
         }
         _goodsName.y = _goodsName.numLines > 1 ? 51 : 63;
         _fixedPrice.text = LanguageMgr.GetTranslation("SaleRightView.fixedPrice");
         _price.text = _data.fixPoint + "";
         _smallPointImg.x = _price.x + _price.textWidth + 10;
         _smallPointImg.visible = true;
         if(!_icon.data || _loc2_.TemplateId != _icon.data.templateId || _data.counts != _icon.data.count)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.TemplateId;
            _loc3_.count = _data.counts;
            _icon.data = _loc3_;
         }
      }
      
      public function __updateLuckShowInfoHandler(param1:SaleEvent) : void
      {
         var _loc2_:SaleShopEventItem = null;
         var _loc5_:int = 0;
         var _loc4_:ChatData = null;
         _vBox.removeAllChild();
         _vBox.disposeAllChildren();
         _vBox.beginChanges();
         var _loc3_:Array = model.luckShowInfo;
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc2_ = new SaleShopEventItem();
               _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc4_.channel = 103;
               _loc4_.msg = _loc3_[_loc5_];
               _loc4_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc4_);
               _loc2_.data = _loc4_;
               _vBox.addChildAt(_loc2_,0);
               _loc5_++;
            }
         }
         _vBox.commitChanges();
         if(param1 == null)
         {
            _scrolPanel.invalidateViewport(true);
         }
         else
         {
            _scrolPanel.invalidateViewport();
         }
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_saleStorageFrame);
         _saleStorageFrame = null;
         ObjectUtils.disposeObject(_todayOverflowGoods);
         _todayOverflowGoods = null;
         ObjectUtils.disposeObject(_goodsName);
         _goodsName = null;
         ObjectUtils.disposeObject(_fixedPrice);
         _fixedPrice = null;
         ObjectUtils.disposeObject(_price);
         _price = null;
      }
      
      private function initEvent() : void
      {
         _goodsPreviewBtn.addEventListener("click",_goodsPreviewBtnClickHandle);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_NOTIC",__updateLuckShowInfoHandler);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_PREVIEW_LOADED",__salePreviweLoadedHandler);
      }
      
      protected function __salePreviweLoadedHandler(param1:SaleEvent) : void
      {
         _saleStorageFrame = ComponentFactory.Instance.creatComponentByStylename("sale.SaleStorageFrame");
         _saleStorageFrame.show();
      }
      
      protected function _goodsPreviewBtnClickHandle(param1:MouseEvent) : void
      {
         SaleManager.instance.sendPreview();
         if(_saleStorageFrame)
         {
            _saleStorageFrame.dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _goodsPreviewBtn.removeEventListener("click",_goodsPreviewBtnClickHandle);
         NotificationManager.instance.removeEventListener("SaleEvent.SALE_NOTIC",__updateLuckShowInfoHandler);
         NotificationManager.instance.removeEventListener("SaleEvent.SALE_PREVIEW_LOADED",__salePreviweLoadedHandler);
      }
      
      private function get model() : SaleModel
      {
         return SaleManager.instance.model;
      }
      
      override public function dispose() : void
      {
         this.dispatchEvent(new MouseEvent("rollOut"));
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}


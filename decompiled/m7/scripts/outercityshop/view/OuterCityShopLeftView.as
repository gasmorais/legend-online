package outercityshop.view
{
   import auction.view.mysteryshop.MysteryShopEventItem;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.OuterCityShopEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.OuterCityShopManager;
   import mvc.module.outercityshop.OuterCityShopModel;
   
   public class OuterCityShopLeftView extends Sprite implements Disposeable
   {
      
      private var _luckBack:Bitmap;
      
      private var _luckTxtBitmap:Bitmap;
      
      private var _tipAsset:Bitmap;
      
      private var _tipAssetBg:Bitmap;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function OuterCityShopLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _luckBack = ComponentFactory.Instance.creatBitmap("asset.outercityshop.luckBack");
         _luckTxtBitmap = ComponentFactory.Instance.creatBitmap("asset.outercityshop.luckTxtBitmap");
         _tipAssetBg = ComponentFactory.Instance.creatBitmap("asset.outercityshop.tipAssetBg");
         _tipAsset = ComponentFactory.Instance.creatBitmap("asset.outercityshop.tipAsset");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("outercityshop.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("outercityshop.Vbox");
         addChild(_luckBack);
         addChild(_luckTxtBitmap);
         addChild(_tipAssetBg);
         addChild(_tipAsset);
         addChild(_scrolPanel);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         __updateLuckShowInfoHandler(null);
      }
      
      private function addEvent() : void
      {
         model.addEventListener("UPDATE_LUCK_SHOW_INFO",__updateLuckShowInfoHandler);
      }
      
      public function __updateLuckShowInfoHandler(param1:OuterCityShopEvent) : void
      {
         var _loc2_:MysteryShopEventItem = null;
         var _loc4_:int = 0;
         var _loc3_:ChatData = null;
         _vBox.removeAllChild();
         _vBox.disposeAllChildren();
         _vBox.beginChanges();
         if(model.shopLuckShowInfo)
         {
            _loc4_ = 0;
            while(_loc4_ < model.shopLuckShowInfo.length)
            {
               _loc2_ = new MysteryShopEventItem();
               _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc3_.channel = 103;
               _loc3_.msg = model.shopLuckShowInfo[_loc4_];
               _loc3_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc3_);
               _loc2_.data = _loc3_;
               _vBox.addChildAt(_loc2_,0);
               _loc4_++;
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
      
      private function removeEvent() : void
      {
         model.removeEventListener("UPDATE_LUCK_SHOW_INFO",__updateLuckShowInfoHandler);
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


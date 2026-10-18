package war2023
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.exploitsshop.ExploitsShopRespMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SecretwarShopTempInfo;
   import yishi.manager.SecretWarManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretwarShopItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _icon:Bitmap;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      private var _boughtBtn:IconButton;
      
      private var _dropImg:Bitmap;
      
      private var _data:ExploitsShopRespMsg;
      
      public function SecretwarShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopItem.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopItem.nameTxt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopItem.valueTxt");
         _icon = ComponentFactory.Instance.creatBitmap("asset.secretwar.iconsmall");
         _goods = ComponentFactory.Instance.creatCustomObject("SecretwarShopItem.goods");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopItem.buyBtn");
         _boughtBtn = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopItem.boughtBtn");
         _dropImg = ComponentFactory.Instance.creatBitmap("asset.outercityshop.dropImg");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_nameTxt);
         addChild(_valueTxt);
         addChild(_icon);
         _icon.visible = false;
         addChild(_goods);
         addChild(_buyBtn);
         _buyBtn.visible = false;
         addChild(_boughtBtn);
         _boughtBtn.enable = false;
         _boughtBtn.visible = false;
         addChild(_dropImg);
         _dropImg.visible = false;
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:SecretwarShopTempInfo = TempleteManager.instance.secretwarShopTempCate.getTempInfoById(_data.mapShopId);
         if(_loc2_)
         {
            if(displayShowNum < _loc2_.Count)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwarShopItem.displayShowNum.text"));
               return;
            }
            SecretWarManager.Instance.shopOp(1,_data.mapShopId);
         }
      }
      
      public function set data(param1:ExploitsShopRespMsg) : void
      {
         var _loc3_:GoodsInfo = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:SecretwarShopTempInfo = TempleteManager.instance.secretwarShopTempCate.getTempInfoById(_data.mapShopId);
         if(_loc2_)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.ItemId;
            _loc3_.count = _loc2_.Count;
            _goods.data = _loc3_;
            _nameTxt.text = _loc3_.templateInfo.TemplateName;
            _valueTxt.text = _loc2_.MlitaryExploits.toString();
            _buyBtn.visible = _data.state == 0;
            _boughtBtn.visible = _data.state == 1;
            _icon.visible = true;
            _dropImg.visible = _loc2_.IsDrop == 1;
         }
      }
      
      public function get displayShowNum() : int
      {
         return PlayerCurrencyManager.instance.currencyInfo.secretwarShopCoin.amount;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_boughtBtn);
         _boughtBtn = null;
         ObjectUtils.disposeObject(_dropImg);
         _dropImg = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}


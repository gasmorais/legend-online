package gamebox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GameBoxManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GameBoxShopTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class GameBoxExchangeItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _exchangeBtn:IconButton;
      
      private var _itemNameTxt:FilterFrameText;
      
      private var _itemCostTxt:FilterFrameText;
      
      private var _area:int;
      
      private var _shopTempInfo:GameBoxShopTempInfo;
      
      private var _exchangeItemName:String;
      
      private var _itemView:BaseItemView;
      
      private var _medalIcon:CustomBitmap;
      
      public function GameBoxExchangeItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get area() : int
      {
         return _area;
      }
      
      public function set area(param1:int) : void
      {
         _area = param1;
         var _loc2_:int = int(GameBoxManager.instance.mode.info["tempId" + area]);
         _shopTempInfo = TempleteManager.instance.gameBoxTemplateCate.getTemplateById(_loc2_);
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.gamebox.ExchangeItemBg");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("gamebox.ExchagneBtn");
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.exchangeItemNameTxt");
         _itemCostTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.exchangeCostTxt");
         _itemView = ComponentFactory.Instance.creatCustomObject("gamebox.ExchangeItemView");
         _medalIcon = ComponentFactory.Instance.creatCustomObject("gamebox.GameboxMedalIcon1");
         addChild(_bg);
         addChild(_exchangeBtn);
         addChild(_itemNameTxt);
         addChild(_itemCostTxt);
         addChild(_itemView);
         addChild(_medalIcon);
      }
      
      public function updateView() : void
      {
         _exchangeItemName = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_shopTempInfo.ItemTempId).TemplateName;
         _itemNameTxt.text = _exchangeItemName;
         _itemCostTxt.text = _shopTempInfo.NeedPay.toString();
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_shopTempInfo.ItemTempId).TemplateId;
         _loc1_.count = _shopTempInfo.Count;
         _itemView.data = _loc1_;
      }
      
      private function addEvent() : void
      {
         _exchangeBtn.addEventListener("click",onExchangeBtnClick);
      }
      
      private function removeEvent() : void
      {
         if(_exchangeBtn != null)
         {
            _exchangeBtn.removeEventListener("click",onExchangeBtnClick);
         }
      }
      
      private function onExchangeBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("gamebox.view.GameBoxExchangeItem.content",_shopTempInfo.NeedPay,_shopTempInfo.Count,_exchangeItemName);
         SimpleAlertHelper.instance.data = [resetResponseHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("confirmBtn"),LanguageMgr.GetTranslation("cancel"),true,false,false);
      }
      
      private function resetResponseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            GameBoxManager.instance.exchangeItem(_area);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _shopTempInfo = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_itemCostTxt);
         _itemCostTxt = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_medalIcon);
         _medalIcon = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


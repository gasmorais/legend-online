package theseusgodhead.view
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.item.GodheadSellItem;
   import yishi.datas.templates.TheseusSlateUpgradeInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class GodItemSellView extends Frame
   {
      
      public static const SELL_TYPE_DRAGON_TALKER:int = 1;
      
      public static const SLATE_ADD_TO_DECOMPOSE:String = "slateAddToDecompose";
      
      public static const SLATE_REMOVE_FROM_DECOMPOSE:String = "slateRemoveFromDecompose";
      
      public static const DECOMPOSE_MODE_CANCEL:String = "decomposeModeCancel";
      
      public static const DECOMPOSE_VIEW_CLOSE:String = "decomposeViewClose";
      
      private var _bg1:ScaleBitmapImage;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _priceImage:Bitmap;
      
      private var _sellBtn:TextButton;
      
      private var _cancelBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _number:FilterFrameText;
      
      private var _delete:FilterFrameText;
      
      private var _totalPrice:FilterFrameText;
      
      private var _total:int;
      
      private var _panel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<GodheadSellItem>;
      
      private var _sellType:int;
      
      public function GodItemSellView(param1:int = 0)
      {
         super();
         _sellType = param1;
         _itemList = new Vector.<GodheadSellItem>();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("theseusgodhead.decompose.title");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.bg1");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.titleBg");
         _priceImage = ComponentFactory.Instance.creatBitmap("TheseusGodHeaduplvmat1");
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("mailcheck.sendCheckCodeBtn");
         _sellBtn.text = LanguageMgr.GetTranslation("theseusgodhead.decompose.button");
         _sellBtn.x = 11;
         _sellBtn.y = 393;
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.cancelBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.name");
         _number = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.number");
         _delete = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.delete");
         _totalPrice = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.totalPrice");
         _panel = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.panel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.vBox");
         _priceImage.x = 70;
         _priceImage.y = 360;
         addToContent(_bg1);
         addToContent(_titleBg);
         addToContent(_priceImage);
         addToContent(_sellBtn);
         addToContent(_cancelBtn);
         addToContent(_name);
         addToContent(_number);
         _number.x = 114;
         addToContent(_delete);
         addToContent(_totalPrice);
         _name.text = LanguageMgr.GetTranslation("theseusgodhead.decompose.name");
         _number.text = LanguageMgr.GetTranslation("theseusgodhead.decompose.number");
         _delete.text = LanguageMgr.GetTranslation("theseusgodhead.decompose.delete");
         _panel.setView(_vBox);
         addToContent(_panel);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sellBtn.addEventListener("click",__sellHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _vBox.addEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.addEventListener("decomposeItemDelete",__deleteDecomposeItemHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sellBtn.removeEventListener("click",__sellHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _vBox.removeEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.removeEventListener("decomposeItemDelete",__deleteDecomposeItemHandler);
      }
      
      private function __deleteHandler(param1:BagEvent) : void
      {
         param1.stopPropagation();
         GoodsManager.instance.setSellPos(param1.info,false);
         _totalPrice.text = "" + _total;
         _panel.invalidateViewport();
         NotificationManager.instance.sendNotification("FILTR_BY_SELL");
         if(_itemList.length == 0)
         {
            NotificationManager.instance.sendNotification("FILTER_GOODS");
         }
      }
      
      private function __deleteDecomposeItemHandler(param1:Event) : void
      {
         param1.stopPropagation();
         var _loc2_:GodheadSellItem = param1.target as GodheadSellItem;
         if(_loc2_ && _loc2_.stoneInfo)
         {
            _total -= calculateSlateReward(_loc2_.stoneInfo);
            _itemList.splice(_itemList.indexOf(_loc2_),1);
            _totalPrice.text = "" + _total;
            _panel.invalidateViewport();
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
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         _loc6_ = LanguageMgr.GetTranslation("theseusgodhead.decompose.confirm",_loc2_,_total);
         SimpleAlertHelper.instance.data = [__decomposeResponse];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,false,true);
      }
      
      private function __decomposeResponse(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         var _loc4_:Array = null;
         if(param1)
         {
            _loc4_ = [];
            for each(var _loc5_:GodheadSellItem in _itemList)
            {
               if(_loc5_.stoneInfo)
               {
                  _loc4_.push(_loc5_.stoneInfo.stoneId);
               }
            }
            TheseussoulManager.Instance.resolveSlate(_loc4_);
            dispose();
         }
      }
      
      private function __dragonTalkerAlertResponse(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         if(param1)
         {
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function addSlateToDecompose(param1:TheseusGodheadStoneInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_:GodheadSellItem in _itemList)
         {
            if(_loc2_.stoneInfo && _loc2_.stoneInfo.stoneId == param1.stoneId)
            {
               return;
            }
         }
         var _loc3_:GodheadSellItem = new GodheadSellItem();
         _loc3_.stoneInfo = param1;
         _itemList.push(_loc3_);
         _vBox.addChild(_loc3_);
         _panel.invalidateViewport();
         _total += calculateSlateReward(param1);
         _totalPrice.text = "" + _total;
         trace("GodItemSellView: 发{invalid_utf8=233}?? SLATE_ADD_TO_DECOMPOSE，stoneId=" + param1.stoneId);
         NotificationManager.instance.sendNotification("slateAddToDecompose",param1);
      }
      
      public function enableEventListeners() : void
      {
         addEventListener("response",__frameResponse);
         _sellBtn.addEventListener("click",__sellHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _vBox.addEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.addEventListener("decomposeItemDelete",__deleteDecomposeItemHandler);
      }
      
      public function disableEventListeners() : void
      {
         removeEventListener("response",__frameResponse);
         _sellBtn.removeEventListener("click",__sellHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _vBox.removeEventListener("SELLITEM_DELETE",__deleteHandler);
         _vBox.removeEventListener("decomposeItemDelete",__deleteDecomposeItemHandler);
      }
      
      private function calculateSlateReward(param1:TheseusGodheadStoneInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = undefined;
         var _loc8_:TheseusSlateUpgradeInfo = null;
         if(!param1.SlateDecomposition)
         {
            return 0;
         }
         var _loc5_:int = int(param1.SlateDecomposition.split(",")[1]);
         var _loc7_:int = int(param1.level);
         if(_loc7_ == 0)
         {
            return _loc5_;
         }
         _loc4_ = 1;
         _loc3_ = _loc7_;
         _loc6_ = _loc4_;
         while(_loc6_ <= _loc3_)
         {
            _loc2_ = TempleteManager.instance.theseusSlateUpgradeCate;
            if(!_loc2_)
            {
               return 0;
            }
            _loc8_ = _loc2_.getUpgradeTemplate(param1.quality,_loc6_,param1.type);
            if(_loc8_)
            {
               _loc5_ += int(_loc8_.Item.split(",")[1] * 0.9);
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               if(parent)
               {
                  parent.removeChild(this);
               }
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         dispatchEvent(new Event("decomposeViewClose"));
         removeEvent();
         trace("GodItemSellView: dispose，发{invalid_utf8=233}{invalid_utf8=128}? DECOMPOSE_MODE_CANCEL 通知");
         NotificationManager.instance.sendNotification("decomposeModeCancel");
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


package view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import view.inside.ShopTypeTabView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopFrame extends Frame implements IManualSize
   {
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchBt:SimpleBitmapButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _searchBg:Bitmap;
      
      private var _searchContainer:Sprite;
      
      private var _shopTypeTab:ShopTypeTabView;
      
      public function ShopFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("task.view.shopFrame.title");
         _shopTypeTab = new ShopTypeTabView(this);
         _shopTypeTab.y = 18;
         _searchBg = ComponentFactory.Instance.creatBitmap("asset.shop.SearchBg");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchTextStyle1");
         _searchBt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchBtn");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchTipTextStyle");
         _searchContainer = ComponentFactory.Instance.creatCustomObject("shop.SearchContainer");
         _searchContainer.addChild(_searchBg);
         _searchContainer.addChild(_searchTxt);
         _searchContainer.addChild(_searchBt);
         _searchContainer.addChild(_tipTxt);
         addToContent(_shopTypeTab);
         addToContent(_searchContainer);
         _searchTxt.text = "";
         _tipTxt.text = LanguageMgr.GetTranslation("shop.view.ShopFrame.tip");
         searchView(playerInfo.isBackPlayer);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _searchBt.addEventListener("click",__onSerachHandler);
         _searchTxt.addEventListener("focusIn",__onFocusin);
         _searchTxt.addEventListener("focusOut",__onFocusout);
         _searchTxt.addEventListener("keyDown",__onKeydownHandler);
         ShopManager.Instance.model.addEventListener("CURSELECTED_TAB_CHANGE",__shopTabChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _searchBt.removeEventListener("click",__onSerachHandler);
         _searchTxt.removeEventListener("focusIn",__onFocusin);
         _searchTxt.removeEventListener("focusOut",__onFocusout);
         _searchTxt.removeEventListener("keyDown",__onKeydownHandler);
         ShopManager.Instance.model.removeEventListener("CURSELECTED_TAB_CHANGE",__shopTabChangeHandler);
      }
      
      private function __onFocusin(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _tipTxt.visible = false;
      }
      
      private function __onFocusout(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_searchTxt.text))
         {
            _tipTxt.visible = true;
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onSerachHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onSerachHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = _searchTxt.text;
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.ShopFrame.command02"));
            return;
         }
         _shopTypeTab.searchState();
         FrameControllerManager.instance.shopController.searchGoods(_loc2_);
         _tipTxt.visible = false;
         _searchTxt.text = _loc2_;
      }
      
      public function searchView(param1:Boolean) : void
      {
         if(_searchTxt)
         {
            _searchTxt.text = "";
         }
         if(_searchTxt)
         {
            _searchTxt.visible = !param1;
         }
         if(_tipTxt)
         {
            _tipTxt.visible = !param1;
         }
         if(_searchBt)
         {
            _searchBt.visible = !param1;
         }
         if(_searchBg)
         {
            _searchBg.visible = !param1;
         }
      }
      
      private function __shopTabChangeHandler(param1:ShopEvent) : void
      {
         var _loc2_:* = param1.data;
         if("SHOP_FASHION" !== _loc2_)
         {
            _searchContainer.x = 221;
            _searchContainer.y = 424;
         }
         else
         {
            _searchContainer.x = 221;
            _searchContainer.y = 424;
         }
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         _searchContainer.x = 221;
         _searchContainer.y = 424;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,973,600);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         if(isAddToPool)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            _loc1_ = StageReferance.stage.focus as DisplayObject;
            if(_loc1_ && contains(_loc1_))
            {
               StageReferance.stage.focus = null;
            }
            ComponentFactory.Instance.preStylename = "";
            KeyBoardRegister.instance.keyEnable = true;
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchBt);
         _searchBt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_searchBg);
         _searchBg = null;
         ObjectUtils.disposeObject(_shopTypeTab);
         _shopTypeTab = null;
         ObjectUtils.disposeAllChildren(_searchContainer);
         _searchContainer = null;
         super.dispose();
      }
   }
}


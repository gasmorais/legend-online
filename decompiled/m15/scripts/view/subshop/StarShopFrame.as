package view.subshop
{
   import chat.datas.ChatData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.star.StarShopMsg;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopModel;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StarShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _displayShow:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<StarShopItem>;
      
      public function StarShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:StarShopItem = null;
         titleText = LanguageMgr.GetTranslation("star.StarShopFrame.title");
         _data = FrameControllerManager.instance.shopController.model;
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.ShopBgAsset");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.ShopBgAsset");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground2");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton_2");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn_2");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn_2");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle_2");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle_2");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.StarDisplayShowTxt");
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = playerInfo.starPoint.toString();
         addToContent(_bg);
         addToContent(_bg1);
         _bg1.scaleX = -1;
         _bg1.x = _bg.x;
         addToContent(_displayShow);
         _displayShow.x = 11;
         _displayShow.y = 336;
         addToContent(_back);
         addToContent(_displayShowTxt);
         addToContent(_signButton);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageNumTxt);
         addToContent(_contributeTxt);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<StarShopItem>();
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new StarShopItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = _loc2_ * _loc1_.width + 11;
            _loc1_.y = _loc4_ * _loc1_.height;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         playerInfo.addEventListener("STAR_POINT_UPDATE",__starPointUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4261,__exchangeStarHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         playerInfo.removeEventListener("STAR_POINT_UPDATE",__starPointUpdateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4261,__exchangeStarHandler);
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initStarShopFrame();
      }
      
      private function __exchangeStarHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:StarTemplate = null;
         var _loc5_:ChatData = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarShopMsg = new StarShopMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as StarShopMsg;
         var _loc3_:String = "";
         if(_loc2_.result == 1)
         {
            _loc3_ = LanguageMgr.GetTranslation("star.StarShopFrame.command01");
            MessageTipManager.instance().show(_loc3_);
            _loc4_ = TempleteManager.instance.starTempalteCate.getTemplateByID(_loc2_.goodId);
            if(_loc4_)
            {
               _loc5_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc5_.channel = 3;
               _loc3_ = LanguageMgr.GetTranslation("star.StarShopFrame.chatData",_loc4_.TemplateName);
               _loc5_.msg = _loc3_;
               _loc5_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
            }
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("star.StarShopFrame.command02");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __starPointUpdateHandler(param1:PlayerEvent) : void
      {
         _contributeTxt.text = String(playerInfo.starPoint);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? StarTemplate(_data.showGoodsList[_loc2_]) : null;
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _data = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_signButton);
         _signButton = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_displayShowTxt);
         _displayShowTxt = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         for each(var _loc1_:StarShopItem in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


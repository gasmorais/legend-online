package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.ShopControler;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class MineralShopFrame extends Frame implements IManualSize
   {
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _bg3:Scale9CornerImage;
      
      private var _describe:FilterFrameText;
      
      private var _minerals:FilterFrameText;
      
      private var _mineralBack:MutipleImage;
      
      private var _vBox:VBox;
      
      private var _goodsList:Array;
      
      private var _stripView:StripView;
      
      public function MineralShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,424,475);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MineralShopItem = null;
         _goodsList = goodsList;
         _goodsList.sort(shopControl.mineralShopGoodsSort);
         _loc2_ = 0;
         while(_loc2_ < _goodsList.length)
         {
            _loc1_ = new MineralShopItem();
            _loc1_.data = _goodsList[_loc2_];
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.subshop.MineralShopFrame.title");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.bg1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.bg2");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.bg3");
         _describe = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.describeText");
         _mineralBack = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.mineralBack");
         _minerals = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.minerals");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralShopFrame.vBox");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.mineralsTip.StripView");
         addToContent(_bg1);
         addToContent(_bg2);
         addToContent(_bg3);
         addToContent(_mineralBack);
         addToContent(_describe);
         addToContent(_minerals);
         addToContent(_vBox);
         addToContent(_stripView);
         _stripView.setHitArea(0,0,30,27);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-200);
         if(_loc1_)
         {
            _stripView.tipData = _loc1_.Description;
         }
         _describe.text = LanguageMgr.GetTranslation("view.subshop.MineralShopFrame.describe");
         _minerals.text = playerInfo.mineral + "";
      }
      
      private function get goodsList() : Array
      {
         return shopControl.mineralShopGoods;
      }
      
      private function get shopControl() : ShopControler
      {
         return FrameControllerManager.instance.shopController;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__updateHandler);
      }
      
      protected function __updateHandler(param1:PlayerEvent) : void
      {
         if(_minerals)
         {
            _minerals.text = playerInfo.mineral + "";
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         if(_bg1)
         {
            _bg1.dispose();
         }
         _bg1 = null;
         if(_bg2)
         {
            _bg2.dispose();
         }
         _bg2 = null;
         if(_bg3)
         {
            _bg3.dispose();
         }
         _bg3 = null;
         if(_mineralBack)
         {
            _mineralBack.dispose();
         }
         _mineralBack = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_minerals)
         {
            _minerals.dispose();
         }
         _minerals = null;
         if(_stripView)
         {
            _stripView.dispose();
         }
         _stripView = null;
         _goodsList = null;
         super.dispose();
      }
   }
}


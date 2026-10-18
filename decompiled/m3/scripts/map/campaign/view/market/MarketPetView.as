package map.campaign.view.market
{
   import cell.mediator.marketbag.MarketSellAlertFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import farm.view.FarmPetListItemView;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MarketPetView extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _listPanel:ScrollPanel;
      
      private var _list:Array;
      
      private var _canBeSellPet:Array;
      
      public function MarketPetView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("auction.view.sell.PetSellView.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.back");
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("farm.PetVBox");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.ScrollPanel");
         _listPanel.vScrollProxy = 1;
         addToContent(_bg);
         addToContent(_listPanel);
         _vBox.mouseEnabled = false;
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FarmPetListItemView = null;
         removeEvent();
         _vBox.disposeAllChildren();
         _list = [];
         _canBeSellPet = getCanBeSellPet();
         _loc2_ = 0;
         while(_loc2_ < _canBeSellPet.length)
         {
            _loc1_ = new FarmPetListItemView();
            _loc1_.data = _canBeSellPet[_loc2_] as PetData;
            _list.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _listPanel.setView(_vBox);
         _listPanel.invalidateViewport();
         addEvent();
         if(_canBeSellPet.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.sell.PetSellView.noPetToSell"));
            _bg.height = 65;
            height = 140;
            width = 240;
         }
         else if(_canBeSellPet.length <= 5)
         {
            _bg.height = _vBox.height + 10;
            height = _vBox.height + 75;
            width = 240;
         }
         else
         {
            _bg.height = 293;
            height = 358;
            width = 250;
         }
      }
      
      private function getCanBeSellPet() : Array
      {
         var _loc4_:PetData = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = playerInfo.petList;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as PetData;
            if(!_loc4_.isBind && !_loc4_.isEnterWar && !_loc4_.isPractice && playerInfo.petChallengeFormationOfArray.indexOf(_loc4_.petId + "") < 0)
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         addEventListener("response",__responseHandler);
         if(_list)
         {
            _loc1_ = 0;
            while(_loc1_ < _list.length)
            {
               _list[_loc1_].addEventListener("rollOver",__mouseOverHandler);
               _list[_loc1_].addEventListener("rollOut",__mouseOutHandler);
               _list[_loc1_].addEventListener("click",__moveToSellCell);
               _list[_loc1_].addEventListener("doubleClick",__moveToSellCell);
               _loc1_++;
            }
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         removeEventListener("response",__responseHandler);
         if(_list)
         {
            _loc1_ = 0;
            while(_loc1_ < _list.length)
            {
               _list[_loc1_].removeEventListener("rollOver",__mouseOverHandler);
               _list[_loc1_].removeEventListener("rollOut",__mouseOutHandler);
               _list[_loc1_].removeEventListener("click",__moveToSellCell);
               _list[_loc1_].removeEventListener("doubleClick",__moveToSellCell);
               _loc1_++;
            }
         }
      }
      
      private function __moveToSellCell(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc7_:int = 0;
         var _loc6_:MarketSellAlertFrame = null;
         var _loc4_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc4_ && _loc4_.data)
         {
            if(_loc4_.data.isLock)
            {
               _loc5_ = LanguageMgr.GetTranslation("vicepassword.description10");
               MessageTipManager.instance().show(_loc5_);
               return;
            }
            _loc3_ = -1;
            _loc7_ = 0;
            while(_loc7_ < 12)
            {
               if(!model.selfStall.items[_loc7_])
               {
                  _loc3_ = _loc7_;
                  break;
               }
               _loc7_++;
            }
            if(_loc3_ < 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("mediator.market.MarketBagCellClickMediator.full");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("market.MarketSellAlertFrame");
            _loc6_.show(_loc4_.data.convertToGoods(),_loc3_);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOut();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         refresh();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _list = [];
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


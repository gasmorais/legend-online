package auction.view.sell
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import farm.view.FarmPetListItemView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PetSellView extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _listPanel:ScrollPanel;
      
      private var _list:Array;
      
      private var canBeSellPet:Array;
      
      public function PetSellView()
      {
         super();
         initView();
         if(stage)
         {
            refresh();
         }
         else
         {
            addEventListener("addedToStage",__onStage);
         }
      }
      
      private function __onStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onStage);
         refresh();
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
         canBeSellPet = getCanBeSellPet();
         _loc2_ = 0;
         while(_loc2_ < canBeSellPet.length)
         {
            _loc1_ = new FarmPetListItemView();
            _loc1_.data = canBeSellPet[_loc2_] as PetData;
            _loc1_.setType(1);
            _list.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _listPanel.setView(_vBox);
         _listPanel.invalidateViewport();
         addEvent();
         if(canBeSellPet.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.sell.PetSellView.noPetToSell"));
            _bg.height = 65;
            height = 140;
            width = 240;
         }
         else if(canBeSellPet.length <= 5)
         {
            _bg.height = _vBox.height + 10;
            height = _vBox.height + 75;
            width = 240;
         }
         else
         {
            _bg.height = 233;
            height = 358;
            width = 260;
         }
      }
      
      private function getCanBeSellPet() : Array
      {
         var _loc5_:PetData = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc2_:Array = _loc3_.petList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_] as PetData;
            if(!_loc5_.isBind && !_loc5_.isEnterWar && !_loc5_.isPractice && _loc3_.petChallengeFormationOfArray.indexOf(_loc5_.petId + "") < 0)
            {
               _loc1_.push(_loc5_);
            }
            _loc4_++;
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
         var _loc2_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc2_)
         {
            AuctionGoodMoveControl.moveToTargetCell(_loc2_.cell);
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
               hide();
         }
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         AuctionGoodMoveControl.playBlink();
         AuctionGoodMoveControl.isFirstOpenSellPane = false;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2);
         AuctionGoodMoveControl.stopBlink();
      }
      
      public function isOpen() : Boolean
      {
         if(parent)
         {
            return true;
         }
         return false;
      }
      
      public function getBagPane() : Disposeable
      {
         return this;
      }
      
      override public function dispose() : void
      {
         removeEventListener("addedToStage",__onStage);
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


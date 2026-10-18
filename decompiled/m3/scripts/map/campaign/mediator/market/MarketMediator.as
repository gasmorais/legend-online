package map.campaign.mediator.market
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.MarketModel;
   import map.campaign.data.StallInfo;
   import map.campaign.view.market.MarketBagFrame;
   import map.campaign.view.market.MarketBuyFrame;
   import map.campaign.view.physics.MarketArmyView;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class MarketMediator implements IMediator
   {
      
      private var _sellBtn:BaseButton;
      
      private var _buyFrame:MarketBuyFrame;
      
      private var _bagFrame:MarketBagFrame;
      
      public function MarketMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("MarketMediator.sellbtn");
         LayerManager.Instance.addToLayer(_sellBtn,4,false);
         __resizeHandler(null);
         _sellBtn.visible = ArmyManager.instance.thane.grades >= 40;
         initEvent();
         TopToolsBar.instance.mopupIng();
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         if(_sellBtn)
         {
            _sellBtn.dispose();
         }
         _sellBtn = null;
         TopToolsBar.instance.mopupEnd();
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         if(_sellBtn)
         {
            _sellBtn.addEventListener("click",__sellBtnClickHandler);
         }
         MsgMan.addObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("click",__sellBtnClickHandler);
         }
         MsgMan.removeObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_sellBtn)
         {
            _sellBtn.x = StageReferance.stageWidth - 530;
         }
         if(_sellBtn)
         {
            _sellBtn.y = StageReferance.stageHeight - 150;
         }
      }
      
      private function __sellBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MarketArmyView = null;
         if(selfArmy.sellState != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mediator.mapview.CampaignMapMouseEventMediator.inSell"));
         }
         else if(ArmyManager.instance.thane.grades >= 40)
         {
            if(_sellBtn)
            {
               _sellBtn.enable = false;
            }
            selfArmy.sellState = 1;
            _loc2_ = CampaignManager.instance.controller.getArmyView(selfArmy) as MarketArmyView;
            if(_loc2_)
            {
               _loc2_.aiInfo.pathInfo = [];
            }
            model.lockPos(selfArmy.curPosX,selfArmy.curPosY);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",40));
         }
      }
      
      private function __opbackHandler(param1:String, param2:Object) : void
      {
         var _loc3_:StallInfo = null;
         if(param2)
         {
            if(param2.type == 1)
            {
               if(param2.isSuccess)
               {
                  if(_bagFrame)
                  {
                     _bagFrame.dispose();
                  }
                  _bagFrame = ComponentFactory.Instance.creatComponentByStylename("market.MarketBagFrame");
                  _bagFrame.show();
               }
               _loc3_ = model.stalls[playerInfo.userId] as StallInfo;
               if(selfArmy)
               {
                  if(_loc3_)
                  {
                     selfArmy.sellState = _loc3_.state;
                  }
                  else
                  {
                     selfArmy.sellState = 0;
                  }
               }
               if(_sellBtn)
               {
                  _sellBtn.enable = true;
               }
            }
            else if(param2.type == 6 && model.stalls[param2.userId])
            {
               if(param2.isSuccess)
               {
                  if(_buyFrame && _buyFrame.isDie == false)
                  {
                     _buyFrame.data = model.stalls[param2.userId];
                  }
                  else
                  {
                     _buyFrame = ComponentFactory.Instance.creatComponentByStylename("market.MarketBuyFrame");
                     _buyFrame.data = model.stalls[param2.userId];
                     _buyFrame.show();
                  }
               }
            }
         }
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      private function get selfArmy() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}


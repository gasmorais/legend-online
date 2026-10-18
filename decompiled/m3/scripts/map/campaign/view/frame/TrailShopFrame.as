package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.TrialInfoMsg;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.view.ui.TrailShopItem;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class TrailShopFrame extends Frame
   {
      
      private static const ITEM_COUNT:int = 4;
      
      private var _vbox:VBox;
      
      private var _itemList:Array;
      
      public function TrailShopFrame()
      {
         super();
         initView();
         initEvent();
         refrehView();
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.Title");
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TrailShopItem = null;
         _itemList = [];
         _vbox = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.TrailIBox");
         addToContent(_vbox);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("campaign.TrailShop.TrailItem",[_loc2_ + 1]);
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refrehView() : void
      {
         for each(var _loc1_:TrailShopItem in _itemList)
         {
            _loc1_.data = CampaignManager.instance.trialModel.getShopItemByIndex(_loc1_.index - 1);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4467,__buyResuleHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4467,__buyResuleHandler);
      }
      
      private function __buyResuleHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TrialInfoMsg = new TrialInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TrialInfoMsg;
         if(_loc2_.param1 != 0)
         {
            for each(var _loc3_:TrailShopItem in _itemList)
            {
               if(_loc3_.data.id == _loc2_.skillId)
               {
                  _loc3_.data.currentCount = _loc2_.count;
                  _loc3_.data = _loc3_.data;
               }
            }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TrailShopItem in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         _itemList = null;
         super.dispose();
      }
   }
}


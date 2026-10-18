package consortia.view.myConsortia.building
{
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import bag.view.ItemSellView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaCaseFrame extends Frame
   {
      
      private var _leftBg:Scale9CornerImage;
      
      private var _rightBg:Image;
      
      private var _bagView:ConsortiaBagView;
      
      private var _caseView:ConsortiaCaseView;
      
      private var _sellView:ItemSellView;
      
      public function ConsortiaCaseFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get bagView() : ConsortiaBagView
      {
         return _bagView;
      }
      
      private function initView() : void
      {
         var _loc1_:int = int(FrameControllerManager.instance.consortiaController.model.consortiaInfo.storeLevel);
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaCaseFrame.titleText",_loc1_);
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseFrameLeftDescribeBackground");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseFrameRightDescribeBackground");
         _bagView = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaBagView");
         _caseView = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaCaseView");
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_bagView);
         addToContent(_caseView);
         FrameControllerManager.instance.consortiaController.model.caseBag = _caseView.caseBag;
      }
      
      public function get itemList() : Vector.<BaseItemView>
      {
         return _caseView.caseBag.itemList;
      }
      
      private function uninit() : void
      {
         FrameControllerManager.instance.consortiaController.model.caseBag = null;
         if(_leftBg)
         {
            ObjectUtils.disposeObject(_leftBg);
         }
         _leftBg = null;
         if(_rightBg)
         {
            ObjectUtils.disposeObject(_rightBg);
         }
         _rightBg = null;
         if(_bagView)
         {
            ObjectUtils.disposeObject(_bagView);
         }
         _bagView = null;
         if(_caseView)
         {
            ObjectUtils.disposeObject(_caseView);
         }
         _caseView = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         BagHelper.instance.addEventListener("SELL_GOODS",__openSellViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         BagHelper.instance.removeEventListener("SELL_GOODS",__openSellViewHandler);
      }
      
      private function __openSellViewHandler(param1:BagEvent) : void
      {
         if(!_sellView)
         {
            _sellView = ComponentFactory.Instance.creatComponentByStylename("army.ItemSellView");
            _sellView.addEventListener("dispose",__disposeHandler);
            addChildAt(_sellView,0);
            _sellView.x = 711;
            _sellView.y = 21;
            this.x = (StageReferance.gameStageWidth - _sellView.width - _sellView.x) / 2;
         }
         if(_bagView)
         {
            _bagView.operEnble = false;
         }
         _sellView.addSellGoods(param1.info);
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler);
         }
         this.x = (StageReferance.gameStageWidth - width) / 2;
         if(_bagView)
         {
            _bagView.operEnble = true;
         }
         _sellView = null;
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
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.ARMYFRAMEII_OPEN_FOR_GEMMAZE));
      }
      
      override public function dispose() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent(NotificationEvent.ARMYFRAMEII_CLOSE_FOR_GEMMAZE));
         removeEvent();
         uninit();
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}


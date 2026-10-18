package secretadventure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretEventInfo;
   import secretadventure.item.SecretShopItem;
   import utils.LogicUtils;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SecretAdventerManager;
   
   public class SecretShopFrame extends Frame
   {
      
      private var _titleImage:Image;
      
      private var _eventBg:ScaleBitmapImage;
      
      private var _eventIcon:Image;
      
      private var _goodsHbox:HBox;
      
      private var _eventInfo:SecretEventInfo;
      
      private var _itemList:Vector.<SecretShopItem>;
      
      public function SecretShopFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.titleBg");
         _eventIcon = ComponentFactory.Instance.creatComponentByStylename("PlanesBlackFrame.eventIcon");
         _eventBg = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.eventBg");
         _goodsHbox = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.goodsHbox");
         addToContent(_titleImage);
         addToContent(_eventIcon);
         addToContent(_eventBg);
         addToContent(_goodsHbox);
         _goodsHbox.spacing = 0;
         _itemList = new Vector.<SecretShopItem>();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         model.addEventListener("SecretAdEvent.mapEventUpadate",refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         model.removeEventListener("SecretAdEvent.mapEventUpadate",refreshView);
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:SecretEventInfo) : void
      {
         _eventInfo = param1;
         refreshView();
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      private function refreshView(param1:Event = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:SecretShopItem = null;
         var _loc3_:Array = _eventInfo.params.split("@");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_].split("#");
            _loc2_ = _loc5_ < _itemList.length ? _itemList[_loc5_] : null;
            if(_loc2_ == null)
            {
               _loc2_ = new SecretShopItem();
               _itemList[_loc5_] = _loc2_;
               _goodsHbox.addChild(_loc2_);
            }
            _loc2_.index = _loc5_;
            _loc2_.eventInfo = _eventInfo;
            _loc2_.dataArr = _loc4_;
            _loc5_++;
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         for each(var _loc1_:SecretShopItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         if(_titleImage)
         {
            ObjectUtils.disposeObject(_titleImage);
         }
         _titleImage = null;
         if(_eventBg)
         {
            ObjectUtils.disposeObject(_eventBg);
         }
         _eventBg = null;
         if(_eventBg)
         {
            ObjectUtils.disposeObject(_eventBg);
         }
         _eventBg = null;
         if(_goodsHbox)
         {
            ObjectUtils.disposeObject(_goodsHbox);
         }
         _goodsHbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
         _eventInfo = null;
      }
   }
}


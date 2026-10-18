package matelords.room
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MatelordsEvent;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.matelords.MatelordsModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.MatelordsManager;
   
   public class MatelordsDemonShopFrame extends Frame
   {
      
      private static const ITEM_COUNT:int = 4;
      
      private var _propBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _border:Scale9CornerImage;
      
      private var _vbox:VBox;
      
      private var _demonScoreText:FilterFrameText;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var _itemList:Array;
      
      public function MatelordsDemonShopFrame()
      {
         super();
         initView();
         initItemView();
         MatelordsManager.instance.sendRequestDemoOp(1);
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopFrame.propBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopFrame.skillBtn");
         _border = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopFrame.border");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopFrame.vbox");
         _demonScoreText = ComponentFactory.Instance.creatComponentByStylename("MatelordsDemonShopFrame.demonScoreText");
         addToContent(_propBtn);
         addToContent(_skillBtn);
         addToContent(_border);
         addToContent(_vbox);
         addToContent(_demonScoreText);
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(_propBtn);
         btnGroup.addSelectItem(_skillBtn);
         btnGroup.selectIndex = 0;
      }
      
      private function initItemView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MatelordsDemonShopItem = null;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("matelords.MatelordsDemonShopItem");
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refrehView() : void
      {
         var _loc3_:int = 0;
         _demonScoreText.text = LanguageMgr.GetTranslation("MatelordsDemonShopFrame.demonScoreText.text",model.altarScore);
         var _loc2_:int = int(_itemList.length);
         var _loc1_:Array = model.getDemonShoShowList(btnGroup.selectIndex);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _itemList[_loc3_].data = _loc1_[_loc3_] ? _loc1_[_loc3_] : null;
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGroup.addEventListener("change",__onBtnSelectHandler);
         model.addEventListener("DEMON_LIST_UPDATE",__demonShopListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGroup.removeEventListener("change",__onBtnSelectHandler);
         model.removeEventListener("DEMON_LIST_UPDATE",__demonShopListHandler);
      }
      
      private function __onBtnSelectHandler(param1:Event) : void
      {
         SoundManager.instance.play("022",false,false);
         refrehView();
      }
      
      private function __demonShopListHandler(param1:MatelordsEvent) : void
      {
         refrehView();
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
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         titleText = LanguageMgr.GetTranslation("matelords.room.MatelordsDemonShopFrame.titleText");
      }
      
      private function get model() : MatelordsModel
      {
         return MatelordsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_demonScoreText);
         _demonScoreText = null;
         for each(var _loc1_:MatelordsDemonShopItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         _itemList = null;
         super.dispose();
      }
   }
}


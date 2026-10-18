package theseus.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureBagView extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _bagScroll:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _equipBtn:IconButton;
      
      private var _type:int;
      
      private var _endPos:int = 0;
      
      private var _group:SelectedButtonGroup;
      
      private var _selectedCell:TreasureCell;
      
      public function TreasureBagView(param1:int, param2:int)
      {
         super();
         _type = param1;
         _endPos = param2;
         initView();
         refreshView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("TreasureBagView.titleText.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.treasureBagBg");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("TreasureBagView.equipBtn");
         _list = ComponentFactory.Instance.creatCustomObject("TreasureBagView.SimpleTileList",[5]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("TreasureBagView.ScrollPanel");
         _bagScroll.setView(_list);
         addToContent(_bg);
         addToContent(_bagScroll);
         addToContent(_equipBtn);
         _equipBtn.enable = false;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 115,refreshView);
         _group.addEventListener("change",__onTabBtnHandler);
         MsgMan.addObserver("notVICE_PASSWORD_LOCK",this,nextaddEvent);
         MsgMan.addObserver("VICE_PASSWORD_LOCK",this,nextremEvent);
         _equipBtn.addEventListener("click",__equipBtnClickHandler);
      }
      
      private function nextaddEvent(param1:String, param2:Object) : void
      {
         _group.addEventListener("change",__onTabBtnHandler);
      }
      
      private function nextremEvent(param1:String, param2:Object) : void
      {
         _group.removeEventListener("change",__onTabBtnHandler);
         _equipBtn.enable = false;
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 115,refreshView);
         MsgMan.removeObserver("notVICE_PASSWORD_LOCK",this,nextaddEvent);
         MsgMan.removeObserver("VICE_PASSWORD_LOCK",this,nextremEvent);
         _group.removeEventListener("change",__onTabBtnHandler);
         _equipBtn.removeEventListener("click",__equipBtnClickHandler);
      }
      
      private function __equipBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:Array = null;
         if(_selectedCell)
         {
            _loc3_ = _selectedCell.data;
            if(_loc3_)
            {
               _loc2_ = GoodsManager.instance.getTreasureEquipBagList();
               for each(var _loc4_:GoodsInfo in _loc2_)
               {
                  if(_loc4_.templateInfo.SonType == 751 && _loc4_.pos != _endPos)
                  {
                     if(_loc4_.templateInfo.Property4 == _loc3_.templateInfo.Property4)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("TreasureBagView.equipClick.text"));
                        return;
                     }
                  }
               }
               PlayerManager.instance.moveBagToBag(_loc3_.bagType,_loc3_.objectId,_loc3_.pos,39,0,_endPos,1);
               dispatchEvent(new FrameEvent(0));
            }
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         _selectedCell = _group.getSelectedItem() as TreasureCell;
         _equipBtn.enable = true;
      }
      
      public function refreshView(param1:Object = null) : void
      {
         var _loc6_:int = 0;
         var _loc5_:TreasureCell = null;
         var _loc2_:Array = GoodsManager.instance.getTreasureBagListByType(_type);
         var _loc3_:int = int(_loc2_.length);
         _loc3_ = Math.ceil(_loc3_ / 5) * 5;
         var _loc4_:int = int(_loc3_ > 25 ? _loc3_ : 25);
         _group = new SelectedButtonGroup();
         _list.disposeAllChildren();
         _list.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = ComponentFactory.Instance.creatCustomObject("TreasureBagView.treasureCell");
            if(_loc6_ < _loc3_)
            {
               _loc5_.data = _loc2_[_loc6_];
               if(_loc5_.data)
               {
                  _group.addSelectItem(_loc5_);
               }
            }
            _list.addChild(_loc5_);
            _loc6_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         if(_bagScroll.vScrollbar.visible)
         {
            _bagScroll.x = 8;
         }
         else
         {
            _bagScroll.x = 17;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeAllChildren(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeAllChildren(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


package outyard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardUserInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardMemberFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _type:int;
      
      private var _nomalBtn:SelectedIconButton;
      
      private var _seniorBtn:SelectedIconButton;
      
      private var _areaSelectedGroup:SelectedButtonGroup;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _spaceLine1:Bitmap;
      
      private var _spaceLine2:Bitmap;
      
      private var _spaceLine3:Bitmap;
      
      private var _spaceLine4:Bitmap;
      
      private var _sortText1:FilterFrameText;
      
      private var _sortText2:FilterFrameText;
      
      private var _sortText3:FilterFrameText;
      
      private var _sortText4:FilterFrameText;
      
      private var _sortText5:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _itemList:Vector.<OutyardMemberItem>;
      
      public function OutyardMemberFrame()
      {
         super();
         initView();
         addEvent();
         _areaSelectedGroup.selectIndex = 0;
         OutyardManager.instance.OperateOutyard(7);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,569,543);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("outyard.MemberViewBg");
         _nomalBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.nomalBtn");
         _seniorBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.seniorBtn");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("outyard.TitleBg");
         _spaceLine1 = ComponentFactory.Instance.creatBitmap("asset.outyard.spaceLine");
         _spaceLine2 = ComponentFactory.Instance.creatBitmap("asset.outyard.spaceLine");
         _spaceLine3 = ComponentFactory.Instance.creatBitmap("asset.outyard.spaceLine");
         _spaceLine4 = ComponentFactory.Instance.creatBitmap("asset.outyard.spaceLine");
         _sortText1 = ComponentFactory.Instance.creatComponentByStylename("outyard.sortText");
         _sortText2 = ComponentFactory.Instance.creatComponentByStylename("outyard.sortText");
         _sortText3 = ComponentFactory.Instance.creatComponentByStylename("outyard.sortText");
         _sortText4 = ComponentFactory.Instance.creatComponentByStylename("outyard.sortText");
         _sortText5 = ComponentFactory.Instance.creatComponentByStylename("outyard.sortText");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardMemberView.Vbox");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardMemberView.ScrollPanel");
         addToContent(_back);
         addToContent(_nomalBtn);
         addToContent(_seniorBtn);
         addToContent(_titleBg);
         addToContent(_spaceLine1);
         _spaceLine1.x = 90;
         addToContent(_spaceLine2);
         _spaceLine2.x = 210;
         addToContent(_spaceLine3);
         _spaceLine3.x = 315;
         addToContent(_spaceLine4);
         _spaceLine4.x = 430;
         addToContent(_sortText1);
         _sortText1.x = -10;
         addToContent(_sortText2);
         _sortText2.x = 93;
         addToContent(_sortText3);
         _sortText3.x = 207;
         addToContent(_sortText4);
         _sortText4.x = 318;
         _sortText4.height = 37;
         _sortText4.wordWrap = true;
         addToContent(_sortText5);
         _sortText5.x = 416;
         addToContent(_scrolPanel);
         _areaSelectedGroup = new SelectedButtonGroup();
         _areaSelectedGroup.addSelectItem(_nomalBtn);
         _areaSelectedGroup.addSelectItem(_seniorBtn);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox);
         _scrolPanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _areaSelectedGroup.addEventListener("change",__onSelectedChangeHandler);
         NotificationManager.instance.addEventListener("OUTYARD_USERLIST_INFO",__userlistHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _areaSelectedGroup.removeEventListener("change",__onSelectedChangeHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_USERLIST_INFO",__userlistHandler);
      }
      
      private function __userlistHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:* = _areaSelectedGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _nomalBtn:
               _type = 0;
               _sortText1.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText1");
               _sortText2.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText2");
               _sortText3.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText3");
               _sortText4.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText4");
               _sortText4.y = 41;
               _sortText5.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText5");
               break;
            case _seniorBtn:
               _type = 1;
               _sortText1.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText1");
               _sortText2.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText2");
               _sortText3.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText4");
               _sortText4.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText6");
               _sortText4.y = 31;
               _sortText5.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText7");
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:OutyardMemberItem = null;
         var _loc6_:* = null;
         var _loc1_:Array = OutyardManager.instance.crystalModel.getMemberArrByType(_type);
         _vBox.beginChanges();
         clearList();
         var _loc2_:int = 0;
         if(!_itemList)
         {
            _itemList = new Vector.<OutyardMemberItem>();
         }
         var _loc4_:int = 0;
         var _loc5_:Array = _loc1_;
         for each(_loc6_ in _loc5_)
         {
            _loc3_ = new OutyardMemberItem();
            _loc3_.type = _type;
            _loc3_.data = _loc6_;
            _loc3_.index = _loc4_++;
            _itemList.push(_loc3_);
            _vBox.addChild(_loc3_);
            _loc2_++;
         }
         while(_loc4_ < 11)
         {
            _loc3_ = new OutyardMemberItem();
            _loc3_.type = _type;
            _loc3_.data = null;
            _loc3_.index = _loc4_++;
            _itemList.push(_loc3_);
            _vBox.addChild(_loc3_);
         }
         _vBox.refreshChildPos();
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
      }
      
      private function clearList() : void
      {
         while(_itemList && _itemList.length > 0)
         {
            ObjectUtils.disposeObject(_itemList.pop());
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
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         OutyardManager.instance.crystalModel.clearMemberList();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_nomalBtn);
         _nomalBtn = null;
         ObjectUtils.disposeObject(_seniorBtn);
         _seniorBtn = null;
         ObjectUtils.disposeObject(_areaSelectedGroup);
         _areaSelectedGroup = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_spaceLine1);
         _spaceLine1 = null;
         ObjectUtils.disposeObject(_spaceLine2);
         _spaceLine2 = null;
         ObjectUtils.disposeObject(_spaceLine3);
         _spaceLine3 = null;
         ObjectUtils.disposeObject(_spaceLine4);
         _spaceLine4 = null;
         ObjectUtils.disposeObject(_sortText1);
         _sortText1 = null;
         ObjectUtils.disposeObject(_sortText2);
         _sortText2 = null;
         ObjectUtils.disposeObject(_sortText3);
         _sortText3 = null;
         ObjectUtils.disposeObject(_sortText4);
         _sortText4 = null;
         ObjectUtils.disposeObject(_sortText5);
         _sortText5 = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
         }
         super.dispose();
      }
   }
}


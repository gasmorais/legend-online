package dayguide.gameguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.gameguide.GameGuideModel;
   
   public class GameGuideView extends Sprite implements Disposeable
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleBitmapImage;
      
      private var _btnVBox:VBox;
      
      private var _goldBtn:SelectedIconTextButton;
      
      private var _equipBtn:SelectedIconTextButton;
      
      private var _expBtn:SelectedIconTextButton;
      
      private var _soulBtn:SelectedIconTextButton;
      
      private var _crystalBtn:SelectedIconTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<GameGuideItem>;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _currentList:Array;
      
      private var _model:GameGuideModel;
      
      public function GameGuideView()
      {
         super();
         initView();
         initEvent();
         initState();
      }
      
      private function initState() : void
      {
         if(_btnGroup)
         {
            _btnGroup.selectIndex = 0;
         }
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("dayGuide.GameGuideView.Back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("dayGuide.GameGuideView.Back2");
         _goldBtn = ComponentFactory.Instance.creatComponentByStylename("dayguide.goldBtn.SelectedIconTextButton");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("dayguide.equipBtn.SelectedIconTextButton");
         _expBtn = ComponentFactory.Instance.creatComponentByStylename("dayguide.expBtn.SelectedIconTextButton");
         _soulBtn = ComponentFactory.Instance.creatComponentByStylename("dayguide.soulBtn.SelectedIconTextButton");
         _crystalBtn = ComponentFactory.Instance.creatComponentByStylename("dayguide.crystalBtn.SelectedIconTextButton");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("dayguide.gameGuide.scrollPanel");
         _btnVBox = new VBox();
         _btnVBox.x = _btnVBox.y = 4;
         _btnGroup = new SelectedButtonGroup();
         _itemList = new Vector.<GameGuideItem>();
         _itemVBox = new VBox();
         _currentList = [];
         _goldBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.goldBtn.text");
         _equipBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.equipBtn.text");
         _expBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.expBtn.text");
         _soulBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.soulBtn.text");
         _crystalBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.crystalBtn.text");
         addChild(_back1);
         addChild(_back2);
         addChild(_btnVBox);
         addChild(_scrollPanel);
         _btnVBox.addChild(_goldBtn);
         _btnVBox.addChild(_equipBtn);
         _btnVBox.addChild(_expBtn);
         _btnVBox.addChild(_soulBtn);
         _btnVBox.addChild(_crystalBtn);
         _btnGroup.addSelectItem(_goldBtn);
         _btnGroup.addSelectItem(_equipBtn);
         _btnGroup.addSelectItem(_expBtn);
         _btnGroup.addSelectItem(_soulBtn);
         _btnGroup.addSelectItem(_crystalBtn);
         _scrollPanel.setView(_itemVBox);
         _model = new GameGuideModel();
      }
      
      private function initEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__selectedChangHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__selectedChangHandler);
         }
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_btnGroup.selectIndex == -1)
         {
            return;
         }
         switch(_btnGroup.getSelectedItem())
         {
            case _goldBtn:
               _currentList = _model.goldList;
               break;
            case _equipBtn:
               _currentList = _model.equipList;
               break;
            case _expBtn:
               _currentList = _model.expList;
               break;
            case _soulBtn:
               _currentList = _model.soulList;
               break;
            case _crystalBtn:
               _currentList = _model.crystalList;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GameGuideItem = null;
         cleanItemList();
         _loc2_ = 0;
         while(_loc2_ < _currentList.length)
         {
            _loc1_ = new GameGuideItem();
            _loc1_.data = _currentList[_loc2_];
            _itemVBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _scrollPanel.invalidateViewport();
      }
      
      private function cleanItemList() : void
      {
         if(_itemList == null)
         {
            return;
         }
         while(_itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_btnVBox);
         _btnVBox = null;
         ObjectUtils.disposeObject(_goldBtn);
         _goldBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_expBtn);
         _expBtn = null;
         ObjectUtils.disposeObject(_soulBtn);
         _soulBtn = null;
         ObjectUtils.disposeObject(_crystalBtn);
         _crystalBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         cleanItemList();
         _itemList = null;
         _currentList = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


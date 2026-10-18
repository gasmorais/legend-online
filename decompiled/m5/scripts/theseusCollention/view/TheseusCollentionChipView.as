package theseusCollention.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollenTionModel;
   import theseusCollention.item.SpliteCollectionFrame;
   import theseusCollention.item.TheseusCollentionBagCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class TheseusCollentionChipView extends Sprite
   {
      
      private var _bagScroll:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _selectedCell:TheseusCollentionBagCell;
      
      private var _type:int;
      
      private var _endPos:int = 0;
      
      protected var _leftbg:Bitmap;
      
      protected var _theseusCollection_RightBg:Bitmap;
      
      protected var _BigBg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _resolveBtn:IconButton;
      
      protected var _desc:FilterFrameText;
      
      protected var _quality:FilterFrameText;
      
      private var _formulaIcon:BaseItemView;
      
      private var _group:SelectedButtonGroup;
      
      public function TheseusCollentionChipView()
      {
         super();
         initView();
         refreshView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg1");
         _leftbg.y = 0;
         addChild(_leftbg);
         _list = ComponentFactory.Instance.creatCustomObject("TreasureBagView.SimpleTileList",[12]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("TheseusCollentionChipView.ScrollPanel");
         _bagScroll.setView(_list);
         _formulaIcon = ComponentFactory.Instance.creatCustomObject("TreasureCell.item");
         _theseusCollection_RightBg = ComponentFactory.Instance.creatBitmap("theseusCollection_RightBg");
         _BigBg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.BigBg1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.nameTxt");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.resolve");
         _quality = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.quality1");
         _desc = ComponentFactory.Instance.creatComponentByStylename("TheseusCollentionChipView.desc");
         _theseusCollection_RightBg.x = 620;
         _theseusCollection_RightBg.y = -40;
         _BigBg.x = 620;
         _BigBg.y = -50;
         _resolveBtn.visible = false;
         addChild(_bagScroll);
         addChild(_theseusCollection_RightBg);
         addChild(_BigBg);
         _BigBg.visible = false;
         addChild(_formulaIcon);
         _formulaIcon.visible = false;
         _formulaIcon.x = 710;
         _formulaIcon.y = 0;
         _formulaIcon.scaleX = _formulaIcon.scaleY = 1.2;
         addChild(_nameTxt);
         addChild(_resolveBtn);
         addChild(_quality);
         addChild(_desc);
         _nameTxt.x = 640;
         _nameTxt.y = 61;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,refreshView);
         _resolveBtn.addEventListener("click",_resolveClickHandler);
         _group.addEventListener("change",__onTabBtnHandler);
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         if(!_group)
         {
            return;
         }
         _selectedCell = _group.getSelectedItem() as TheseusCollentionBagCell;
         if(!_selectedCell)
         {
            _resolveBtn.visible = _formulaIcon.visible = _BigBg.visible = false;
            _quality.text = _nameTxt.text = _desc.htmlText = "";
            return;
         }
         _resolveBtn.visible = _BigBg.visible = _formulaIcon.visible = true;
         _resolveBtn.visible = true;
         _desc.htmlText = _selectedCell.data.templateInfo.Description;
         _BigBg.setFrame(_selectedCell.data.templateInfo.Profile - 2);
         _formulaIcon.data = _selectedCell.data;
         _nameTxt.text = _selectedCell.data.templateInfo.TemplateName;
         _quality.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.profile" + (_selectedCell.data.templateInfo.Profile - 2));
         _quality.textColor = model.color[_selectedCell.data.templateInfo.Profile - 3];
         _nameTxt.textColor = model.color[_selectedCell.data.templateInfo.Profile - 3];
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 212,refreshView);
         _resolveBtn.removeEventListener("click",_resolveClickHandler);
         _group.removeEventListener("change",__onTabBtnHandler);
      }
      
      private function _resolveClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:SpliteCollectionFrame = null;
         _formulaIcon.tipData = null;
         if(_selectedCell)
         {
            _loc2_ = _selectedCell.data;
            if(_loc2_)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("theseusCollention.item.SpliteCollectionFrame");
               _loc3_.data = _selectedCell.data;
               _loc3_.show();
            }
         }
      }
      
      public function refreshView(param1:Object = null) : void
      {
         var _loc7_:int = 0;
         var _loc6_:TheseusCollentionBagCell = null;
         var _loc2_:SimpleDictionary = TheseussoulManager.Instance.modelCollenTion.armorBagDic;
         var _loc3_:int = int(_loc2_.keys.length);
         _loc3_ = Math.ceil(_loc3_ / 12) * 12;
         var _loc5_:int = int(_loc3_ > 108 ? _loc3_ : 108);
         if(!_group)
         {
            _group = new SelectedButtonGroup();
            _group.addEventListener("change",__onTabBtnHandler);
         }
         _list.disposeAllChildren();
         _list.beginChanges();
         var _loc4_:int = int(_group ? _group.selectIndex : -1);
         if(_group)
         {
            _group.removeAllItem();
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("theseusCollention.item.TheseusCollentionBagCell");
            if(_loc7_ < _loc3_)
            {
               _loc6_.data = _loc2_[_loc2_.keys[_loc7_]];
               if(_loc6_.data)
               {
                  _group.addSelectItem(_loc6_);
               }
            }
            _list.addChild(_loc6_);
            _loc7_++;
         }
         if(_loc4_ != -1 && _loc4_ < _group.itemLength)
         {
            _group.selectIndex = _loc4_;
         }
         else
         {
            _group.selectIndex = -1;
         }
         __onTabBtnHandler(null);
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
      
      public function dispose() : void
      {
         removeEvent();
         if(_group)
         {
            _group.dispose();
            _group = null;
         }
         ObjectUtils.disposeAllChildren(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeAllChildren(_list);
         _list = null;
         ObjectUtils.disposeObject(_leftbg);
         _leftbg = null;
         ObjectUtils.disposeObject(_theseusCollection_RightBg);
         _theseusCollection_RightBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_quality);
         _quality = null;
         ObjectUtils.disposeObject(_formulaIcon);
         _formulaIcon = null;
         ObjectUtils.disposeObject(_selectedCell);
         _selectedCell = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


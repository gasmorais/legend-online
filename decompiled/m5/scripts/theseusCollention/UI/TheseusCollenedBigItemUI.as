package theseusCollention.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import utils.LogicUtils;
   
   public class TheseusCollenedBigItemUI extends Sprite
   {
      
      protected var _theseusCollection_suitDivider:Bitmap;
      
      protected var _SuitTitlebg:ScaleFrameImage;
      
      protected var _nameTxt2:FilterFrameText;
      
      protected var _theseusCollection_suitStorebottom:Bitmap;
      
      protected var _equipBox:HBox;
      
      private var _itemList:Vector.<TheseusCollentionItemUI>;
      
      private var _bagPanel:ScrollPanel;
      
      private var profile:int;
      
      public function TheseusCollenedBigItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _theseusCollection_suitDivider = ComponentFactory.Instance.creatBitmap("theseusCollection_suitDivider");
         _SuitTitlebg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.SuitTitlebg");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.nameTxt2");
         _theseusCollection_suitStorebottom = ComponentFactory.Instance.creatBitmap("theseusCollection_suitStorebottom");
         _equipBox = ComponentFactory.Instance.creatCustomObject("ui.TheseusCollention.Collenedequip");
         addChild(_theseusCollection_suitDivider);
         addChild(_SuitTitlebg);
         addChild(_nameTxt2);
         addChild(_theseusCollection_suitStorebottom);
         _bagPanel = ComponentFactory.Instance.creatComponentByStylename("TheseusCollenedBigItemUI.itemScroll");
         _bagPanel.setView(_equipBox);
         addChild(_bagPanel);
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc3_:TheseusCollentionItemUI = null;
         var _loc4_:int = 0;
         var _loc2_:TheseusCollentionItemUI = null;
         if(param1 && param1[0])
         {
            profile = param1[0].templeteInfo.Profile;
         }
         if(_SuitTitlebg)
         {
            _SuitTitlebg.setFrame(profile - 2);
         }
         if(_nameTxt2)
         {
            _nameTxt2.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.profile" + (profile - 2));
            _nameTxt2.textColor = TheseussoulManager.Instance.modelCollenTion.color[profile - 3];
         }
         if(_equipBox)
         {
            _equipBox.beginChanges();
            if(!_itemList)
            {
               _itemList = new Vector.<TheseusCollentionItemUI>();
            }
            while(_itemList.length > param1.length)
            {
               _loc2_ = _itemList.pop();
               _equipBox.removeChild(_loc2_);
               _loc2_.dispose();
            }
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               if(_loc4_ < _itemList.length)
               {
                  _loc3_ = _itemList[_loc4_];
               }
               else
               {
                  _loc3_ = new TheseusCollentionItemUI(1);
                  _itemList.push(_loc3_);
                  _equipBox.addChild(_loc3_);
               }
               _loc3_.data = param1[_loc4_];
               _loc4_++;
            }
            _equipBox.commitChanges();
         }
         if(_bagPanel)
         {
            _bagPanel.invalidateViewport();
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_theseusCollection_suitDivider);
         _theseusCollection_suitDivider = null;
         ObjectUtils.disposeObject(_SuitTitlebg);
         _SuitTitlebg = null;
         ObjectUtils.disposeObject(_nameTxt2);
         _nameTxt2 = null;
         ObjectUtils.disposeObject(_theseusCollection_suitStorebottom);
         _theseusCollection_suitStorebottom = null;
         ObjectUtils.disposeObject(_equipBox);
         _equipBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_bagPanel);
         _bagPanel = null;
      }
   }
}


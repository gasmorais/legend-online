package star
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.star.StarModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SharedManager;
   import yishi.manager.StarManager;
   
   public class AutoStarSetFrame extends Frame
   {
      
      private var _9cornerBg:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _autoCostGoldBmp:Bitmap;
      
      private var _autoSellBmp:Bitmap;
      
      private var _autoComposeBmp:Bitmap;
      
      private var _autoGoldComBox:ComboBox;
      
      private var _autoSellComBox:ComboBox;
      
      private var _autoComposeComBox:ComboBox;
      
      private var _confirmBtn:IconButton;
      
      private var _sprite:Sprite;
      
      public function AutoStarSetFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,320,250);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:* = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("star.AutoStarFrame.titleText");
         _9cornerBg = ComponentFactory.Instance.creatComponentByStylename("star.starAutoFramBg");
         _bg = ComponentFactory.Instance.creatBitmap("asset.star.autoStarSetFrame.bg");
         _autoCostGoldBmp = ComponentFactory.Instance.creatBitmap("asset.star.autoStarSetFrame.costGold");
         _autoSellBmp = ComponentFactory.Instance.creatBitmap("asset.star.autoStarSetFrame.sell");
         _autoComposeBmp = ComponentFactory.Instance.creatBitmap("asset.star.autoStarSetFrame.compose");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("star.AutoStarFrame.confirmBtn");
         _autoGoldComBox = ComponentFactory.Instance.creatComponentByStylename("star.AutoGoldComBox");
         _autoSellComBox = ComponentFactory.Instance.creatComponentByStylename("star.AutoSellComBox");
         _autoComposeComBox = ComponentFactory.Instance.creatComponentByStylename("star.AutoComposeComBox");
         _autoGoldComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.startFrame.gold1"));
         _autoGoldComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.startFrame.gold2"));
         _autoGoldComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.startFrame.gold3"));
         _autoSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.white")));
         _autoSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.green")));
         _autoSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.blue")));
         _autoComposeComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.purple")));
         _autoComposeComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.orange")));
         _autoComposeComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.red")));
         _sprite = new Sprite();
         addToContent(_9cornerBg);
         addToContent(_bg);
         addToContent(_sprite);
         _sprite.addChild(_autoCostGoldBmp);
         _sprite.addChild(_autoSellBmp);
         _sprite.addChild(_autoComposeBmp);
         _sprite.addChild(_autoGoldComBox);
         _sprite.addChild(_autoComposeComBox);
         _sprite.addChild(_autoSellComBox);
         _sprite.addChild(_confirmBtn);
      }
      
      private function initData() : void
      {
         if(_autoGoldComBox)
         {
            starModel.autoGoldType = SharedManager.instance.autoStarCostGold;
            _autoGoldComBox.listPanel.list.defaultSelectItemByCellValue = _autoGoldComBox.listPanel.vectorListModel.getElementAt(starModel.autoGoldType - 1);
         }
         if(_autoSellComBox)
         {
            starModel.autoSellType = SharedManager.instance.autoStarSell;
            _autoSellComBox.listPanel.list.defaultSelectItemByCellValue = _autoSellComBox.listPanel.vectorListModel.getElementAt(starModel.autoSellType - 1);
         }
         if(_autoComposeComBox)
         {
            starModel.autoComposeType = SharedManager.instance.autoStarCompose;
            _autoComposeComBox.listPanel.list.defaultSelectItemByCellValue = _autoComposeComBox.listPanel.vectorListModel.getElementAt(starModel.autoComposeType - 1);
         }
      }
      
      private function get starModel() : StarModel
      {
         return StarManager.instance.starModel;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SharedManager.instance.autoStarCostGold = _autoGoldComBox ? _autoGoldComBox.currentSelectedIndex + 1 : 1;
         SharedManager.instance.autoStarSell = _autoSellComBox ? _autoSellComBox.currentSelectedIndex + 1 : 1;
         SharedManager.instance.autoStarCompose = _autoComposeComBox ? _autoComposeComBox.currentSelectedIndex + 1 : 1;
         SharedManager.instance.saveAutoStarSet();
         dispose();
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      private function __cancelBtnHandler(param1:MouseEvent) : void
      {
         dispose();
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_autoGoldComBox);
         _autoGoldComBox = null;
         ObjectUtils.disposeObject(_autoSellComBox);
         _autoSellComBox = null;
         ObjectUtils.disposeObject(_autoComposeComBox);
         _autoComposeComBox = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_9cornerBg);
         _9cornerBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_autoCostGoldBmp);
         _autoCostGoldBmp = null;
         ObjectUtils.disposeObject(_autoSellBmp);
         _autoSellBmp = null;
         ObjectUtils.disposeObject(_autoComposeBmp);
         _autoComposeBmp = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
      }
   }
}

